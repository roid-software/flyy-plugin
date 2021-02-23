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

exports.setUser = function (ext_uid, success, error) {
    exec(success, error, 'FlyyPlugin', 'setUser', [ext_uid]);
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

exports.checkAppInfo = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'checkAppInfo', []);
};
exports.sendEventFromWorker = function (key, value,success, error) {
    exec(success, error, 'FlyyPlugin', 'sendEventFromWorker', [key,value]);
};
exports.sendNotificationDataToBackend = function (messageId, offer_id,action,source,success, error) {
    exec(success, error, 'FlyyPlugin', 'sendNotificationDataToBackend', [messageId,offer_id,action,source]);
};
exports.setUserData = function (key, value,success, error) {
    exec(success, error, 'FlyyPlugin', 'setUserData', [key,value]);
};