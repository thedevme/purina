//
//  DatePickerViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
   
#import <UIKit/UIKit.h>
#import "BirthdayData.h"
#import "NSDate+Helper.h"

@protocol DatePickerDelegate <NSObject>

- (void) dateSelected:(BirthdayData *)data;

@end


@interface DatePickerViewController : UIViewController <UIPickerViewDelegate>

@property (nonatomic, retain) id <DatePickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;

@property (nonatomic, retain) NSString* birthdayDisplayDate;
@property (nonatomic, retain) NSString* birthdayDate;
@property (nonatomic, retain) BirthdayData* objBirthdayData;
@property (weak, nonatomic) IBOutlet UILabel *lblPlease;
@property (weak, nonatomic) IBOutlet UILabel *lblYour;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UISwitch *switchReminder;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdate;

- (IBAction)changeDate:(id)sender ;
- (IBAction)onReminderTapped:(id)sender;
- (IBAction)onCancelTapped:(id)sender;
- (IBAction)onSaveTapped:(id)sender;

@end
