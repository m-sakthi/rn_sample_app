package com.txtsample;

import com.facebook.react.ReactActivity;

import android.content.ActivityNotFoundException;
import android.os.Bundle;
import android.content.Intent;

//import com.facebook.react.bridge.Arguments;
//import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.squareup.sdk.pos.PosClient;
import com.squareup.sdk.pos.ChargeRequest;
import com.squareup.sdk.pos.PosSdk;
import com.squareup.sdk.pos.CurrencyCode;


public class MainActivity extends ReactActivity {

  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "TxtSample";
  }

  private PosClient posClient;
  private static final String APPLICATION_ID = "sq0idp-NHW0BYyK9LRo-Cw15YgSfQ";

  @Override protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // setContentView(R.layout.main_activity);
    // Replace APPLICATION_ID with a Square-assigned application ID
    posClient = PosSdk.createClient(this, APPLICATION_ID);
  }


  private static final int CHARGE_REQUEST_CODE = 1;
  public void startTransaction() {
    ChargeRequest request = new ChargeRequest.Builder(
    100,
    CurrencyCode.USD)
    .build();
    try {
      Intent intent = posClient.createChargeIntent(request);
      startActivityForResult(intent, CHARGE_REQUEST_CODE);

    } catch (ActivityNotFoundException e) {
//      AlertDialogHelper.showDialog(
//          this,
//          "Error",
//          "Square Point of Sale is not installed"
//          );
      posClient.openPointOfSalePlayStoreListing();
    }
  }

  @Override public void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    // Handle unexpected errors
    if (data == null || requestCode != CHARGE_REQUEST_CODE) {
//        AlertDialogHelper.showDialog(this,
//            "Error: unknown",
//            "Square Point of Sale was uninstalled or stopped working");
      return;
    }

    // Handle expected results
    if (resultCode == ReactActivity.RESULT_OK) {
      // Handle success
      ChargeRequest.Success success = posClient.parseChargeSuccess(data);
//      AlertDialogHelper.showDialog(this,
//          "Success",
//          "Client transaction ID: "
//              + success.clientTransactionId);

//      WritableMap params = Arguments.createMap(); // add here the data you want to send
//      params.putString("event", success.clientTransactionId); // <- example

//      This will send the event to react native
      getReactInstanceManager().getCurrentReactContext()
          .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
          .emit("onStop", success.toString());

    } else {
        // Handle expected errors
        ChargeRequest.Error error = posClient.parseChargeError(data);
//        AlertDialogHelper.showDialog(this,
//            "Error" + error.code,
//            "Client transaction ID: "
//                + error.debugDescription);
    }
    return;
  }

}
