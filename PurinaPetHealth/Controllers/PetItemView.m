//
//  PetItemView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import "PetItemView.h"

@implementation PetItemView
@synthesize isItemSelected;
@synthesize imgCheckMark;
@synthesize delegate;
@synthesize objPet;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        isItemSelected = NO;
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)onItemTapped:(id)sender
{
    if (isItemSelected)
    {
        isItemSelected = NO;
        imgCheckMark.alpha = 0.0f;
        [self deselectedPet:objPet];
    }
    else
    {
        isItemSelected = YES;
        imgCheckMark.alpha = 1.0f;
        [self selectedPet:objPet];
    }
    
}

- (void) selectedPet:(Pet *)pet
{
    if ([self delegate] != nil)
        [[self delegate] selectedPet:pet];
}

- (void) deselectedPet:(Pet *)pet
{
    if ([self delegate] != nil)
        [[self delegate] deselectedPet:pet];
}


@end
