//
//  NSDate+Helper.m
//  TwentyOneDays
//
//  Created by Craig Clayton on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+ (NSDate*)normalizedDateWithDate:(NSDate*) date
{
    
    NSCalendar* objCalendar = [[NSCalendar alloc] init];
    NSDateComponents* components = [objCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                  fromDate: date];
    return [objCalendar dateFromComponents:components]; // NB calendar_ must be initialized
}

+ (BOOL) isEqualToDateIgnoringTime: (NSDate *) date
{
    NSDate* today = [NSDate date];
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:today];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

- (NSDate *)changeTimeValue:(NSDate *)dateValue{
    NSDateComponents *time = [[NSCalendar currentCalendar]
                              components:NSHourCalendarUnit | NSMinuteCalendarUnit
                              fromDate:dateValue];
    int val = 0;
    NSDate *newDate = [[NSDate alloc] init];
    NSInteger minutes = [time minute];
    if(minutes > 0 && minutes < 30) {
        val = 0 - minutes; NSTimeInterval aTimeInterval = [dateValue
                                                            timeIntervalSinceReferenceDate] + 60 * val + minutes;
        NSLog(@"%i", val);
        newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
        return newDate;
    } else if(minutes > 30 && minutes < 60) {
        val = 60 - minutes;
        NSTimeInterval aTimeInterval = [dateValue timeIntervalSinceReferenceDate]
        + 60 * val;
        newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
        return newDate;
    } else {
        return newDate;
    }
}

- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	
    return newDate;
}

+ (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (BOOL) isEarlierThanDate: (NSDate *) date
{
    NSDate* today = [NSDate date];
	return ([today earlierDate:date] == today);
}

+ (BOOL) isLaterThanDate: (NSDate *) date
{
    NSDate* today = [NSDate date];
	return ([today laterDate:date] == today);
}

+ (NSString *) determineDate:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* now = [NSDate date];
    int differenceInDays = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:date] -
    [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:now];
    NSString* dayString;
    
    switch (differenceInDays) 
    {
        case -1:
            dayString = @"Yesterday";
            break;
        case 0:
            dayString = @"TODAY";
            break;
        case 1:
            dayString = @"TOMORROW";
            break;
        default:
            dayString = [self getDayOfTheWeek:date];
            
            break;
    }
    
    return dayString;
}

+ (NSString *) formatDate:(NSDate *)date formatType:(NSString *)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:type];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getDayOfTheWeek:(NSDate *)date
{
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    
    return [[weekday stringFromDate:date] uppercaseString];
}

@end
