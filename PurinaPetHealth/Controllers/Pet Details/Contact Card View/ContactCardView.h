//
//  ContactCardView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/7/12.
//
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "CoreLocationController.h"
#import "ContactListViewController.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "Flurry.h"

@class PetModel;

@protocol ContactCardDelegate <NSObject>

- (void)addContact:(NSString *)type withData:(ContactData *)data;

@end


@interface ContactCardView : UIView <CoreLocationConrollerDelegate, FindContactDelegate, AddContactDelegate>

@property (nonatomic, retain) IBOutlet UIButton* btnCall;
@property (nonatomic, retain) IBOutlet UIButton* btnMap;
@property (nonatomic, retain) IBOutlet UIButton* btnEmail;
@property (nonatomic, retain) IBOutlet UIButton* btnSeeAll;
@property (nonatomic, retain) IBOutlet UIButton* btnContact;
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (strong, nonatomic) IBOutlet UIButton *btnCard;


@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (nonatomic, retain) IBOutlet UILabel* lblName;
@property (nonatomic, retain) IBOutlet UILabel* lblAddress;
@property (nonatomic, retain) IBOutlet UILabel* lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblSeeAll;

@property (nonatomic, retain) NSArray* arrContacts;
@property (nonatomic, retain) ContactData* objPrimaryContact;
@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) CoreLocationController* clController;
@property (nonatomic, weak) id <ContactCardDelegate> delegate;

@property(nonatomic, strong) PetModel *petModel;

- (id)initWithContactData:(ContactData *)data withType:(NSString *)type;



- (IBAction) btnSelected:(id)sender;
- (IBAction)onCardTapped:(id)sender;

@end
