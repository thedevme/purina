//
// Created by craigclayton on 12/17/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PetTipData.h"
#import "TipData.h"


@implementation PetTipData

- (id)init
{
    self = [super init];

    if (self)
    {
        self.categoryArray = [[NSMutableArray alloc] init];
        self.filteredArray = [[NSMutableArray alloc] init];
        self.fullArray = [[NSMutableArray alloc] init];
        self.tipCategoriesArray = [[NSMutableArray alloc] init];
        self.data = [[TipData alloc] init];
        self.selectedCategory = NSLocalizedString(@"All", nil);
    }
    return self;
}


@end