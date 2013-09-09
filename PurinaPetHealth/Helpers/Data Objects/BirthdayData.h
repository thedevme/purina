//
//  BirthdayData.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BirthdayData : NSObject

@property (nonatomic, retain) NSString* birthdayDisplayDate;
@property (nonatomic, retain) NSDate* birthdayDate;
@property (assign) BOOL isReminderSet;

@end
