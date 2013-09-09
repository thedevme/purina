//
//  EmergencyViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"
#import "OHAttributedLabel.h"
#import "FindAContactCell.h"
#import "EditContactViewController_iPad.h"
#import "Flurry.h"

@class CoreLocationController;
@class ContactAnnotation;
@class CoreDataStack;
@class EmergencyVet;
@class ContactData;
@class EmergencyVetModel;

@interface EmergencyViewController_iPad : UIViewController <UITableViewDataSource, UITableViewDelegate,
        UISearchBarDelegate, CoreLocationConrollerDelegate, MKMapViewDelegate, CLLocationManagerDelegate,
        FindContactDelegate, EditContactDelegate>
{
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleSearch;

@property (weak, nonatomic) IBOutlet UILabel *lblTitleEmergency;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;


@property (strong, nonatomic) NSArray *data;
@property (nonatomic, retain) NSString* searchLocation;
@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) CoreLocationController* clController;

@property (nonatomic, retain) EmergencyVet* objEmergencyVet;
@property (nonatomic, retain) ContactData *contactData;
@property (assign) BOOL isAddVisible;


@property (nonatomic, retain) NSMutableArray* arrAnnotations;
@property (nonatomic, retain) NSArray* arrContactData;
@property (nonatomic, assign) NSString* selectedContactName;
@property (nonatomic, retain) ContactAnnotation* annotationToSelect;
@property (assign) CLLocationCoordinate2D currentLocation;
@property (assign) float latCoord;
@property (assign) float longCoord;


@property(nonatomic, strong) NSMutableArray *contacts;
@property(nonatomic, strong) CoreDataStack *dataStack;
@property(nonatomic, strong) EmergencyVetModel *emergencyModel;

- (IBAction)onEmailTapped:(id)sender;
- (IBAction)onMapTapped:(id)sender;
- (IBAction)onCardTapped:(id)sender;

@end
