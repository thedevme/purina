//
//  ContactAnnotation.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/29/12.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ContactAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* phone;


- initWithPosition:(CLLocationCoordinate2D)coords;
@end
