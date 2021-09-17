#import <Cordova/CDV.h>
#import <FlyyFramework/FlyyFramework.h>

@interface FlyyPlugin : CDVPlugin

@property NSString *callbackId;

- (void)setAppPackage:(CDVInvokedUrlCommand *)command;
- (void)initSDK:(CDVInvokedUrlCommand *)command;
- (void)setUser:(CDVInvokedUrlCommand *)command;
- (void)setNewUser:(CDVInvokedUrlCommand *)command;
- (void)setUsername:(CDVInvokedUrlCommand *)command;
- (void)openOfferActivity:(CDVInvokedUrlCommand *)command;
- (void)openRewardsActivity:(CDVInvokedUrlCommand *)command;
- (void)openWalletActivity:(CDVInvokedUrlCommand *)command;
- (void)openGiftCardsActivity:(CDVInvokedUrlCommand *)command;
- (void)setUser:(CDVInvokedUrlCommand *)command;
- (void)setNewUser:(CDVInvokedUrlCommand *)command;
- (void)setUsername:(CDVInvokedUrlCommand *)command;
- (void)trackEvent:(CDVInvokedUrlCommand *)command;
- (void)sendNotificationReceived:(CDVInvokedUrlCommand *)command;
- (void)notificationClicked:(CDVInvokedUrlCommand *)command;
- (void)setContactNumber:(CDVInvokedUrlCommand *)command;
- (void)startStampActivity:(CDVInvokedUrlCommand *)command;
- (void)startReferralHistoryActivity:(CDVInvokedUrlCommand *)command;
- (void)startTournamentListActivity:(CDVInvokedUrlCommand *)command;
- (void)setRewardGridSpanCount:(CDVInvokedUrlCommand *)command;
- (void)openDeeplink:(CDVInvokedUrlCommand *)command;
- (void)setAppPackage:(CDVInvokedUrlCommand *)command;
- (void)handleNotification:(CDVInvokedUrlCommand *)command;
- (void)navigateToInviteAndEarnActivity:(CDVInvokedUrlCommand *)command;
- (void)navigateToCustomInviteAndEanActivity:(CDVInvokedUrlCommand *)command;
- (void)navigateToBonanzaActivity:(CDVInvokedUrlCommand *)command;
- (void)navigateToChallengeDetailActivity:(CDVInvokedUrlCommand *)command;
- (void)setThemeColor:(CDVInvokedUrlCommand *)command;
- (void)getShareData:(CDVInvokedUrlCommand *)command;
- (void)getReferralCount:(CDVInvokedUrlCommand *)command;
- (void)getScratchCardCount:(CDVInvokedUrlCommand *)command;
- (void)getPreviousLeaderboardWinners:(CDVInvokedUrlCommand *)command;
- (void)getLeaderboardParticipants:(CDVInvokedUrlCommand *)command;
- (void)getWalletBalance:(CDVInvokedUrlCommand *)command;
- (void)getReferrerDetails:(CDVInvokedUrlCommand *)command;
- (void)getOffersCount:(CDVInvokedUrlCommand *)command;
- (void)trackUIEvents:(CDVInvokedUrlCommand *)command;

@end
