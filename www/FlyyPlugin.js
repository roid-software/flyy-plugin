var exec = require('cordova/exec');

exports.initSdk = function (partner_token, enviroment, success, error) {
    exec(success, error, 'FlyyPlugin', 'intSdk', [partner_token, enviroment]);
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

exports.setUser = function (ext_uid,segmentId, success, error) {
    exec(success, error, 'FlyyPlugin', 'setUser', [ext_uid,segmentId]);
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