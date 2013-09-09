//
//  ApptTypePickerViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import <UIKit/UIKit.h>

@protocol ApptTypePickerDelegate <NSObject>

- (void)doneWithSelectedType:(NSString *)type;
- (void)dismissType;

@end

@interface ApptTypePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic, strong) NSMutableArray *apptTypes;

@property (nonatomic, weak) id <ApptTypePickerDelegate> delegate;


@property(nonatomic, copy) NSString *selectedType;
@end
