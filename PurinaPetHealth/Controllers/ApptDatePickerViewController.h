//
//  ApptDatePickerViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import <UIKit/UIKit.h>

@protocol ApptDatePickerDelegate <NSObject>

- (void)doneWithSelectedDate:(NSString *)date andDate:(NSDate *)date1;
- (void)dismissDate;

@end



@interface ApptDatePickerViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;

@property (nonatomic, retain) NSString* selectedDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdate;


@property (nonatomic, weak) id <ApptDatePickerDelegate> delegate;

- (IBAction)changeDate:(id)sender;

@end
