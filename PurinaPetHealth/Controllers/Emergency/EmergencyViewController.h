//
//  EmergencyViewController.h
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CoreDataStack.h"
#import "ContactData.h"
#import "CoreLocationController.h"
#import "FindAContactCell_iPhone.h"
#import "YPRequest.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Contact.h"

@class EmergencyVetModel;
@class OHAttributedLabel;

@interface EmergencyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CoreLocationConrollerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitleEmergency;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleNearby;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *btnEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnMap;
@property (strong, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnArrow;

@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) NSString* searchLocation;

@property (strong, nonatomic) NSArray *data;
@property (assign) BOOL isAddVisible;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) CoreLocationController* clController;

@property(nonatomic, strong) EmergencyVetModel *emergencyModel;

@property(nonatomic, strong) ContactData *contactData;

- (IBAction)onPhoneTapped:(id)sender;
- (IBAction)onEmailTapped:(id)sender;
- (IBAction)onMapTapped:(id)sender;

@end
