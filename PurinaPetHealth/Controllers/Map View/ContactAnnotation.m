//
//  ContactAnnotation.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/29/12.
//
//

#import "ContactAnnotation.h"

@implementation ContactAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize phone;


- initWithPosition:(CLLocationCoordinate2D)coords {
    if (self = [super init]) {
        self.coordinate = coords;
    }
    return self;
}

@end
