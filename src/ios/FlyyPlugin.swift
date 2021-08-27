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
        
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segment_id") as? String
        
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
        
    }
    
    @objc(openWalletActivity:)
    func openWalletActivity(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(openGiftCardsActivity:)
    func openGiftCardsActivity(command: CDVInvokedUrlCommand) {
        
    }
    
    @objc(setUser:)
    func setUser(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
          status: CDVCommandStatus_ERROR
        )
        
        let extUid = (command.arguments[0] as? NSObject)?.value(forKey: "ext_uid") as? String
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segment_id") as? String
        
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
        let segmentId = (command.arguments[0] as? NSObject)?.value(forKey: "segment_id") as? String
        
        if extUid != nil && !extUid!.isEmpty {
            Flyy.sharedInstance.setNewUser(externalUserId: extUid!, segmentId: segmentId!)
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
            Flyy.sharedInstance.setUserName(userName: userName!))
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
    
    }
    
    @objc(startTournamentListActivity:)
    func startTournamentListActivity(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(setRewardGridSpanCount:)
    func setRewardGridSpanCount(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(openDeeplink:)
    func openDeeplink(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(setAppPackage:)
    func setAppPackage(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(handleNotification:)
    func handleNotification(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(navigateToInviteAndEarnActivity:)
    func navigateToInviteAndEarnActivity(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(navigateToCustomInviteAndEanActivity:)
    func navigateToCustomInviteAndEanActivity(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(setThemeColor:)
    func setThemeColor(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getShareData:)
    func getShareData(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getReferralCount:)
    func getReferralCount(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getScratchCardCount:)
    func getScratchCardCount(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getPreviousLeaderboardWinners:)
    func getPreviousLeaderboardWinners(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getLeaderboardParticipants:)
    func getLeaderboardParticipants(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getWalletBalance:)
    func getWalletBalance(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(getReferrerDetails:)
    func getReferrerDetails(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(trackUIEvents:)
    func trackUIEvents(command: CDVInvokedUrlCommand) {
    
    }
}
