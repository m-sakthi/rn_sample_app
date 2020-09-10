//
//  SquarePay.m
//  TxtSample
//
//  Created by 1260081 on 29/08/20.
//

#import "SquarePay.h"

@implementation SquarePay

RCT_EXPORT_MODULE()
- (NSDictionary * )constantsToExport{
  return @{@"greeting": @"Hello dude"};
}

RCT_EXPORT_METHOD(squareMe: (int)number: (RCTResponseSenderBlock)callback){
  
  // Always set the client ID before creating your first API request.
  [SCCAPIRequest setClientID:@"sq0idp-NHW0BYyK9LRo-Cw15YgSfQ"];

  // Replace with your app's callback URL.
  NSURL *const callbackURL = [NSURL URLWithString:@"com.deere.quicksale1://"];

  // Specify the amount of money to charge.
  SCCMoney *const amount = [SCCMoney moneyWithAmountCents:number*100 currencyCode:@"USD" error:NULL];

  // Specify which forms of tender the merchant can accept
  SCCAPIRequestTenderTypes const supportedTenderTypes = SCCAPIRequestTenderTypeAll;

  // Specify whether default fees in Square Point of Sale are cleared from this transaction
  // (Default is NO, they are not cleared)
  BOOL const clearsDefaultFees = YES;

  // Replace with any string you want returned from Square Point of Sale.
  NSString *const userInfoString = @"Useful information";

  // Replace with notes to associate with the transaction.
  NSString *const notes = @"Notes";

  // Initialize the request.
  NSError *error = nil;
  SCCAPIRequest *const request = [SCCAPIRequest requestWithCallbackURL:callbackURL
                                                                amount:amount
                                                        userInfoString:userInfoString
                                                            locationID:nil
                                                                 notes:notes
                                                            customerID:nil
                                                  supportedTenderTypes:supportedTenderTypes
                                                     clearsDefaultFees:clearsDefaultFees
                                       returnAutomaticallyAfterPayment:NO
                                                                 error:&error];
  
  // Perform the request.
  BOOL const success = [SCCAPIConnection performRequest:request error:&error];

  NSLog(@"%@", callbackURL);
  if(success){
    NSLog(@"sucess");
  } else{
    NSLog(@"fail");
  }

  callback(@[[NSNull null], [NSNumber numberWithInt:(number * number)]]);
  
}

@end
