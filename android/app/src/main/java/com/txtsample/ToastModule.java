package com.txtsample;

import android.widget.Toast;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.Map;
import java.util.HashMap;


import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.squareup.sdk.pos.PosClient;
import com.squareup.sdk.pos.ChargeRequest;
import com.squareup.sdk.pos.PosSdk;
import com.squareup.sdk.pos.CurrencyCode;
import android.content.ActivityNotFoundException;
import android.os.Bundle;
import android.content.Intent;

public class ToastModule extends ReactContextBaseJavaModule {
  private static ReactApplicationContext reactContext;

  private static final String DURATION_SHORT_KEY = "SHORT";
  private static final String DURATION_LONG_KEY = "LONG";

  ToastModule(ReactApplicationContext context) {
    super(context);
    reactContext = context;
  }

  @Override
  public String getName() {
    return "ToastExample";
  }

  @Override
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    constants.put(DURATION_SHORT_KEY, Toast.LENGTH_SHORT);
    constants.put(DURATION_LONG_KEY, Toast.LENGTH_LONG);
    return constants;
  }

  @ReactMethod
  public void show(String message, int duration) {
    Toast.makeText(getReactApplicationContext(), message, duration).show();
  }

//  private static final int CHARGE_REQUEST_CODE = 1;
//  @ReactMethod
//  public void startTransaction() {
//    ChargeRequest request = new ChargeRequest.Builder(
//    100,
//    CurrencyCode.USD)
//    .build();
//    try {
//      Intent intent = posClient.createChargeIntent(request);
//      startActivityForResult(intent, CHARGE_REQUEST_CODE);
//
//    } catch (ActivityNotFoundException e) {
////      AlertDialogHelper.showDialog(
////          this,
////          "Error",
////          "Square Point of Sale is not installed"
////          );
//      posClient.openPointOfSalePlayStoreListing();
//    }
//  }
}