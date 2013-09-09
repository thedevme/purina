//
//  EditPetViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoreDataStack.h"
#import "Pet.h"
#import "Contact.h"
#import "BirthdayData.h"
#import "DatePickerViewController.h"
#import "AddContactViewController.h"
#import "BlockAlertView.h"
#import "UniqueID.h"
#import "PetDetailsViewController.h"
#import "AvatarPickerPlus.h"
#import "ContactListViewController.h"
#import "UIColor+PetHealth.h"
#import "DateOwnedPicker.h"
#import "EditContactViewController_iPad.h"

@class TPKeyboardAvoidingScrollView;
@class PetData;
@class PetModel;

@protocol EditPetDelegate <NSObject>

@required
- (void) savedPetData:(PetData *)data;
@end

@interface EditPetViewController : UIViewController <UITextFieldDelegate, AvatarPickerPlusDelegate,
        UIGestureRecognizerDelegate, UIPopoverControllerDelegate, DateOwnedPickerDelegate, EditContactDelegate
        ,UIScrollViewDelegate>


@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) BirthdayData* objBirthdayData;
@property (nonatomic, retain) ContactData* objContactData;
@property (nonatomic, retain) ContactData* objPrimaryVetData;
@property (nonatomic, retain) ContactData* objPrimaryGroomerData;
@property (nonatomic, retain) ContactData* objPrimaryKennelData;
@property (nonatomic, retain) id <EditPetDelegate> delegate;
@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UIButton* btnIcon;
@property (nonatomic, retain) NSManagedObjectID* primaryVetID;

@property (nonatomic, retain) NSString* strGender;
@property (nonatomic, retain) NSString* strSpecies;
@property (nonatomic, retain) NSString* strName;
@property (nonatomic, retain) NSData *imageData;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnVet;
@property (weak, nonatomic) IBOutlet UIButton *btnGroomer;
@property (weak, nonatomic) IBOutlet UIButton *btnKennel;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;


@property (weak, nonatomic) IBOutlet UITextField *txtDogName;
@property (weak, nonatomic) IBOutlet UITextField *txtBreed;

@property (weak, nonatomic) IBOutlet UILabel *txtTitleName;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleBirthday;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleVet;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleGroomer;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleBreed;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleKennel;

@property (weak, nonatomic) IBOutlet UILabel *lblMale;
@property (weak, nonatomic) IBOutlet UILabel *lblDog;
@property (weak, nonatomic) IBOutlet UILabel *lblFemale;
@property (weak, nonatomic) IBOutlet UILabel *lblCat;

@property (weak, nonatomic) IBOutlet UIImageView *chkMale;
@property (weak, nonatomic) IBOutlet UIImageView *chkFemale;
@property (weak, nonatomic) IBOutlet UIImageView *chkDog;
@property (weak, nonatomic) IBOutlet UIImageView *chkCat;
@property (retain, nonatomic) UIImageView* imgBorder;
@property (nonatomic, retain) UIImageView *backingViewForRoundedCorner;

@property(nonatomic, strong) PetData *objPetData;

@property(nonatomic, strong) PetModel *petModel;

@property(nonatomic, strong) UIPopoverController *contactPopover;

@property(nonatomic, copy) NSString *selectedDate;

- (IBAction)avatarClicked:(id)sender;
- (IBAction)onBirthdayTapped:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)onMaleTapped:(id)sender;
- (IBAction)onFemaleTapped:(id)sender;
- (IBAction)onDogTapped:(id)sender;
- (IBAction)onCatTapped:(id)sender;
- (IBAction)onGroomerTapped:(id)sender;
- (IBAction)onVetTapped:(id)sender;
- (IBAction)onKennelTapped:(id)sender;
- (IBAction)onSaveTapped:(id)sender;
- (void) updateImage:(UIImage *)img;
- (void)initializeWithData:(PetData *)data;
- (void)initializeWithData:(PetData *)data andContactData:(ContactData *)contact;

@end
