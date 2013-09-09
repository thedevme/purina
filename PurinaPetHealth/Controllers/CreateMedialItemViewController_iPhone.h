//
//  CreateMedialItemViewController_iPhone.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/24/12.
//
//

#import <UIKit/UIKit.h>
#import "NSDate+Helper.h"
#import "OHAttributedLabel.h"

@class MedicalData;
@class PetData;

@protocol CreateMedItemDelegate <NSObject>

- (void)updatePetData:(PetData *)pet;
- (void) saveMedicalData:(MedicalData *)medical isUpdating:(BOOL)updating;

@optional
- (void) updateDone;

@end

@class TDDatePickerController;
@class MedicalData;
@class PetModel;
@class PetData;

@interface CreateMedialItemViewController_iPhone : UIViewController <UIPickerViewDelegate, UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (nonatomic, weak) id <CreateMedItemDelegate> delegate;
@property(nonatomic, copy) NSString *type;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic, copy) NSString *contentType;
@property(nonatomic, copy) NSString *data;

@property (strong, nonatomic) IBOutlet UILabel *lblSecondItem;
@property (strong, nonatomic) IBOutlet UITextField *tfSecondItem;
@property (strong, nonatomic) IBOutlet UIImageView *imgSecondItem;
@property (strong, nonatomic) IBOutlet UITextView *txtMedical;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgTxtBG;

@property (nonatomic, retain) MedicalData* objMedicalData;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (strong, nonatomic) IBOutlet UIImageView *imgDateBG;

@property(nonatomic, strong) PetModel* petModel;

@property(nonatomic, strong) PetData *objCurrentPetData;

@property(nonatomic, copy) NSString *selectedDate;

@property(nonatomic, strong) UITextField *selectedTf;
@property(nonatomic) BOOL isUpdating;


//Methods
- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data;
- (IBAction)changeDate:(id)sender ;
- (void) createMessage:(NSString *)message withRange:(NSString *)range;

@end
