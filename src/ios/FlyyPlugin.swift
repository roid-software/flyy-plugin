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
                pluginResult = CDVPluginResult(
                  status: CDVCommandStatus_OK,
                  messageAs: "true"
                )
            } else if environment == "production" {
                Flyy.sharedInstance.initSDK(partnerToken: partnerToken!, environment: Flyy.FLYY_ENVIRONMENT_PRODUCTION)
                pluginResult = CDVPluginResult(
                  status: CDVCommandStatus_ERROR,
                  messageAs: "Expected enviroment variable as either 'stage' or 'production'."
                )
            }
        }
    }
    
    @objc(openOfferActivity:)
    func openOfferActivity(command: CDVInvokedUrlCommand) {
        
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
        
    }
    
    @objc(setNewUser:)
    func setNewUser(command: CDVInvokedUrlCommand) {
    
    }
    
    @objc(setUsername:)
    func setUsername(command: CDVInvokedUrlCommand) {
    
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
