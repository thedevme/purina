//
//  FindPetCareViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"
#import "FindAContactCell.h"
#import "Flurry.h"


@class CoreLocationController;
@class ContactAnnotation;

@interface FindPetCareViewController_iPad : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CoreLocationConrollerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, FindContactDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleSearch;

@property (weak, nonatomic) IBOutlet UIButton *btnVet;
@property (weak, nonatomic) IBOutlet UIButton *btnGroomer;
@property (weak, nonatomic) IBOutlet UIButton *btnKennel;
@property (weak, nonatomic) IBOutlet UIButton *btnDogPark;

@property (strong, nonatomic) NSArray *data;
@property (nonatomic, retain) NSString* searchLocation;
@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) CoreLocationController* clController;
@property (assign) BOOL isAddVisible;


@property (nonatomic, retain) NSMutableArray* arrAnnotations;
@property (nonatomic, retain) NSArray* arrContactData;
@property (nonatomic, assign) NSString* selectedContactName;
@property (nonatomic, retain) ContactAnnotation* annotationToSelect;
@property (assign) CLLocationCoordinate2D currentLocation;
@property (assign) float latCoord;
@property (assign) float longCoord;

- (IBAction)onNavTapped:(id)sender;

@end
