//
//  MapViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/29/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContactData.h"
#import "ContactAnnotation.h"


@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) NSMutableArray* arrAnnotations;
@property (nonatomic, retain) NSArray* arrContactData;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) NSString* selectedContactName;
@property (nonatomic, retain) ContactAnnotation* annotationToSelect;
@property (assign) CLLocationCoordinate2D currentLocation;
@property (assign) float latCoord;
@property (assign) float longCoord;


- (void) setMapRegion;
- (void) createAnnotations;

@end
