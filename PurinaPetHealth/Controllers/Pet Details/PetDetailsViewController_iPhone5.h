//
//  PetDetailsViewController_iPhone5.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/26/12.
//
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "Contact.h"
#import "ContactCardView.h"
#import "StyledPageControl.h"
#import "PetInfoView.h"
#import "PetMenuView.h"
#import "AvatarPickerPlus.h"
#import "EditContactViewController.h"
#import "AddContactViewController.h"
#import "UIColor+PetHealth.h"
#import "IdentificationViewController.h"
#import "IdentificationViewController_iPhone5.h"
#import "AddPetViewController.h"

@class PetData;

@protocol PetDetailsDelegate_iPhone5 <NSObject>

- (void) updatePetList;

@end


@interface PetDetailsViewController_iPhone5 : UIViewController<UIScrollViewDelegate, AvatarPickerPlusDelegate, PetMenuDelegate, AddPetDelegate>

@property (nonatomic, retain) PetData* objPetData;
@property (nonatomic, retain) PetInfoView* petInfoView;
@property (nonatomic, retain) PetMenuView* petMenuView;
@property (nonatomic, retain) NSArray* arrContacts;
@property (nonatomic, retain) NSMutableArray* arrContactData;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) ContactData* objPrimaryVetData;
@property (nonatomic, retain) ContactData* objPrimaryGroomerData;
@property (nonatomic, retain) ContactData* objPrimaryKennelData;
@property (weak, nonatomic) IBOutlet UILabel *lblPetName;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, weak) id <PetDetailsDelegate_iPhone5> delegate;

@property(nonatomic, strong) PetModel *petModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCoreDataStack:(CoreDataStack *)cds;

@end
