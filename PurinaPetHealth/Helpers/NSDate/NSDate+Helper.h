//
//  NSDate+Helper.h
//  TwentyOneDays
//
//  Created by Craig Clayton on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

+ (NSDate *)normalizedDateWithDate:(NSDate *) date;
+ (BOOL) isEqualToDateIgnoringTime:(NSDate *) date;
+ (BOOL) isEarlierThanDate:(NSDate *) date;
+ (BOOL) isLaterThanDate:(NSDate *) date;
+ (NSString *) determineDate:(NSDate *)date;
+ (NSString *) formatDate:(NSDate *)date formatType:(NSString *)type;
+ (NSString *)getDayOfTheWeek:(NSDate *)date;
- (NSDate *)changeTimeValue:(NSDate *)dateValue;
- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes;
+ (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2;

@end
