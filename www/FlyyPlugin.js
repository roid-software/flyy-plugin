var exec = require('cordova/exec');

exports.initSdk = function (partner_token, enviroment, success, error) {
    exec(success, error, 'FlyyPlugin', 'intSdk', [partner_token, enviroment]);
};

exports.startOfferActivity = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'openOfferActivity', []);
};

exports.startRewardsActivity = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'openRewardsActivity', []);
};

exports.startWalletActivity = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'openWalletActivity', []);
};

exports.startGiftCardsActivity = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'openGiftCardsActivity', []);
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
