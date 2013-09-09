//
//  ContactListViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/25/12.
//
//

#import <UIKit/UIKit.h>

#import "CoreDataStack.h"
#import "ContactCell.h"
#import "ContactData.h"
#import "Contact.h"
#import "Pet.h"
#import "AddContactViewController.h"
#import "AddContactViewController_iPhone5.h"

@class PetData;

@protocol ContactListDelegate <NSObject>

@required
- (void) addContact:(ContactData *)contact;
@end


@interface ContactListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FindContactViewDelegate, FindContactDelegate, AddContactDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) NSMutableArray* contacts;
@property (nonatomic, retain) Contact* objContact;
@property (nonatomic, retain) NSString* type;
@property (assign) BOOL isAddVisible;

@property (nonatomic, weak) id <ContactListDelegate> delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)contactType andPet:(PetData *)pet displayAdd:(BOOL)add;
///- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)contactType displayAdd:(BOOL)add;
@end
