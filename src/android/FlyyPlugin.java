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
            if (partner_token != null && partner_token.length() > 0) {
                Flyy.init(context, partner_token);
                callbackContext.success("true");
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
            return true;
        } else if (action.equals("openOfferActivity")){
            Intent intent = new Intent(context, FlyyOffersActivity.class);
            this.cordova.getActivity().startActivity(intent);

            callbackContext.success("true");

            return true;
        } else if (action.equals("setExtUid")) {

            String ext_uid = args.getString(0);
            if (ext_uid != null && ext_uid.length() > 0) {
                Flyy.setExtUid(ext_uid);
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
        }
        return false;
    }
}
