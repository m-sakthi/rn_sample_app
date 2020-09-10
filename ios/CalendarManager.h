//
//  CalendarManager.h
//  TxtSample
//
//  Created by 1260081 on 29/08/20.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface CalendarManager : RCTEventEmitter <RCTBridgeModule>

- (void)calendarEventReminderReceived:(NSDictionary *)userInfo;

@end
