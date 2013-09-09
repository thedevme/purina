//
//  MapViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/29/12.
//
//
#define SPAN_VALUE 0.02f

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize arrContactData;
@synthesize arrAnnotations;
@synthesize mapView;
@synthesize longCoord;
@synthesize latCoord;
@synthesize annotationToSelect;
@synthesize selectedContactName;
@synthesize currentLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.mapView.delegate = self;
    
    NSLog(@"%f %f", longCoord, latCoord);
    [self setMapRegion];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) setMapRegion
{
    MKCoordinateRegion region;
    region.center.latitude = latCoord;
    region.center.longitude = longCoord;
    region.span.latitudeDelta = SPAN_VALUE;
    region.span.longitudeDelta = SPAN_VALUE;
    
    NSLog(@"%f %f", longCoord, latCoord);
    [self.mapView setRegion:region animated:NO];
    [self createAnnotations];
}

- (void) createAnnotations
{
    arrAnnotations = [[NSMutableArray alloc] init];
    for (int i = 0; i < [arrContactData count]; i++)
    {
        NSLog(@"create ann");
        CLLocationCoordinate2D location;
        location.latitude = [[arrContactData objectAtIndex:i] latCoordinate];
        location.longitude = [[arrContactData objectAtIndex:i] longCoordinate];
        ContactAnnotation* annotation = [[ContactAnnotation alloc] init];
        [annotation setCoordinate:location];
        annotation.title = [[arrContactData objectAtIndex:i] name];
        annotation.subtitle = [[arrContactData objectAtIndex:i] streetAddress];
        annotation.phone = [[arrContactData objectAtIndex:i] phone];
        
        if (latCoord == location.latitude && longCoord == location.longitude &&  [selectedContactName isEqualToString:[[arrContactData objectAtIndex:i] name]])
        {
            annotationToSelect = annotation;
        }
        
        [arrAnnotations addObject:annotation];
    }
    
    NSLog(@"%@", arrAnnotations);
    
    [self.mapView addAnnotations:arrAnnotations];
    
    [self setSelectAnnotation];
}

- (void) setSelectAnnotation
{
    for (id<MKAnnotation> currentAnnotation in self.mapView.annotations)
    {
        if ([currentAnnotation isEqual:annotationToSelect]) {
            [self.mapView selectAnnotation:currentAnnotation animated:FALSE];
        }
    }
}


- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    
    NSLog(@"map view did finish loading");
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView)
    {
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES; 
        
        UIButton *btnDirections = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIButton *btnCall = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnDirections setBackgroundImage:[UIImage imageNamed:@"btnAnnDirections.png"] forState:UIControlStateNormal];
        [btnCall setBackgroundImage:[UIImage imageNamed:@"btnAnnCall.png"] forState:UIControlStateNormal];
        customPinView.rightCalloutAccessoryView = btnDirections;
        customPinView.rightCalloutAccessoryView.tag = 2;
        customPinView.leftCalloutAccessoryView = btnCall;
        customPinView.leftCalloutAccessoryView.tag = 1;
        customPinView.enabled = YES;
        
        return customPinView;
    }
    
    else
    {
        pinView.annotation = annotation;
        return pinView;
    }
}


- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    ContactAnnotation* annotation = (ContactAnnotation *)[view annotation];
    if ([control tag] == 1)
    {
        NSString *phoneStripped = [[annotation phone]
                                         stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString* phoneNo = [NSString stringWithFormat:@"tel:%@", phoneStripped];
        NSLog(@"%@", phoneNo);
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneNo];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    
    if ([control tag] == 2)
    {
        NSString* address = [annotation subtitle];
        NSString *url;
        NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        
        if ( 6 == [[versionCompatibility objectAtIndex:0] intValue] )
        {
            url = [NSString stringWithFormat: @"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@",
                   self.currentLocation.latitude, self.currentLocation.longitude,
                   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
                   self.currentLocation.latitude, self.currentLocation.longitude,
                   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
