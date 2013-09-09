//
//  IdentificationFormViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import <UIKit/UIKit.h>
#import "DateOwnedPicker.h"

@class Pet;
@class PetData;
@class TPKeyboardAvoidingScrollView;

@protocol ModalViewControllerDelegate <NSObject>

- (void)didDismissModalView;
- (void) saveIdentificationData:(PetData *)petData;

@end

@interface IdentificationFormViewController : UIViewController <UITextFieldDelegate, DateOwnedPickerDelegate>


@property (nonatomic, assign) id<ModalViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

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


@property(nonatomic, strong) PetData *objPetData;


@property(nonatomic, strong) UIPopoverController *contactPopover;

- (IBAction)onSaveTapped:(id)sender;
- (void)setData:(PetData *)pet;
- (IBAction)onOwnedTapped:(id)sender;
- (IBAction)onYesNoTapped:(id)sender;

@end

