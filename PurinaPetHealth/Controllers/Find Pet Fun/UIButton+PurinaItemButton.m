//
//  UIButton+PurinaItemButton.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/1/12.
//
//

#import "UIButton+PurinaItemButton.h"

@implementation UIButton (PurinaItemButton)

- (id) init
{
    
    self = [super init];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"btnSingleListItemWArrow.png"] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setTitle:@"Test Button" forState:UIControlStateNormal];
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
        [self setFrame:CGRectMake(0, 0, 200, 31)];
    }
    return self;
    
}

- (id) initWithLargeBtn
{
    
    self = [super init];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"btnSingleListItem-586h.png"] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setTitle:@"Test Button" forState:UIControlStateNormal];
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
        [self setFrame:CGRectMake(0, 0, 306, 115)];
    }
    return self;
    
}

@end
