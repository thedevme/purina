//
//  AppointmentData.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import <Foundation/Foundation.h>

@class AppointmentID;

@interface AppointmentData : NSObject

@property (nonatomic, retain) NSDate* startDate;
@property (nonatomic, retain) NSDate* endDate;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* repeat;
@property (nonatomic, retain) NSString* alert;
@property (nonatomic, retain) NSString* notes;
@property (nonatomic, retain) NSString* guid;
@property (nonatomic, retain) NSMutableArray* pets;
@property (assign) BOOL saveToCalendar;

@property(nonatomic, strong) NSString* appointmentDate;
@property(nonatomic, strong) NSString* time;
@end
