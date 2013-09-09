//
//  CoreLocationController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/8/12.
//
//

#import "CoreLocationController.h"

@implementation CoreLocationController
@synthesize locationManager;
@synthesize delegate;

- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    return self;
}

#pragma mark -
#pragma mark delegate methods

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if ([self.delegate conformsToProtocol:@protocol(CoreLocationConrollerDelegate)])
    {
        [self.delegate locationUpdate:newLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([self.delegate conformsToProtocol:@protocol(CoreLocationConrollerDelegate)])
    {
        NSMutableString* errorString = [[NSMutableString alloc] init];
        
        if ([error domain] == kCLErrorDomain)
        {
            switch ([error code])
            {
                case kCLErrorDenied:
                    [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationDenied", nil)];
                    break;
                    
                case kCLErrorLocationUnknown:
                    [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationUnknown", nil)];
                    break;
                    
                default:
                    [errorString appendFormat:@"%@\n", NSLocalizedString(@"GenericLocationError", nil)];
                    break;
            }
        }
        else
        {
            [errorString appendFormat:@"Error domain: \"%@\" Error code: %d\n", [error domain], [error code]];
            [errorString appendFormat:@"Description: \"%@\n", [error localizedDescription]];
        }
        
        [self.delegate locationError:errorString];
    }
}



- (void) setPurpose:(NSString *)purpose
{
    self.locationManager.purpose = purpose;
}


- (CLLocationCoordinate2D) getUsersCurrentPosition
{
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 30;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D location = locationManager.location.coordinate;
    
    return location;
}

@end
