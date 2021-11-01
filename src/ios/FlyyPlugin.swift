import FlyyFramework

@objc (FlyyPlugin) class FlyyPlugin: CDVPlugin {
    
    @objc(intSdk:)
    func initSdk(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let partnerToken = (command.arguments[0] as? NSObject)?.value(forKey: "partner_token") as? String
        let environment = (command.arguments[1] as? NSObject)?.value(forKey: "environment") as? String
        
        if partnerToken != nil && !partnerToken!.isEmpty && environment != nil && !environment!.isEmpty {
            if environment == "stage" {
                Flyy.sharedInstance.initSDK(partnerToken: partnerToken!, environment: Flyy.FLYY_ENVIRONMENT_STAGING)
            } else if environment == "production" {
                Flyy.sharedInstance.initSDK(partnerToken: partnerToken!, environment: Flyy.FLYY_ENVIRONMENT_PRODUCTION)
            }
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected enviroment variable as either 'stage' or 'production'."
            )
        }
    }
    
    @objc(openOfferActivity:)
    func openOfferActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openOffersPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
        
    }
    
    @objc(openRewardsActivity:)
    func openRewardsActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openRewardsPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
        
    }
    
    @objc(openWalletActivity:)
    func openWalletActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openWalletPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(openGiftCardsActivity:)
    func openGiftCardsActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openGiftCardsPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(setUser:)
    func setUser(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let extUid = (command.arguments[0] as? NSObject)?.value(forKey: "ext_uid") as? String
        let segmentId = (command.arguments[1] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if extUid != nil && !extUid!.isEmpty {
            Flyy.sharedInstance.setUser(externalUserId: extUid!, segmentId: segmentId!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(setNewUser:)
    func setNewUser(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let extUid = (command.arguments[0] as? NSObject)?.value(forKey: "ext_uid") as? String
        
        if extUid != nil && !extUid!.isEmpty {
            Flyy.sharedInstance.setNewUser(externalUserId: extUid!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(setUsername:)
    func setUsername(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let userName = (command.arguments[0] as? NSObject)?.value(forKey: "user_name") as? String
        
        if userName != nil && !userName!.isEmpty {
            Flyy.sharedInstance.setUserName(userName: userName!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(trackEvent:)
    func trackEvent(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let key = (command.arguments[0] as? NSObject)?.value(forKey: "key") as? String
        let value = (command.arguments[1] as? NSObject)?.value(forKey: "value") as? String
        
        if key != nil && !key!.isEmpty && value != nil && !value!.isEmpty {
            Flyy.sharedInstance.sendEvent(key: key!, value: value!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected two non-empty string argument."
            )
        }
    }
    
    @objc(sendNotificationReceived:)
    func sendNotificationReceived(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(notificationClicked:)
    func notificationClicked(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(setContactNumber:)
    func setContactNumber(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(startStampActivity:)
    func startStampActivity(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(startReferralHistoryActivity:)
    func startReferralHistoryActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openReferralHistoryPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(startTournamentListActivity:)
    func startTournamentListActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let title = (command.arguments[0] as? NSObject)?.value(forKey: "title") as? String
        let segmentId = (command.arguments[1] as? NSObject)?.value(forKey: "segmentId") as? String
        
        if title != nil && !title!.isEmpty && segmentId != nil && !segmentId!.isEmpty {
            Flyy.sharedInstance.setSegmentId(segementId: segmentId!)
            Flyy.sharedInstance.openTournamentsListPage(navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected two non-empty string argument."
            )
        }
    }
    
    @objc(setRewardGridSpanCount:)
    func setRewardGridSpanCount(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(openDeeplink:)
    func openDeeplink(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(setAppPackage:)
    func setAppPackage(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let packageName = (command.arguments[0] as? NSObject)?.value(forKey: "package_name") as? String
        
        if packageName != nil && !packageName!.isEmpty {
            Flyy.sharedInstance.setPackage(packageName: packageName!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(handleNotification:)
    func handleNotification(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let remoteMessage = (command.arguments[0] as? NSObject)?.value(forKey: "remote_message") as? String
        
        if remoteMessage != nil && !remoteMessage!.isEmpty {
            Flyy.sharedInstance.handleNotification(userInfo: remoteMessage!, navigationController: self.viewController.navigationController!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
        
    }
    
    @objc(navigateToInviteAndEarnActivity:)
    func navigateToInviteAndEarnActivity(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(navigateToCustomInviteAndEanActivity:)
    func navigateToCustomInviteAndEanActivity(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let offerId = (command.arguments[0] as? NSObject)?.value(forKey: "offer_id") as? String
        let toolbasItemsColor = (command.arguments[1] as? NSObject)?.value(forKey: "toolbar_item_color") as? String
        
        if offerId != nil && !offerId!.isEmpty && toolbasItemsColor != nil && !toolbasItemsColor!.isEmpty {
            Flyy.sharedInstance.openFlyyCustomInviteAndEarnVC(navigationController: self.viewController.navigationController!, offerId: Int(offerId!)!, headerColor: toolbasItemsColor!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected two non-empty string argument."
            )
        }
    }
    
    @objc(setThemeColor:)
    func setThemeColor(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let colorPrimary = (command.arguments[0] as? NSObject)?.value(forKey: "color_primary") as? String
        let colorPrimaryDark = (command.arguments[1] as? NSObject)?.value(forKey: "color_primary_dark") as? String
        
        if colorPrimary != nil && !colorPrimary!.isEmpty && colorPrimaryDark != nil && !colorPrimaryDark!.isEmpty {
            Flyy.sharedInstance.setThemeColor(colorPrimary: colorPrimary!, colorPrimaryDark: colorPrimaryDark!)
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: "true"
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected two non-empty string argument."
            )
        }
    }
    
    @objc(getShareData:)
    func getShareData(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let offerId = (command.arguments[0] as? NSObject)?.value(forKey: "offer_id") as? String
        
        if offerId != nil && !offerId!.isEmpty {
            Flyy.sharedInstance.getShareData(onComplete: { (success, referralDetails) -> Void in
                if(success) {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_OK,
                        messageAs: referralDetails
                    )
                } else {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_ERROR,
                        messageAs: referralDetails
                    )
                }
            })
            
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(getReferralCount:)
    func getReferralCount(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        Flyy.sharedInstance.getReferralCount(onComplete: {(success, referralCount) -> Void in
            if(success) {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAs: referralCount
                )
            } else {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: "Failed to fetch data."
                )
            }
        })
    }
    
    @objc(getScratchCardCount:)
    func getScratchCardCount(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        Flyy.sharedInstance.getScratchCardCount(onComplete: {
            (success, scratchCardCountData) -> Void in
            if(success) {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAs: scratchCardCountData
                )
            } else {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: scratchCardCountData
                )
            }
        })
    }
    
    @objc(getPreviousLeaderboardWinners:)
    func getPreviousLeaderboardWinners(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let tag = (command.arguments[0] as? NSObject)?.value(forKey: "tag") as? String
        
        if tag != nil && !tag!.isEmpty {
            Flyy.sharedInstance.getPreviousLeaderboardWinners(tag: tag!, onComplete: {
                (success, message, participantsCount, winnersArray, previousWinnersArray) -> Void in
                if(success) {
                    let data = [participantsCount, winnersArray, previousWinnersArray] as [Any]
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_OK,
                        messageAs: data
                    )
                } else {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_ERROR,
                        messageAs: message
                    )
                }
            })
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(getLeaderboardParticipants:)
    func getLeaderboardParticipants(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let tag = (command.arguments[0] as? NSObject)?.value(forKey: "tag") as? String
        
        if tag != nil && !tag!.isEmpty {
            Flyy.sharedInstance.getLeaderboardParticipants(tag: tag!, onComplete: {
                (success, message, participantsCount, winnersArray, previousWinnersArray) -> Void in
                if(success) {
                    let data = [participantsCount, winnersArray, previousWinnersArray] as [Any]
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_OK,
                        messageAs: data
                    )
                } else {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_ERROR,
                        messageAs: message
                    )
                }
            })
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(getWalletBalance:)
    func getWalletBalance(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        let walletLabel = (command.arguments[0] as? NSObject)?.value(forKey: "wallet_label") as? String
        
        if walletLabel != nil && !walletLabel!.isEmpty {
            Flyy.sharedInstance.getWalletBalance(walletLabel: walletLabel!, onComplete: {
                (success, walletBalanceData) -> Void in
                if(success) {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_OK,
                        messageAs: walletBalanceData
                    )
                } else {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_ERROR,
                        messageAs: walletBalanceData
                    )
                }
            })
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: "Expected one non-empty string argument."
            )
        }
    }
    
    @objc(getReferrerDetails:)
    func getReferrerDetails(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        Flyy.sharedInstance.getReferrerDetails(onComplete: {
            (success, referrerData) -> Void in
            if(success) {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAs: referrerData
                )
            } else {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: referrerData
                )
            }
        })
    }
    
    @objc(trackUIEvents:)
    func trackUIEvents(command: CDVInvokedUrlCommand) {
        
    }
}
