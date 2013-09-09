//
//  CoreLocationController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol CoreLocationConrollerDelegate

@optional
- (void) locationUpdate:(CLLocation *)location;
- (void) locationError:(NSString *)text;
@end


@interface CoreLocationController : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager* locationManager;
    __weak id <CLLocationManagerDelegate> delegate;
}

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (weak) id delegate;

- (void) setPurpose:(NSString *)purpose;
//- (void) setLocationManager;
- (CLLocationCoordinate2D) getUsersCurrentPosition;




@end
