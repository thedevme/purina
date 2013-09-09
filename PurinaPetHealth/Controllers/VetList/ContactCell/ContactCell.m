//
//  VetCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/9/12.
//
//

#import "ContactCell.h"
#import "Constants.h"

@implementation ContactCell

@synthesize lblBusinessName;
@synthesize lblAddress;
@synthesize lblCity;
@synthesize btnAdd;
@synthesize objContact;
@synthesize objContactData;
@synthesize isAlreadyAdded;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onAddTapped:(id)sender
{
//    objContactData.street = objContact.streetAddress;
//    objContactData.name = objContact.name;
//    objContactData.zip = [objContact.zipCode intValue];
//    objContactData.phone = objContact.phone;
//    objContactData.state = objContact.state;
    //NSLog(@"add vet to pet tapped %@", objContact);
    if (!isAlreadyAdded) [[NSNotificationCenter defaultCenter] postNotificationName:kAddToPet object:objContact];
    else [[NSNotificationCenter defaultCenter] postNotificationName:kAddExistingContact object:objContact]; NSLog(@"contact added");
}
@end
