#import "Flyyplugin.h"

@implementation FlyyPlugin

- (void)setAppPackage: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* packageName = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (packageName != nil && packageName.length > 0 ) {
        [flyyInstance setPackageWithPackageName:packageName];
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
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (partnerToken != nil && partnerToken.length > 0 && environment != nil && environment.length > 0) {
        if ([environment  isEqual: @"stage"]) {
            [flyyInstance initSDKWithPartnerToken:partnerToken environment: [flyyInstance production]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else if ([environment  isEqual: @"production"]) {
            [flyyInstance initSDKWithPartnerToken:partnerToken environment: [flyyInstance production]];
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
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (extUid != nil && extUid.length > 0) {
        [flyyInstance setUserWithExternalUserId:extUid segmentId:segmentId onComplete: ^(BOOL success) {
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
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (extUid != nil && extUid.length > 0) {
        [flyyInstance setNewUserWithExternalUserId:extUid segmentId:segmentId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUsername: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* userName = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (userName != nil && userName.length > 0) {
        [flyyInstance setUserNameWithUserName:userName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// - (void)openOfferActivity: (CDVInvokedUrlCommand *) command {
//     CDVPluginResult* pluginResult = nil;
//     NSString* segmentId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (segmentId != nil && segmentId.length > 0) {
//         [flyyInstance setSegmentIdWithSegementId:segmentId];
//         [self naviagteToPage:@"Loading Offers..." :@"https://web-sdk.theflyy.com/" :segmentId];
//         //        [flyyInstance openOffersPageWithNavigationController:self.viewController.navigationController  segmentId:segmentId];
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

// - (void)openRewardsActivity: (CDVInvokedUrlCommand *) command {
//     CDVPluginResult* pluginResult = nil;
//     NSString* segmentId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (segmentId != nil && segmentId.length > 0) {
//         [flyyInstance setSegmentIdWithSegementId:segmentId];
//         [self naviagteToPage:@"Loading Offers..." :@"https://web-sdk.theflyy.com/" :segmentId];
//         //        [flyyInstance openOffersPageWithNavigationController:self.viewController.navigationController  segmentId:segmentId];
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

// - (void)openWalletActivity: (CDVInvokedUrlCommand *) command {
//     CDVPluginResult* pluginResult = nil;
//     NSString* segmentId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (segmentId != nil && segmentId.length > 0) {
//         [flyyInstance setSegmentIdWithSegementId:segmentId];
//         [self naviagteToPage:@"Loading Offers..." :@"https://web-sdk.theflyy.com/" :segmentId];
//         //        [flyyInstance openOffersPageWithNavigationController:self.viewController.navigationController  segmentId:segmentId];
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

// - (void)openGiftCardsActivity: (CDVInvokedUrlCommand *) command {
//     CDVPluginResult* pluginResult = nil;
//     NSString* segmentId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (segmentId != nil && segmentId.length > 0) {
//         [flyyInstance setSegmentIdWithSegementId:segmentId];
//         [self naviagteToPage:@"Loading Offers..." :@"https://web-sdk.theflyy.com/" :segmentId];
//         //        [flyyInstance openOffersPageWithNavigationController:self.viewController.navigationController  segmentId:segmentId];
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

// - (void)trackEvent: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* key = [command.arguments objectAtIndex:0];
//     NSString* value = [command.arguments objectAtIndex:1];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (key != nil && key.length > 0 && value != nil && value.length > 0) {
//         [flyyInstance sendEventWithKey:@"offers_page" value:@"opened" onComplete: ^(BOOL success) {
//             if(success) {
//                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//             } else {
//                 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"false"];
//             }
//         }];
        
        
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

// - (void)sendNotificationReceived: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* notificationId = [command.arguments objectAtIndex:0];
//     NSString* offerId = [command.arguments objectAtIndex:1];
// }

// - (void)notificationClicked: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* notificationId = [command.arguments objectAtIndex:0];
//     NSString* offerId = [command.arguments objectAtIndex:1];
//     NSString* source = [command.arguments objectAtIndex:1];
// }

//TODO
// - (void)setContactNumber: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* contactNumber = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (contactNumber != nil && contactNumber.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)startStampActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* contactNumber = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (contactNumber != nil && contactNumber.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)startReferralHistoryActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* contactNumber = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (contactNumber != nil && contactNumber.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)startTournamentListActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* contactNumber = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (contactNumber != nil && contactNumber.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)setRewardGridSpanCount: (CDVInvokedUrlCommand *) command {
    
// }

//Todo
// - (void)openDeeplink: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* contactNumber = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     if (contactNumber != nil && contactNumber.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

//TODO
// - (void)handleNotification: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* userInfo = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     //    [flyyInstance handleNotificationWithUserInfo:userInfo navigationController:<#(UINavigationController * _Nonnull)#>]
//     if (userInfo != nil && userInfo.length > 0) {
//         //        [flyyInstance setContac]
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
//     } else {
//         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
//     }
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)navigateToInviteAndEarnActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
    
// }

// - (void)navigateToCustomInviteAndEanActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* userInfo = [command.arguments objectAtIndex:0];
    
// }

// - (void)navigateToBonanzaActivity: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
    
// }

- (void)setThemeColor: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* colorPrimary = [command.arguments objectAtIndex:0];
    NSString* colorPrimaryDark = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    if (colorPrimary != nil && colorPrimary.length > 0 && colorPrimaryDark != nil && colorPrimaryDark.length > 0) {
        [flyyInstance setThemeColorWithColorPrimary:colorPrimary colorPrimaryDark:colorPrimaryDark];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

// - (void)getShareData: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* offerId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getShareDataOnComplete: ^(BOOL success, NSArray<NSString *> *referralDetails) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"referral_link": referralDetails[0],
//                                           @"referral_message": referralDetails[1],
//                                           @"share_message": referralDetails[2]
//             };
            
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
//         }
//     }];
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getReferralCount: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* offerId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getReferralCountOnComplete:^(BOOL success, NSInteger referralCount) {
//         if (success) {
//             NSString* referralCountStr = [NSString stringWithFormat:@"%ld", (long)referralCount];

//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:referralCountStr];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
//         }
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getScratchCardCount: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getScratchCardCountOnComplete: ^(BOOL success, NSArray<NSNumber *> *scratchCardCountData) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"total_sc_count": scratchCardCountData[0],
//                                           @"scratched_sc_count": scratchCardCountData[1],
//                                           @"unscratched_sc_count": scratchCardCountData[2],
//                                           @"locked_sc_count": scratchCardCountData[3]
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch the data"];
//         }
        
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getPreviousLeaderboardWinners: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* tag = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getPreviousLeaderboardWinnersWithTag:tag onComplete:^(BOOL success, NSString* message, NSInteger participantsCount, NSString* winners, NSString* previousWinners) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"message": message,
//                                           @"participants_count": @(participantsCount),
//                                           @"winners": winners,
//                                           @"previous_winners": previousWinners
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: message];
//         }
        
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getLeaderboardParticipants: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* tag = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getPreviousLeaderboardWinnersWithTag:tag onComplete:^(BOOL success, NSString* message, NSInteger participantsCount, NSString* winners, NSString* previousWinners) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"message": message,
//                                           @"participants_count": @(participantsCount),
//                                           @"winners": winners,
//                                           @"previous_winners": previousWinners
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: message];
//         }
        
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getWalletBalance: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* walletLabel = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getWalletBalanceWithWalletLabel:walletLabel onComplete:^(BOOL success, NSArray<NSNumber *> *walletBalanceData) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"balance": walletBalanceData[0],
//                                           @"total_credit": walletBalanceData[1],
//                                           @"total_debit": walletBalanceData[2]
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data"];
//         }
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getReferrerDetails: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* tag = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getReferrerDetailsOnComplete:^(BOOL success, NSArray<NSString *> *referrerDetailsData) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"name": referrerDetailsData[0],
//                                           @"ext_uid": referrerDetailsData[1],
//                                           @"extra_data": referrerDetailsData[2]
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data."];
//         }
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

// - (void)getOffersCount: (CDVInvokedUrlCommand *) command {
//     __block CDVPluginResult* pluginResult = nil;
//     NSString* offerId = [command.arguments objectAtIndex:0];
    
//     Flyy *flyyInstance = [[Flyy alloc] init];
    
//     [flyyInstance getOffersCountOnComplete: ^(BOOL success, NSArray<NSNumber *> *offersCount) {
//         if (success) {
//             NSDictionary* jsonObject = @{ @"success": @true,
//                                           @"live_offers_count": offersCount[0],
//                                           @"participated_offers_count": offersCount[1]
//             };
//             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            
            
//             NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//         } else {
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Could not fetch data."];
//         }
//     }];
    
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
// }

- (void)trackUIEvents: (CDVInvokedUrlCommand *) command {
    
}

@end

