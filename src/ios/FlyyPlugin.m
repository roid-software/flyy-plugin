#import "Flyyplugin.h"
#import <FlyyFramework/FlyyFramework.h>

@interface FlyyPlugin ()<FlyySDKClosedListener> {
    Flyy *flyy;
    //    NSString* sdkClosedCommand;
}

@end

@implementation FlyyPlugin

static NSString* sdkClosedCommand = nil;

//set package name
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

//init sdk
- (void)initSDK: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* partnerToken = [command.arguments objectAtIndex:0];
    NSString* environment = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (partnerToken != nil && partnerToken.length > 0 && environment != nil && environment.length > 0) {
        if ([environment isEqual: @"stage"]) {
            [flyy initSDKWithPartnerToken:partnerToken environment: [flyy staging]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else if ([environment isEqual: @"production"]) {
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

//initWithReferrerReceivedCallback sdk
- (void)initWithReferrerReceivedCallback: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* partnerToken = [command.arguments objectAtIndex:0];
    NSString* environment = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (partnerToken != nil && partnerToken.length > 0 && environment != nil && environment.length > 0) {
        if ([environment isEqual: @"stage"]) {
             [flyy initSDKWithPartnerToken:partnerToken environment: [flyy  staging] onComplete: ^(BOOL success, NSString * referralData) {
              if(success) 
              {
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralData];
              }
              else
              {
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralData];
              }
             }];
        } 
        else if ([environment isEqual: @"production"]) {
            [flyy initSDKWithPartnerToken:partnerToken environment: [flyy  production] onComplete: ^(BOOL success, NSString * referralData) {
              if(success) 
              {
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralData];
              }
              else
              {
                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralData];
              }
             }];
        }
         else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected enviroment variable as either 'stage' or 'production'."];
            
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//set user
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

//set new user
- (void)setNewUser: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* extUid = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (extUid != nil && extUid.length > 0) {
        [flyy setNewUserWithExternalUserId:extUid];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//ser user name
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

//open offers page
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

//open rewards page
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

//open wallet page
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

//open gift cards page
- (void)openGiftCardsActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyy setSegmentIdWithSegementId:segmentId];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                
                [self->flyy openGiftCardPage];
            });
        });
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//send event
- (void)trackEvent: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* key = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (key != nil && key.length > 0 && value != nil) {
        [flyy sendEventWithKey:key value:value onComplete: ^(BOOL success) {
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

//send event with json
- (void)trackEventJson: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* key = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (key != nil && key.length > 0 && value != nil) {
        [flyy sendEventWithKey:key value:value onComplete: ^(BOOL success) {
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

//set contact number
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
    CDVPluginResult* pluginResult = nil;
}

//open referral history page
- (void)startReferralHistoryActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    
    flyy = [Flyy sharedFlyyInstance];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [self->flyy openReferralHistoryPage];
        });
    });
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//open tournament list page
- (void)startTournamentListActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    flyy = [Flyy sharedFlyyInstance];
    [flyy openTournamentsListPage];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//set rewards grid span
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

//open deep link
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

//handle foreground notifi
- (void)handleForeGroundNotification: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* remoteMessageString = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (remoteMessageString != nil && remoteMessageString.length > 0) {
        NSError * err;
        NSData *data = [remoteMessageString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * userInfo;
        if(data!=nil){
            userInfo = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        }
        
        [flyy handleBackgroundNotificationWithUserInfo: userInfo];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//handle backgroun notifi
- (void)handleBackGroundNotification: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* remoteMessageString = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (remoteMessageString != nil && remoteMessageString.length > 0) {
        NSError * err;
        NSData *data = [remoteMessageString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * userInfo;
        if(data!=nil){
            userInfo = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        }
        [flyy handleBackgroundNotificationWithUserInfo: userInfo];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//open invite and earn page
- (void)navigateToInviteAndEarnActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    NSString* offerIdStr = [command.arguments objectAtIndex:0];
    NSInteger offerId = [offerIdStr integerValue];
    
    flyy = [Flyy sharedFlyyInstance];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [self->flyy openInviteAndEarnPageWithOfferId:offerId];
        });
    });
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//open custom invite and earn page
- (void)navigateToCustomInviteAndEanActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* offerIdStr = [command.arguments objectAtIndex:0];
    NSInteger offerId = [offerIdStr integerValue];
    NSString* headerColor = [command.arguments objectAtIndex:1];
    
    flyy = [Flyy sharedFlyyInstance];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [self->flyy openFlyyCustomInviteAndEarnVCWithOfferId:offerId headerColor:headerColor];
        });
    });
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)navigateToChallengeDetailActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    
    NSString* offerIdStr = [command.arguments objectAtIndex:0];
    NSInteger offerId = [offerIdStr integerValue];
    
    flyy = [Flyy sharedFlyyInstance];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [self->flyy openFlyyChallengesPageWithOfferId:offerId];
        });
    });
    
}

- (void)navigateToBonanzaActivity: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    flyy = [Flyy sharedFlyyInstance];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [self->flyy openBonanzaPage];
        });
    });
}

//set theme colors
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

//get share data
- (void)getShareData: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* offerIdStr = [command.arguments objectAtIndex:0];
    NSInteger offerId = [offerIdStr integerValue];
    
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

//get referral count
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

//get scratcg card count
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

//get previous board winners
- (void)getPreviousLeaderboardWinners: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* tag = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (tag != nil && tag.length > 0) {
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
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

//get leaderboard participants
- (void)getLeaderboardParticipants: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* tag = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (tag != nil && tag.length > 0) {
        [flyy getLeaderboardParticipantsWithTag:tag onComplete:^(BOOL success, NSString* message, NSInteger participantsCount, NSString* winners, NSString* previousWinners) {
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
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
}

//get wallet balance
- (void)getWalletBalance: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* walletLabel = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (walletLabel != nil && walletLabel.length > 0) {
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
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

//get referrer details data
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

//get  offers count
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

//send fcm token to server
- (void)sendFCMTokenToServer: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* fcmToken = [command.arguments objectAtIndex:0];
    
    flyy = [Flyy sharedFlyyInstance];
    
    if (fcmToken != nil && fcmToken.length > 0) {
        [flyy sendFcmTokenToServerWithFcmToken:fcmToken];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Expected one argument"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)onSDKClosedWithScreenName:(NSString * _Nonnull)screenName {
    CDVPluginResult *result =
    [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                      messageAsString:screenName];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    
    //    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:screenName];
    //
    //    [self.commandDelegate sendPluginResult:pluginResult callbackId:sdkClosedCommand];
    //    [pluginResult setKeepCallbackAsBool:NO];
    //    sdkClosedCommand = nil;
}

@end

