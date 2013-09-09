//
//  AddPetViewController.h
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoreDataStack.h"
#import "PetData.h"
#import "Contact.h"
#import "BirthdayData.h"
#import "DatePickerViewController.h"
#import "AddContactViewController.h"
#import "BlockAlertView.h"
#import "UniqueID.h"
#import "PetDetailsViewController.h"
#import "AvatarPickerPlus.h"
#import "ContactListViewController.h"

@class TPKeyboardAvoidingScrollView;
@class PetModel;

@protocol AddPetDelegate <NSObject>

@optional
- (void) newPetAdded;
@end

@interface AddPetViewController : UIViewController <UITextFieldDelegate, AvatarPickerPlusDelegate, UIGestureRecognizerDelegate, ContactListDelegate>
{
    int numVetCount;
    int numGroomerCount;
}

@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) BirthdayData* objBirthdayData;
@property (nonatomic, retain) PetData* objPet;
@property (nonatomic, retain) ContactData* objContactData;
@property (nonatomic, retain) ContactData* objPrimaryVetData;
@property (nonatomic, retain) ContactData* objPrimaryGroomerData;
@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) id <AddPetDelegate> delegate;

@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UIButton* btnIcon;
@property (nonatomic, retain) NSManagedObjectID* primaryVetID;

@property (nonatomic, retain) NSString* strGender;
@property (nonatomic, retain) NSString* strSpecies;
@property (nonatomic, retain) NSString* strName;
@property (nonatomic, retain) NSData *imageData;

@property (nonatomic, retain) UIImageView* imgIcon;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnVet;
@property (weak, nonatomic) IBOutlet UIButton *btnGroomer;

@property (weak, nonatomic) IBOutlet UITextField *txtDogName;
@property (weak, nonatomic) IBOutlet UITextField *txtBreed;

@property (weak, nonatomic) IBOutlet UILabel *txtTitleName;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleBirthday;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleVet;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleGroomer;
@property (weak, nonatomic) IBOutlet UILabel *txtTitleBreed;

@property (weak, nonatomic) IBOutlet UILabel *lblMale;
@property (weak, nonatomic) IBOutlet UILabel *lblDog;
@property (weak, nonatomic) IBOutlet UILabel *lblFemale;
@property (weak, nonatomic) IBOutlet UILabel *lblCat;

@property (weak, nonatomic) IBOutlet UIImageView *chkMale;
@property (weak, nonatomic) IBOutlet UIImageView *chkFemale;
@property (weak, nonatomic) IBOutlet UIImageView *chkDog;
@property (weak, nonatomic) IBOutlet UIImageView *chkCat;

@property (assign) BOOL isPetBeingUpdated;

@property (nonatomic, retain) UIButton* btnUpdate;

@property(nonatomic, strong) PetData *objPetData;

@property(nonatomic, strong) PetModel *petModel;

- (IBAction)avatarClicked:(id)sender;
- (IBAction)onBirthdayTapped:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)onMaleTapped:(id)sender;
- (IBAction)onFemaleTapped:(id)sender;
- (IBAction)onDogTapped:(id)sender;
- (IBAction)onCatTapped:(id)sender;
- (IBAction)onGroomerTapped:(id)sender;
- (IBAction)onVetTapped:(id)sender;
- (IBAction)onSaveTapped:(id)sender;
- (void) initializeEdit:(PetData *)data;

@end
