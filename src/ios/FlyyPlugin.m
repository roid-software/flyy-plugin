#import "Flyyplugin.h"
#import <FlyyFramework/FlyyFramework.h>

@interface FlyyPlugin ()<FlyySDKClosedListener> {
    Flyy *flyy;
//    NSString* sdkClosedCommand;
}

@end

@implementation FlyyPlugin

static NSString* sdkClosedCommand = nil;

- (void)setAppPackage: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* packageName = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (packageName != nil && packageName.length > 0 ) {
        [flyy setPackageWithPackageName:packageName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initSDK: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* partnerToken = [command.arguments objectAtIndex:0];
    NSString* environment = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (partnerToken != nil && partnerToken.length > 0 && environment != nil && environment.length > 0) {
        if ([environment  isEqual: @"stage"]) {
            [flyy initSDKWithPartnerToken:partnerToken environment: [flyy production]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else if ([environment  isEqual: @"production"]) {
            [flyy initSDKWithPartnerToken:partnerToken environment: [flyy production]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected enviroment variable as either 'stage' or 'production'."];
            
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUser: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* extUid = [command.arguments objectAtIndex:0];
    NSString* segmentId = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (extUid != nil && extUid.length > 0) {
        [flyy setUserWithExternalUserId:extUid segmentId:segmentId onComplete: ^(BOOL success) {
            if(success) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"false"];
            }
        }];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setNewUser: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* extUid = [command.arguments objectAtIndex:0];
    NSString* segmentId = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (extUid != nil && extUid.length > 0) {
        [flyy setNewUserWithExternalUserId:extUid segmentId:segmentId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUsername: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* userName = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (userName != nil && userName.length > 0) {
        [flyy setUserNameWithUserName:userName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openOfferActivity: (CDVInvokedUrlCommand *) command {
    sdkClosedCommand = command.callbackId;
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyy setSDKClosedListenerWithFlyysdkclosedlistener:self];
        [flyy openOffersPageWithSegmentId:segmentId];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:sdkClosedCommand];
        //        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openRewardsActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyy setSDKClosedListenerWithFlyysdkclosedlistener:self];
        [flyy setSegmentIdWithSegementId:segmentId];
        [flyy openRewardsPage];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openWalletActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyy setSDKClosedListenerWithFlyysdkclosedlistener:self];
        [flyy setSegmentIdWithSegementId:segmentId];
        [flyy openWalletPage];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openGiftCardsActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyy setSegmentIdWithSegementId:segmentId];
        [flyy openGiftCardsPage];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackEvent: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* key = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (key != nil && key.length > 0 && value != nil && value.length > 0) {
        [flyy sendEventWithKey:@"offers_page" value:@"opened" onComplete: ^(BOOL success) {
            if(success) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"false"];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
}

- (void)sendNotificationReceived: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* notificationId = [command.arguments objectAtIndex:0];
    NSString* offerId = [command.arguments objectAtIndex:1];
}

- (void)notificationClicked: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* notificationId = [command.arguments objectAtIndex:0];
    NSString* offerId = [command.arguments objectAtIndex:1];
    NSString* source = [command.arguments objectAtIndex:1];
}

//TODO
- (void)setContactNumber: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* contactNumber = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (contactNumber != nil && contactNumber.length > 0) {
        [flyy setContactNumberWithContactNumber:contactNumber];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)startStampActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* contactNumber = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (contactNumber != nil && contactNumber.length > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)startReferralHistoryActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* contactNumber = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (contactNumber != nil && contactNumber.length > 0) {
        [flyy openReferralHistoryPage];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)startTournamentListActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* contactNumber = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (contactNumber != nil && contactNumber.length > 0) {
        [flyy openTournamentsListPage];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)setRewardGridSpanCount: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* rewardsGridCount = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (rewardsGridCount != nil && rewardsGridCount.length > 0) {
        [flyy setRewardGridSpanCountWithCount:rewardsGridCount];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//Todo
- (void)openDeeplink: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* deepLink = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (deepLink != nil && deepLink.length > 0) {
        [flyy openDeepLinkWithAction:deepLink];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//TODO
- (void)handleNotification: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* userInfo = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (userInfo != nil && userInfo.length > 0) {
        [flyy handleNotificationWithUserInfo:userInfo];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)navigateToInviteAndEarnActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
}

- (void)navigateToCustomInviteAndEanActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* userInfo = [command.arguments objectAtIndex:0];
    
}

- (void)navigateToBonanzaActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
}

- (void)setThemeColor: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* colorPrimary = [command.arguments objectAtIndex:0];
    NSString* colorPrimaryDark = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    if (colorPrimary != nil && colorPrimary.length > 0 && colorPrimaryDark != nil && colorPrimaryDark.length > 0) {
        [flyy setThemeColorWithColorPrimary:colorPrimary colorPrimaryDark:colorPrimaryDark];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)getShareData: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* offerId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getShareDataOnComplete: ^(BOOL success, NSArray<NSString *> *referralDetails) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"referral_link": referralDetails[0],
                                          @"referral_message": referralDetails[1],
                                          @"share_message": referralDetails[2]
            };
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
    
}

- (void)getReferralCount: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getReferralCountOnComplete:^(BOOL success, NSInteger referralCount) {
        if (success) {
            NSString* referralCountStr = [NSString stringWithFormat:@"%ld", (long)referralCount];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralCountStr];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
    
}

- (void)getScratchCardCount: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getScratchCardCountOnComplete: ^(BOOL success, NSArray<NSNumber *> *scratchCardCountData) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"total_sc_count": scratchCardCountData[0],
                                          @"scratched_sc_count": scratchCardCountData[1],
                                          @"unscratched_sc_count": scratchCardCountData[2],
                                          @"locked_sc_count": scratchCardCountData[3]
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        
    }];
}

- (void)getPreviousLeaderboardWinners: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* tag = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getPreviousLeaderboardWinnersWithTag:tag onComplete:^(BOOL success, NSString* message, NSInteger participantsCount, NSString* winners, NSString* previousWinners) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"message": message,
                                          @"participants_count": @(participantsCount),
                                          @"winners": winners,
                                          @"previous_winners": previousWinners
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: message];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        
    }];
}

- (void)getLeaderboardParticipants: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* tag = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getPreviousLeaderboardWinnersWithTag:tag onComplete:^(BOOL success, NSString* message, NSInteger participantsCount, NSString* winners, NSString* previousWinners) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"message": message,
                                          @"participants_count": @(participantsCount),
                                          @"winners": winners,
                                          @"previous_winners": previousWinners
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: message];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        
    }];
    
}

- (void)getWalletBalance: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* walletLabel = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getWalletBalanceWithWalletLabel:walletLabel onComplete:^(BOOL success, NSArray<NSNumber *> *walletBalanceData) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"balance": walletBalanceData[0],
                                          @"total_credit": walletBalanceData[1],
                                          @"total_debit": walletBalanceData[2]
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
    
}

- (void)getReferrerDetails: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getReferrerDetailsOnComplete:^(BOOL success, NSArray<NSString *> *referrerDetailsData) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"name": referrerDetailsData[0],
                                          @"ext_uid": referrerDetailsData[1],
                                          @"extra_data": referrerDetailsData[2]
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data."];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
    
}

- (void)getOffersCount: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    flyy = [Flyy sharedFlyyInstance];
    
    [flyy getOffersCountOnComplete: ^(BOOL success, NSArray<NSNumber *> *offersCount) {
        if (success) {
            NSDictionary* jsonObject = @{ @"success": @true,
                                          @"live_offers_count": offersCount[0],
                                          @"participated_offers_count": offersCount[1]
            };
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data."];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void)trackUIEvents: (CDVInvokedUrlCommand *) command {
    
}


- (void)onSDKClosedWithScreenName:(NSString * _Nonnull)screenName {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:screenName];
    [pluginResult setKeepCallbackAsBool:NO];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:sdkClosedCommand];
    sdkClosedCommand = nil;
}

@end

