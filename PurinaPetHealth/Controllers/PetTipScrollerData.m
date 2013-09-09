//
//  PetTipScrollerData.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/18/12.
//
//

#import "PetTipScrollerData.h"

@implementation PetTipScrollerData


- (id)init
{
    self = [super init];

    if (self)
    {
        self.categoryArray = [[NSMutableArray alloc] init];
        self.fullArray = [[NSMutableArray alloc] init];
        self.selectedPosition = 0;
        self.title = NSLocalizedString(@"All", nil);
    }
    return self;
}

@end
