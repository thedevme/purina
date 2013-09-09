//
//  VetCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/9/12.
//
//

#import <UIKit/UIKit.h>
#import "ContactData.h"
#import "Contact.h"


@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (assign) BOOL isAlreadyAdded;

@property (nonatomic, retain) ContactData* objContactData;
@property (nonatomic, retain) Contact* objContact;


- (IBAction)onAddTapped:(id)sender;
@end
