//
//  FindContactViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import <UIKit/UIKit.h>
#import "ContactData.h"
#import "CoreLocationController.h"
#import "FindAContactCell_iPhone.h"
#import "FindAContactCell.h"
#import <CoreLocation/CoreLocation.h>
#import "YPRequest.h"
#import "AFNetworking.h"
#import "MapViewController.h"
#import "SVProgressHUD.h"
#import "Contact.h"

@protocol FindContactViewDelegate_iPad <NSObject>

@required
- (void) addContact:(ContactData *)contact;
@end

@interface FindContactViewController_iPad : UIViewController  <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CoreLocationConrollerDelegate, FindContactDelegate>

@property (strong, nonatomic) NSArray *data;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString* searchLocation;
@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) CoreLocationController* clController;
@property (assign) BOOL isAddVisible;

@property (nonatomic, weak) id <FindContactViewDelegate_iPad> delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)type showAdd:(BOOL)add;

@end
