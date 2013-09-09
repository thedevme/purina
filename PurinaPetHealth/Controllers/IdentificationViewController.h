//
//  IdentificationViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import <UIKit/UIKit.h>
#import "IdentificationViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "PetData.h"
#import "TDDatePickerController.h"
#import "PetModel.h"

@class TPKeyboardAvoidingScrollView;
@class PetData;
@class TDDatePickerController;
@class PetModel;

@interface IdentificationViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfWeight;

@property (weak, nonatomic) IBOutlet UITextField *tfColor;
@property (weak, nonatomic) IBOutlet UITextField *tfEyeColor;
@property (weak, nonatomic) IBOutlet UITextField *tfCoatMarkings;
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;
@property (weak, nonatomic) IBOutlet UITextField *tfTagNo;
@property (weak, nonatomic) IBOutlet UITextField *tfChipNo;
@property (weak, nonatomic) IBOutlet UITextField *tfLicenseNo;
@property (weak, nonatomic) IBOutlet UITextField *tfPedigree;
@property (weak, nonatomic) IBOutlet UILabel *lblOwnedSince;

@property (weak, nonatomic) IBOutlet UILabel *lblColor;
@property (weak, nonatomic) IBOutlet UILabel *lblSpayed;
@property (weak, nonatomic) IBOutlet UILabel *lblEyeColor;
@property (weak, nonatomic) IBOutlet UILabel *lblCoatMarkings;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTagNo;
@property (weak, nonatomic) IBOutlet UILabel *lblChipNo;
@property (weak, nonatomic) IBOutlet UILabel *lblLicenseNo;
@property (weak, nonatomic) IBOutlet UILabel *lblPedigree;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) PetData *objPetData;
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblYes;

@property (weak, nonatomic) IBOutlet UILabel *lblDateOwned;
@property (weak, nonatomic) IBOutlet UILabel *lblDateValue;
@property (nonatomic, retain) TDDatePickerController* datePickerView;


@property (strong, nonatomic) IBOutlet UIImageView *imgNo;
@property (strong, nonatomic) IBOutlet UIImageView *imgYes;
@property (nonatomic, retain) NSDate* selectedDate;


@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) PetModel* petModel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withPetData:(PetData *)data;
- (IBAction)onDateTapped:(id)sender;
- (IBAction)onYesNoTapped:(id)sender;

@end
