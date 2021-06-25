package cordova.plugin.theflyy;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.content.Context;
import theflyy.com.flyy.views.FlyyOffersActivity;
import theflyy.com.flyy.Flyy;
import theflyy.com.flyy.helpers.FlyyUtility;
import com.google.firebase.messaging.RemoteMessage;
import theflyy.com.flyy.helpers.FlyyNotificationHandler;

/**
 * This class echoes a string called from JavaScript.
 */
public class FlyyPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Context context = cordova.getActivity().getApplicationContext();
        
        if (action.equals("intSdk")) {
            // Flyy.init(context, "f8ea5221f71be8adde5d");
            String partner_token = args.getString(0);
            String enviroment = args.getString(1);
        
            if (partner_token != null && partner_token.length() > 0 && enviroment != null && enviroment.length() > 0) {
                if(enviroment.equalsIgnoreCase("stage") || enviroment.equalsIgnoreCase("production")){
                    Flyy.init(  context, partner_token, enviroment.equalsIgnoreCase("stage") ? Flyy.STAGE : Flyy.PRODUCTION);
                    callbackContext.success("true");
                } else {
                    callbackContext.error("Expected enviroment variable as either 'stage' or 'production'.");
                }
            } else {
                callbackContext.error("Expected two non-empty string argument.");
            }
            return true;
        } else if (action.equals("openOfferActivity")){
            String segmentId = args.getString(0);

            if (segmentId != null && segmentId.length() > 0) {
            Flyy.navigateToOffersActivity(context,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        }  else if (action.equals("openRewardsActivity")){
            String segmentId = args.getString(0);

            if (segmentId != null && segmentId.length() > 0) {
            Flyy.navigateToRewardsActivity(context,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument."); 
            }

            return true;
        }   else if (action.equals("openWalletActivity")){
            String segmentId = args.getString(0);

            if (segmentId != null && segmentId.length() > 0) {
             Flyy.navigateToWalletActivity(context,segmentId);
             callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");  
            }

            return true;
        }   else if (action.equals("openGiftCardsActivity")){

            String segmentId = args.getString(0);
            if (segmentId != null && segmentId.length() > 0) {
            Flyy.navigateToGiftCardsActivity(context,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        } else if (action.equals("setUser")) {

            String ext_uid = args.getString(0);
            String segmentId = args.getString(1);
            if (ext_uid != null && ext_uid.length() > 0 && segmentId != null && segmentId.length() > 0) {
                Flyy.setUser(ext_uid,segmentId);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }

            return true;
        }  else if (action.equals("setNewUser")) {

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
            if (notification_id >=0 && offer_id>=0) {
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
            if (notification_id >= 0 && offer_id >= 0 && source !=null && source.length()>0) {
                Flyy.sendNotificationClicked(notification_id, offer_id, source);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected two non-empty integer and one non-empty string argument.");
            }

            return true;
        }else if (action.equals("setContactNumber")) {
            String key = args.getString(0);
            if (key !=null && key.length()>0) {
            Flyy.setContactNumber(key);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("startStampActivity")) {
            String segmentId = args.getString(0);
            if (segmentId !=null && segmentId.length()>0) {
            Flyy.navigateToStampActivity(context,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("startReferralHistoryActivity")) {
            String segmentId = args.getString(0);
            if (segmentId !=null && segmentId.length()>0) {
            Flyy.navigateToReferralHistoryActivity(context,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("startTournamentListActivity")) {
            String title = args.getString(0);
            String segmentId = args.getString(1);
            if (title !=null && title.length()>0 && segmentId !=null && segmentId.length()>0) {
            Flyy.navigateToTournamentListActivity(context,title,segmentId);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("setRewardGridSpanCount")) {
            int gridSpanCount = args.getInt(0);

            if (gridSpanCount>=0) {
            FlyyUtility.setRewardGridSpanCount(gridSpanCount);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("openDeeplink")) {
            if (action !=null && action.length()>0) {
            FlyyUtility.openDeeplink(context,action);
            callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        }else if (action.equals("setAppPackage")) {
            String packageName = args.getString(0);
            if (packageName !=null && packageName.length()>0) {
                Flyy.setPackageName(packageName);
                callbackContext.success("true");
            }else{
                callbackContext.error("Expected one non-empty string argument.");
            }
            
            return true;
        } else if (action.equals("handleNotification")) {
            RemoteMessage remoteMessage = (RemoteMessage) args.get(0);
            FlyyNotificationHandler.handleNotification(context, remoteMessage, null, null);
            callbackContext.success("true");
        }


        return false;
    }
}
