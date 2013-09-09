//
//  DateOwnedPicker.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/24/12.
//
//

#import <UIKit/UIKit.h>
#import "BirthdayData.h"


@protocol DateOwnedPickerDelegate <NSObject>

- (void)updateSelectedDate:(NSString *)date;

@end


@interface DateOwnedPicker : UIViewController <UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property (weak, nonatomic) IBOutlet UILabel *lblApptDate;
@property (nonatomic, retain) NSString* birthdayDisplayDate;
@property (nonatomic, retain) NSString* birthdayDate;
@property (nonatomic, retain) BirthdayData* objBirthdayData;
@property (weak, nonatomic) IBOutlet UISwitch *switchReminder;

@property (nonatomic, assign) id<DateOwnedPickerDelegate> delegate;

@property(nonatomic, copy) NSString *selectedDate;

- (IBAction)changeDate:(id)sender;

@end
