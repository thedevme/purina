//
//  PetInfoFormViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "DateOwnedPicker.h"
#import "CreateMedialItemViewController_iPhone.h"
#import "AddMedicalInfoViewController.h"

@class TPKeyboardAvoidingScrollView;
@class PetData;
@class AddMedicalInfoViewController;

@protocol PetInfoFormDelegate <NSObject>

//- (void)didDismissModalView;
- (void) saveIdentificationData:(PetData *)petData;

@end

@interface PetInfoFormViewController_iPad : UIViewController <UITableViewDataSource, UITableViewDelegate,
        UITextFieldDelegate, DateOwnedPickerDelegate, AddMedicalInfoDelegate>




@property (nonatomic, assign) id<PetInfoFormDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblBday;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblBreed;


//Titles
@property (weak, nonatomic) IBOutlet UILabel *lblTitleGender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBday;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAge;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBreed;

@property (strong, nonatomic) IBOutlet UIButton *btnIdentification;
@property (strong, nonatomic) IBOutlet UIButton *btnMedical;


@property (nonatomic, retain) PetData* objPetData;


//Identification
@property (weak, nonatomic) IBOutlet UITextField *tfWeight;
@property (weak, nonatomic) IBOutlet UITextField *tfColor;
@property (weak, nonatomic) IBOutlet UITextField *tfEyeColor;
@property (weak, nonatomic) IBOutlet UITextField *tfCoatMarkings;
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;
@property (weak, nonatomic) IBOutlet UITextField *tfTagNo;
@property (weak, nonatomic) IBOutlet UITextField *tfChipNo;
@property (weak, nonatomic) IBOutlet UITextField *tfLicenseNo;
@property (weak, nonatomic) IBOutlet UITextField *tfPedigree;
@property(nonatomic, strong) UITextField *selectedTf;
@property (weak, nonatomic) IBOutlet UILabel *lblOwnedSince;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UILabel *lblColor;
@property (weak, nonatomic) IBOutlet UILabel *lblEyeColor;
@property (weak, nonatomic) IBOutlet UILabel *lblCoatMarkings;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTagNo;
@property (weak, nonatomic) IBOutlet UILabel *lblChipNo;
@property (weak, nonatomic) IBOutlet UILabel *lblLicenseNo;
@property (weak, nonatomic) IBOutlet UILabel *lblPedigree;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) IBOutlet UILabel *lblNeutered;
@property (strong, nonatomic) IBOutlet UILabel *lblNo;
@property (strong, nonatomic) IBOutlet UILabel *lblYes;
@property (strong, nonatomic) IBOutlet UIButton *btnOwned;
@property (strong, nonatomic) IBOutlet UILabel *lblOwnedValue;
@property (strong, nonatomic) IBOutlet UIImageView *imgNo;
@property (strong, nonatomic) IBOutlet UIImageView *imgYes;

@property (strong, nonatomic) IBOutlet UITableView *medicalTableView;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *identificationScrollView;


@property(nonatomic, strong) NSMutableArray *sections;

@property(nonatomic, strong) UIPopoverController *contactPopover;

@property(nonatomic, strong) AddMedicalInfoViewController *addMedicalInfo;

- (IBAction)onButtonTapped:(id)sender;
- (IBAction)onYesNoTapped:(id)sender;
- (IBAction)onOwnedTapped:(id)sender;


@end
