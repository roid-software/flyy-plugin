package cordova.plugin.theflyy;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
// import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.firebase.messaging.RemoteMessage;
import com.google.gson.Gson;

import android.content.Intent;
import android.content.Context;

import theflyy.com.flyy.views.FlyyOffersActivity;
import theflyy.com.flyy.Flyy;
import theflyy.com.flyy.helpers.FlyyUtility;

//import com.google.firebase.messaging.RemoteMessage;

import theflyy.com.flyy.helpers.FlyyNotificationHandler;
import theflyy.com.flyy.helpers.FlyyReferralDataFetchedListener;
import theflyy.com.flyy.model.FlyyReferralDetails;
import theflyy.com.flyy.helpers.FlyyReferralCountFetchedListener;
import theflyy.com.flyy.helpers.FlyyFetchScratchCardCountListener;
import theflyy.com.flyy.model.externals.FlyyScrachCardCount;
import theflyy.com.flyy.helpers.FlyyFetchLeaderboardDataListner;
import theflyy.com.flyy.model.externals.FlyyLeaderboardData;
import theflyy.com.flyy.helpers.FlyyFetchWalletDataListener;
import theflyy.com.flyy.model.externals.FlyySpecificWalletData;
import theflyy.com.flyy.helpers.FlyyFetchReferrerDetailsListener;
import theflyy.com.flyy.model.externals.FlyyReferrerDetails;
import theflyy.com.flyy.helpers.FlyyUIEventsListener;
import theflyy.com.flyy.model.FlyyUIEvent;
import theflyy.com.flyy.helpers.FlyyFetchOffersCountListener;
import theflyy.com.flyy.model.FlyyOffersCount;
import theflyy.com.flyy.helpers.FlyySDKClosedListener;
import theflyy.com.flyy.helpers.OnFlyyLoginUserListener;
import theflyy.com.flyy.helpers.FlyyReferrerReceivedListener;
import java.util.HashMap;

/**
 * This class echoes a string called from JavaScript.
 */
public class FlyyPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Context context = cordova.getActivity().getApplicationContext();

        if (action.equals("initSDK")) {
            // Flyy.init(context, "f8ea5221f71be8adde5d");
            String partner_token = args.getString(0);
            String enviroment = args.getString(1);

            if (partner_token != null && partner_token.length() > 0 && enviroment != null && enviroment.length() > 0) {
                if (enviroment.equalsIgnoreCase("stage") || enviroment.equalsIgnoreCase("production")) {
                    Flyy.init(context, partner_token, enviroment.equalsIgnoreCase("stage") ? Flyy.STAGE : Flyy.PRODUCTION);
                    callbackContext.success("true");
                } else {
                    callbackContext.error("Expected enviroment variable as either 'stage' or 'production'.");
                }
            } else {
                callbackContext.error("Expected two non-empty string argument.");
            }
            return true;
        } else if (action.equals("openOfferActivity")) {
            String segmentId = args.getString(0);

            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToOffersActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } else if (action.equals("openRewardsActivity")) {
            String segmentId = args.getString(0);

            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToRewardsActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } else if (action.equals("openWalletActivity")) {
            String segmentId = args.getString(0);

            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToWalletActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } else if (action.equals("openGiftCardsActivity")) {

            String segmentId = args.getString(0);
            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToGiftCardsActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } 
        else if (action.equals("setUser")) 
        {
            String ext_uid = args.getString(0);
            boolean includeReferralCode = args.getBoolean(1);
            String segmentId = args.getString(2);
            if (ext_uid != null && ext_uid.length() > 0)
            {
                if (includeReferralCode)
                {
                    Flyy.setUser(ext_uid, includeReferralCode);
                    callbackContext.success("true"); 
                }
                else
                {
                    Flyy.setUser(ext_uid, segmentId);
                    callbackContext.success("true");
                }
            } 
            else
            {
                callbackContext.error("Expected one non-empty string argument.");
            }
            return true;
        }
        else if (action.equals("setNewUser")) {

            String ext_uid = args.getString(0);
            if (ext_uid != null && ext_uid.length() > 0) {
                Flyy.setNewUser(ext_uid);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("setUsername")) {

            String user_name = args.getString(0);
            if (user_name != null && user_name.length() > 0) {
                Flyy.setUsername(user_name);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("trackEvent")) {

            String key = args.getString(0);
            String value = args.getString(1);
            if (key != null && key.length() > 0 && value != null && value.length() > 0) {
                Flyy.sendEvent(key, value);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected two non-empty string argument.");
            }

            return true;
        } else if (action.equals("sendNotificationReceived")) {

            int notification_id = args.getInt(0);
            int offer_id = args.getInt(1);
            if (notification_id >= 0 && offer_id >= 0) {
                Flyy.sendNotificationReceived(notification_id, offer_id);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected two non-empty integer argument.");
            }

            return true;
        } else if (action.equals("notificationClicked")) {

            int notification_id = args.getInt(0);
            int offer_id = args.getInt(1);
            String source = args.getString(2);
            if (notification_id >= 0 && offer_id >= 0 && source != null && source.length() > 0) {
                Flyy.sendNotificationClicked(notification_id, offer_id, source);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected two non-empty integer and one non-empty string argument.");
            }

            return true;
        } else if (action.equals("setContactNumber")) {
            String key = args.getString(0);
            if (key != null && key.length() > 0) {
                Flyy.setContactNumber(key);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("startStampActivity")) {
            String segmentId = args.getString(0);
            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToStampActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } else if (action.equals("startReferralHistoryActivity")) {
            String segmentId = args.getString(0);
            // if (segmentId != null && segmentId.length() > 0) {
                Flyy.navigateToReferralHistoryActivity(context, segmentId);
                callbackContext.success("true");
            // } else {
                // callbackContext.error("Expected one non-empty string argument.");
            // }

            return true;
        } else if (action.equals("startTournamentListActivity")) {
            String title = args.getString(0);
            String segmentId = args.getString(1);
            if (title != null && title.length() > 0) {
                Flyy.navigateToTournamentListActivity(context, title, segmentId);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("setRewardGridSpanCount")) {
            int gridSpanCount = args.getInt(0);

            if (gridSpanCount >= 0) {
                FlyyUtility.setRewardGridSpanCount(gridSpanCount);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("openDeeplink")) {
            if (action != null && action.length() > 0) {
                FlyyUtility.openDeeplink(context, action);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("setAppPackage")) {
            String packageName = args.getString(0);
            if (packageName != null && packageName.length() > 0) {
                Flyy.setPackageName(packageName);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("handleNotification")) {
            HashMap<String, String> remoteMessage = new Gson().fromJson(args.getString(0), HashMap.class);
            FlyyNotificationHandler.handleCrossPlatformNotification(context, remoteMessage, null, null);
            callbackContext.success("true");
        } else if (action.equals("navigateToInviteAndEarnActivity")) {
            String offerId = args.getString(0);
            if (offerId != null && offerId.length() > 0) {
                Integer offer_id = Integer.parseInt(offerId);
                Flyy.navigateToInviteAndEarnActivity(context, offer_id);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
            return true;
        } else if (action.equals("navigateToCustomInviteAndEanActivity")) {
            String offerId = args.getString(0);
            String toolbarItemsColor = args.getString(1);
            if (offerId != null && offerId.length() > 0) {
                Integer offer_id = Integer.parseInt(offerId);
                Flyy.navigateToCustomInviteAndEanActivity(context, offer_id, toolbarItemsColor);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected at least one non-empty string argument.");
            }
            return true;
        } else if (action.equals("navigateToBonanzaActivity")) {
            Flyy.navigateToBonanzaActivity(context);
            callbackContext.success("true");
            return true;
        } else if (action.equals("navigateToChallengeDetailActivity")) {
            String offerId = args.getString(0);
            Integer offer_id = Integer.parseInt(offerId);
            Flyy.navigateToChallengeDetailActivity(context, offer_id);
            callbackContext.success("true");
            return true;
        } else if (action.equals("setThemeColor")) {
            String colorPrimary = args.getString(0);
            String colorPrimaryDark = args.getString(1);
            if (colorPrimary != null && colorPrimary.length() > 0 && colorPrimaryDark != null && colorPrimaryDark.length() > 0) {
                Flyy.setThemeColor(colorPrimary, colorPrimaryDark);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected two non-empty string argument.");
            }
            return true;
        } else if (action.equals("getShareData")) {
            String offerId = args.getString(0);
            Integer offer_id = Integer.parseInt(offerId);
            Flyy.getShareData(context, offer_id, new FlyyReferralDataFetchedListener() {
                @Override
                public void onReferralDetailsFetched(FlyyReferralDetails referralDetails) {
                    // PluginResult result = new PluginResult(PluginResult.Status.OK, new Gson().toJson(referralDetails));
                    // result.setKeepCallback(true);
                    // callbackContext.sendPluginResult(result);

                    callbackContext.success(new Gson().toJson(referralDetails));
                }

                @Override
                public void onFailure(String failureMessage) {
                    callbackContext.error(failureMessage);
                }
            });
            return true;
        } else if (action.equals("getReferralCount")) {
            Flyy.getReferralCount(context, new FlyyReferralCountFetchedListener() {
                @Override
                public void onReferralCountFetched(int referralsCount) {
                    callbackContext.success(new Gson().toJson(referralsCount));
                }

                @Override
                public void onFailure(String failureMessage) {
                    callbackContext.error(failureMessage);
                }
            });
            return true;
        } else if (action.equals("getScratchCardCount")) {
            Flyy.getScratchCardCount(context, new FlyyFetchScratchCardCountListener() {
                @Override
                public void onSuccess(FlyyScrachCardCount flyyScrachCardCount) {
                    callbackContext.success(new Gson().toJson(flyyScrachCardCount));
                }

                @Override
                public void onFailure(String message) {
                    callbackContext.error(message);
                }
            });
            return true;
        } else if (action.equals("getPreviousLeaderboardWinners")) {
            String tag = args.getString(0);
            if (tag != null && tag.length() > 0) {
                Flyy.getPreviousLeaderboardWinners(context, tag, new FlyyFetchLeaderboardDataListner() {
                    @Override
                    public void onSuccess(FlyyLeaderboardData flyyLeaderboardData) {
                        callbackContext.success(new Gson().toJson(flyyLeaderboardData));
                    }

                    @Override
                    public void onFailure(String message) {
                        callbackContext.error(message);
                    }
                });
            } else {
                callbackContext.error("Please provide tag");
            }
            return true;
        } else if (action.equals("getLeaderboardParticipants")) {
            String tag = args.getString(0);
            if (tag != null && tag.length() > 0) {
                Flyy.getLeaderboardParticipants(context, tag, new FlyyFetchLeaderboardDataListner() {
                    @Override
                    public void onSuccess(FlyyLeaderboardData flyyLeaderboardData) {
                        callbackContext.success(new Gson().toJson(flyyLeaderboardData));
                    }

                    @Override
                    public void onFailure(String message) {
                        callbackContext.error(message);
                    }
                });
            } else {
                callbackContext.error("Please provide tag");
            }
            return true;
        } else if (action.equals("getWalletBalance")) {
            String wallet_label = args.getString(0);
            if (wallet_label != null && wallet_label.length() > 0) {
                Flyy.getWalletBalance(context, wallet_label, new FlyyFetchWalletDataListener() {
                    @Override
                    public void onSuccess(FlyySpecificWalletData flyySpecificWalletData) {
                        callbackContext.success(new Gson().toJson(flyySpecificWalletData));
                    }

                    @Override
                    public void onFailure(String message) {
                        callbackContext.error(message);
                    }
                });
            } else {
                callbackContext.error("Please provide wallet_label");
            }
            return true;
        } else if (action.equals("getReferrerDetails")) {
            Flyy.getReferrerDetails(context, new FlyyFetchReferrerDetailsListener() {
                @Override
                public void onSuccess(FlyyReferrerDetails flyyReferrerDetails) {
                    callbackContext.success(new Gson().toJson(flyyReferrerDetails));
                }

                @Override
                public void onFailure(String message) {
                    callbackContext.error(message);
                }
            });
            return true;
        } else if (action.equals("getOffersCount")) {
            Flyy.getOffersCount(context, new FlyyFetchOffersCountListener() {
                @Override
                public void onSuccess(FlyyOffersCount flyyOffersCount) {
                    callbackContext.success(new Gson().toJson(flyyOffersCount));
                }

                @Override
                public void onFailure(String message) {
                    callbackContext.error(message);
                }
            });
            return true;
        } else if (action.equals("trackUIEvents")) {
            Flyy.trackUIEvents(new FlyyUIEventsListener() {
                @Override
                public void onEventDone(FlyyUIEvent flyyUIEvent) {
                    callbackContext.success(new Gson().toJson(flyyUIEvent));
                }
            });
            return true;
        } else if (action.equals("onSDKClosedWithScreenName")) {
            Flyy.getFlyySDKClosed(new FlyySDKClosedListener() {
                @Override
                public void onSDKClosed() {
                    if (callbackContext != null) {
                        callbackContext.success("");
                        Flyy.getFlyySDKClosed(null);
                    }
                }
            });
            return true;
        } else if (action.equals("handleDeeplink")) {
            String deeplink = args.getString(0);
            if (deeplink != null && deeplink.length() > 0) {
                Flyy.handleDeeplink(context, deeplink);
            } else {
                callbackContext.error("Please provide deeplink");
            }
            return true;
        } else if (action.equals("updateUsername")) {
            String user_name = args.getString(0);
            if (user_name != null && user_name.length() > 0) {
                Flyy.updateUsername(user_name);
                callbackContext.success("true");
            } else {
                callbackContext.error("Please provide user_name");
            }
            return true;
        } else if (action.equals("loginUser")) {
            String ext_uid = args.getString(0);
            String user_name = args.getString(1);
            if (ext_uid != null && ext_uid.length() > 0 && user_name != null && user_name.length() > 0) {
                Flyy.loginUser(ext_uid, user_name, null);
                callbackContext.success("true");
            } else {
                callbackContext.error("Please provide ext_uid and user_name");
            }
            return true;
        } else if (action.equals("loginUserWithCallback")) {
            String ext_uid = args.getString(0);
            String user_name = args.getString(1);
            if (ext_uid != null && ext_uid.length() > 0 && user_name != null && user_name.length() > 0) {
                Flyy.loginUser(ext_uid, user_name, new OnFlyyLoginUserListener() {
                    @Override
                    public void onLoginSuccess(String ext_uid, String user_name) {
                        try {
                            JSONObject object = new JSONObject();
                            object.put("ext_uid", ext_uid);
                            object.put("user_name", user_name);
                            callbackContext.success(new Gson().toJson(object));
                        } catch (Exception e){
                            callbackContext.error(e.getMessage());
                        }
                    }

                    @Override
                    public void onLoginFailure(String message) {
                        callbackContext.error(message);
                    }
                });
            } else {
                callbackContext.error("Please provide ext_uid and user_name");
            }
            return true;
        } else if (action.equals("initWithReferrerReceivedCallback")) {
            String partner_id = args.getString(0);
            String enviroment = args.getString(1);
            if (partner_id != null && partner_id.length() > 0 && enviroment != null && enviroment.length() > 0) {
                if (enviroment.equalsIgnoreCase("stage") || enviroment.equalsIgnoreCase("production")) {
                    int env = enviroment.equalsIgnoreCase("stage") ? Flyy.STAGE : Flyy.PRODUCTION;
                    Flyy.initWithReferrerReceivedCallback(context, partner_id, env, new FlyyReferrerReceivedListener() {
                        @Override
                        public void onReferrerReceived(boolean isFromFlyy, String referrerData) {
                            try {
                                JSONObject object = new JSONObject();
                                object.put("isFromFlyy", isFromFlyy);
                                object.put("referrerData", referrerData);
                                callbackContext.success(new Gson().toJson(object));
                            } catch (Exception e){
                                callbackContext.error(e.getMessage());
                            }
                        }
                    });
                } else {
                    callbackContext.error("Expected enviroment variable as either 'stage' or 'production'.");
                }
            } else {
                callbackContext.error("Please provide partner_id and enviroment");
            }
            return true;
        } else if (action.equals("getTotalSCCount")) {
            int count = Flyy.getTotalSCCount(context);
            callbackContext.success(count);
            return true;
        } else if (action.equals("getScratchedSCCount")) {
            int count = Flyy.getScratchedSCCount(context);
            callbackContext.success(count);
            return true;
        } else if (action.equals("getUnscratchedSCCount")) {
            int count = Flyy.getUnscratchedSCCount(context);
            callbackContext.success(count);
            return true;
        } else if (action.equals("getLockedSCCount")) {
            int count = Flyy.getLockedSCCount(context);
            callbackContext.success(count);
            return true;
        } else if (action.equals("setBaseFlyyDomain")) {
            String domain = args.getString(0);
            if (domain != null && domain.length() > 0) {
                Flyy.setBaseFlyyDomain(domain);
            } else {
                callbackContext.error("Please provide domain");
            }
        } else if (action.equals("setBaseStageFlyyDomain")) {
            String domain = args.getString(0);
            if (domain != null && domain.length() > 0) {
                Flyy.setBaseStageFlyyDomain(domain);
            } else {
                callbackContext.error("Please provide domain");
            }
        } else if (action.equals("startReferAndEarnActivity")) {
            String[] data =  {"personal_loan_offers","credit_card_offers"};
                Flyy.navigateToReferAndEarnActivity(context, data);
                callbackContext.success("true");
            return true;

        }else if (action.equals("startCheckInActivity")) {
                Flyy.navigateToCheckInActivity(context);
                callbackContext.success("true");
            return true;

        }else if (action.equals("startRetailerIncentiveApp")) {
            String partnerId = args.getString(0);
            String userToken = args.getString(1);
            String themeColor = args.getString(2);
                Flyy.navigateToRetailerIncentiveApp(partnerId,userToken,themeColor);
                callbackContext.success("true");
            return true;

        }else if (action.equals("setCustomFontName")) {
            String regularFont = args.getString(0);
            String mediumFont = args.getString(1);
            String boldFont = args.getString(2);
            if (regularFont != null && mediumFont != null && boldFont != null) {
                Flyy.setCustomFontName(regularFont,mediumFont,boldFont);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }


        return false;
    }
}
