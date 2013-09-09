//
//  AppointmentData.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import "AppointmentData.h"
#import "_Appointment.h"

@implementation AppointmentData

@synthesize startDate, endDate;
@synthesize title, type, repeat, alert, notes;
@synthesize saveToCalendar;
@synthesize pets;




- (id) init
{
    self = [super init];

    if (self)
    {
        self.pets = [[NSMutableArray alloc] init];
    }

    return self;
}

@end
