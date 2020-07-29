var exec = require('cordova/exec');

exports.initSdk = function (partner_token, success, error) {
    exec(success, error, 'FlyyPlugin', 'intSdk', [partner_token]);
};

exports.startOfferActivity = function (success, error) {
    exec(success, error, 'FlyyPlugin', 'openOfferActivity', []);
};

exports.setExtUid = function (ext_uid, success, error) {
    exec(success, error, 'FlyyPlugin', 'setExtUid', [ext_uid]);
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
