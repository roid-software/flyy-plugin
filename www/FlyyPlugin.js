    var exec = require('cordova/exec');

    exports.initSdk = function (partner_token, enviroment, success, error) {
        exec(success, error, 'FlyyPlugin', 'initSDK', [partner_token, enviroment]);
    };

    exports.startOfferActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'openOfferActivity', [segmentId]);
    };

    exports.startRewardsActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'openRewardsActivity', [segmentId]);
    };

    exports.startWalletActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'openWalletActivity', [segmentId]);
    };

    exports.startGiftCardsActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'openGiftCardsActivity', [segmentId]);
    };

    exports.setUser = function (ext_uid,includeReferralCode,segmentId, success, error) {
        exec(success, error, 'FlyyPlugin', 'setUser', [ext_uid,includeReferralCode,segmentId]);
    };

    exports.setNewUser = function (ext_uid, success, error) {
        exec(success, error, 'FlyyPlugin', 'setNewUser', [ext_uid]);
    };

    exports.setUsername = function (user_name, success, error) {
        exec(success, error, 'FlyyPlugin', 'setUsername', [user_name]);
    };

    exports.trackEvent = function (key, value, success, error) {
        exec(success, error, 'FlyyPlugin', 'trackEvent', [key, value]);
    };

    exports.trackEventJson = function (key, jsonObj, success, error) {
        exec(success, error, 'FlyyPlugin', 'trackEvent', [key, JSON.stringify(jsonObj)]);
    };
    exports.setContactNumber = function (key,success, error) {
        exec(success, error, 'FlyyPlugin', 'setContactNumber', [key]);
    };
    exports.startStampActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'startStampActivity', [segmentId]);
    };
    exports.startReferralHistoryActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'startReferralHistoryActivity', [segmentId]);
    };
    exports.startTournamentListActivity = function (title,segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'startTournamentListActivity', [title,segmentId]);
    };
    exports.setRewardGridSpanCount = function (gridSpanCount,success, error) {
        exec(success, error, 'FlyyPlugin', 'setRewardGridSpanCount', [gridSpanCount]);
    };
    exports.openDeeplink = function (action,success, error) {
        exec(success, error, 'FlyyPlugin', 'openDeeplink', [action]);
    };
    exports.setAppPackage = function (packageName,success, error) {
        exec(success, error, 'FlyyPlugin', 'setAppPackage', [packageName]);
    };
    exports.handleNotification = function (remoteMessage,success, error) {
        exec(success, error, 'FlyyPlugin', 'handleNotification', [remoteMessage]);
    };
    exports.navigateToInviteAndEarnActivity = function (offerId, success, error) {
        exec(success, error, 'FlyyPlugin', 'navigateToInviteAndEarnActivity', [offerId]);
    };
    exports.navigateToCustomInviteAndEanActivity = function (offerId, toolbarItemsColor, success, error) {
        exec(success, error, 'FlyyPlugin', 'navigateToCustomInviteAndEanActivity', [offerId, toolbarItemsColor]);
    };
    exports.navigateToBonanzaActivity = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'navigateToBonanzaActivity', []);
    };
    exports.navigateToChallengeDetailActivity = function (offerId, success, error) {
        exec(success, error, 'FlyyPlugin', 'navigateToChallengeDetailActivity', [offerId]);
    };
    exports.setThemeColor = function (colorPrimary, colorPrimaryDark, success, error) {
        exec(success, error, 'FlyyPlugin', 'setThemeColor', [colorPrimary, colorPrimaryDark]);
    };
    exports.getShareData = function (offerId, success, error) {
        exec(success, error, 'FlyyPlugin', 'getShareData', [offerId]);
    };
    exports.getReferralCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getReferralCount', []);
    };
    exports.getScratchCardCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getScratchCardCount', []);
    };
    exports.getPreviousLeaderboardWinners = function (tag, success, error) {
        exec(success, error, 'FlyyPlugin', 'getPreviousLeaderboardWinners', [tag]);
    };
    exports.getLeaderboardParticipants = function (tag, success, error) {
        exec(success, error, 'FlyyPlugin', 'getLeaderboardParticipants', [tag]);
    };
    exports.getWalletBalance = function (walletLabel, success, error) {
        exec(success, error, 'FlyyPlugin', 'getWalletBalance', [walletLabel]);
    };
    exports.getReferrerDetails = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getReferrerDetails', []);
    };
    exports.getOffersCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getOffersCount', []);
    };
    exports.trackUIEvents = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'trackUIEvents', []);
    };
    exports.onFlyySDKClosed = function (success) {
        exec(success, 'FlyyPlugin', 'onSDKClosedWithScreenName', []);
    }
    exports.handleForeGroundNotification = function (remoteMessage,success, error) {
        exec(success, error, 'FlyyPlugin', 'handleForeGroundNotification', [remoteMessage]);
    };
    exports.handleBackGroundNotification = function (remoteMessage,success, error) {
        exec(success, error, 'FlyyPlugin', 'handleBackGroundNotification', [remoteMessage]);
    };
    exports.sendFCMTokenToServer = function (remoteMessage,success, error) {
        exec(success, error, 'FlyyPlugin', 'sendFCMTokenToServer', [remoteMessage]);
    };
    exports.handleDeeplink = function (deeplink,success, error) {
        exec(success, error, 'FlyyPlugin', 'handleDeeplink', [deeplink]);
    };
    exports.updateUsername = function (user_name,success, error) {
        exec(success, error, 'FlyyPlugin', 'updateUsername', [user_name]);
    };
    exports.loginUser = function (ext_uid, user_name,success, error) {
        exec(success, error, 'FlyyPlugin', 'loginUser', [ext_uid, user_name]);
    };
    exports.loginUserWithCallback = function (ext_uid, user_name,success, error) {
        exec(success, error, 'FlyyPlugin', 'loginUserWithCallback', [ext_uid, user_name]);
    };
    exports.initWithReferrerReceivedCallback = function (partner_id, enviroment,success, error) {
        exec(success, error, 'FlyyPlugin', 'initWithReferrerReceivedCallback', [partner_id, enviroment]);
    };
    exports.getTotalSCCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getTotalSCCount', []);
    };
    exports.getScratchedSCCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getScratchedSCCount', []);
    };
    exports.getUnscratchedSCCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getUnscratchedSCCount', []);
    };
    exports.getLockedSCCount = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'getLockedSCCount', []);
    };
    exports.setBaseFlyyDomain = function (domain,success, error) {
        exec(success, error, 'FlyyPlugin', 'setBaseFlyyDomain', [domain]);
    };
    exports.setBaseStageFlyyDomain = function (domain,success, error) {
        exec(success, error, 'FlyyPlugin', 'setBaseStageFlyyDomain', [domain]);
    };
    exports.startReferAndEarnActivity = function (success, error) {
        exec(success, error, 'FlyyPlugin', 'startReferAndEarnActivity', []);
    };
    exports.startCheckInActivity = function (segmentId,success, error) {
        exec(success, error, 'FlyyPlugin', 'startCheckInActivity', [segmentId]);
    };
    exports.startRetailerIncentiveApp = function (partnerId,userToken,themeColor,url,success, error) {
        exec(success, error, 'FlyyPlugin', 'startRetailerIncentiveApp', [partnerId,userToken,themeColor,url]);
    };
    exports.setCustomFontName = function (regularFont,mediumFont,boldFont,success, error) {
        exec(success, error, 'FlyyPlugin', 'setCustomFontName', [regularFont,mediumFont,boldFont]);
    };
    exports.setBankDetails = function (number,ifsc,name,success, error) {
        exec(success, error, 'FlyyPlugin', 'setBankDetails', [number,ifsc,name]);
    };
    exports.setUpi = function (upiId,success, error) {
        exec(success, error, 'FlyyPlugin', 'setUpi', [upiId]);
    };
