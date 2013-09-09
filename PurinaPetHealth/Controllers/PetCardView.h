//
//  PetCardView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import <UIKit/UIKit.h>
#import "PetData.h"

#import <QuartzCore/QuartzCore.h>

@class ContactData;
@class PetModel;
@class CoreDataStack;


@protocol PetCardDelegate <NSObject>

- (void) deletePet:(PetData *)pet;
- (void) editPet:(PetData *)pet;
- (void) editPet:(PetData *)pet withContactData:(ContactData *)contact;

@end

@interface PetCardView : UIView

- (id)initWithPetData:(PetData *)data;

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
@property (strong, nonatomic) IBOutlet UILabel *lblDelete;
@property (strong, nonatomic) IBOutlet UIImageView *imgPetIcon;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property(nonatomic, strong) PetData *objPetData;
@property(nonatomic, strong) NSMutableArray *arrContacts;
@property(nonatomic, strong) NSMutableArray *arrCards;


@property (nonatomic, weak) id <PetCardDelegate> delegate;

@property(nonatomic, strong) UIImageView *avatar;

@property(nonatomic, strong) PetModel *petModel;

@property(nonatomic, retain) CoreDataStack* dataStack;

- (IBAction)onEditTapped:(id)sender;
- (IBAction)onDeleteTapped:(id)sender;
- (void) updateCard:(PetData *)data;
@end
