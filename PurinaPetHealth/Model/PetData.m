//
//  PetData.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import "PetData.h"

@implementation PetData

- (id) init
{
    self = [super init];

    if (self)
    {
        self.appointments = [[NSMutableArray alloc] init];
        self.contacts = [[NSMutableArray alloc] init];
        self.medicalItems = [[NSMutableArray alloc] init];
    }

    return self;
}





@end
