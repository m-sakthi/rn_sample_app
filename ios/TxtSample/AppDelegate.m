#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <SquarePointOfSaleSDK.h>
#import "CalendarManager.h"

#if DEBUG
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>


//static void InitializeFlipper(UIApplication *application) {
//  FlipperClient *client = [FlipperClient sharedClient];
//  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
//  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
//  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
//  [client addPlugin:[FlipperKitReactPlugin new]];
//  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
//  [client start];
//}
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//#if DEBUG
//  InitializeFlipper(application);
//#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"TxtSample"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (BOOL)application:(UIApplication *)app
             openURL:(NSURL *)url
             options:(NSDictionary<NSString *, id> *)options;
{
  NSString *urlString = url.absoluteString;
  
 
  NSString *const sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
  // Make sure the URL comes from Square Point of Sale; fail if it doesn't.
  // ![sourceApplication hasPrefix:@"com.squareup.square"]
//  if (![urlString hasPrefix:@"myapp://square-response"]) {
//    return NO;
//  }

  NSLog(@"Some random String %@", url);
  // The response data is encoded in the URL and can be decoded as an SCCAPIResponse.
  NSError *decodeError = nil;
  SCCAPIResponse (*const response) = [SCCAPIResponse responseWithResponseURL:url error:&decodeError];

  if (response.isSuccessResponse) {
    // Print checkout object
    NSLog(@"Transaction successful: %@", response);
   // [self sendEventWithName:@"EventReminder" body:@{@"name": response}];

    CalendarManager *c = [[CalendarManager alloc]init];
    NSDictionary *dict = @{ @"clientTransactionID": response.clientTransactionID, @"transactionID": response.transactionID };
    
    [c calendarEventReminderReceived: dict];
    
  } else if (decodeError) {
    // Print decode error
    NSLog(@"Decode Error: %@", decodeError);
  } else {
    // Print the error code
    NSLog(@"Request failed: %@", response.error);
  }

  return YES;
}

@end
