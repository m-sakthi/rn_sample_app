//
//  CalendarManager.m
//  TxtSample
//
//  Created by 1260081 on 29/08/20.
//

#import "CalendarManager.h"

@implementation CalendarManager

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"];
}

- (void)calendarEventReminderReceived:(NSDictionary *)userInfo
{
//  NSString *eventName = userInfo[@"name"];
  [self sendEventWithName:@"EventReminder" body: userInfo];
}

@end
