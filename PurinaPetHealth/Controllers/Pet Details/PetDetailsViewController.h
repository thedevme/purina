//
//  PetDetailsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/30/12.
//
//

#import <UIKit/UIKit.h>
#import "PetDetailsViewController.h"
#import "Pet.h"
#import "Contact.h"
#import "ContactCardView.h"
#import "StyledPageControl.h"
#import "PetInfoView.h"
#import "PetMenuView.h"
#import "AvatarPickerPlus.h"
#import "AddContactViewController.h"
#import "UIColor+PetHealth.h"
#import "AddPetViewController.h"

@class PetData;
@class PetModel;

@protocol PetDetailsDelegate <NSObject>

- (void) updatePetList;

@end

@interface PetDetailsViewController : UIViewController <UIScrollViewDelegate, AvatarPickerPlusDelegate,
        ContactCardDelegate, PetMenuDelegate, AddContactDelegate, PetInfoDelegate>

@property (nonatomic, retain) PetData* objPetData;
@property (nonatomic, retain) PetInfoView* petInfoView;
@property (nonatomic, retain) PetMenuView* petMenuView;
@property (nonatomic, retain) NSArray* arrContacts;
@property (nonatomic, retain) NSMutableArray* arrContactData;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) ContactData* objContactData;
@property (weak, nonatomic) IBOutlet UILabel *lblPetName;

@property (nonatomic, retain) ContactData* objPrimaryVetData;
@property (nonatomic, retain) ContactData* objPrimaryGroomerData;
@property (nonatomic, retain) ContactData* objPrimaryKennelData;

@property (nonatomic, weak) id <PetDetailsDelegate> delegate;


@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;

@property(nonatomic, strong) PetModel *petModel;
@end
