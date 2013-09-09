//
//  PurinaItemButton.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/1/12.
//
//

#import "PurinaItemButton.h"

@implementation PurinaItemButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (id) init:(NSString *)label
{
    
    self = [super init];
    
    if (self)
    {
        UIColor* darkGrey = [UIColor colorWithRed:86.0f/255.0f green:86.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
        [self setBackgroundImage:[UIImage imageNamed:@"btnSingleListItemWArrow.png"] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setTitle:label forState:UIControlStateNormal];
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
        [self setFrame:CGRectMake(0, 0, 306, 51)];
        
        [self setTitleColor:darkGrey forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0f];
        
        
    }
    
    return self;
}


- (id) initWithLargeBtn:(NSString *)label
{
    
    self = [super init];
    if (self)
    {
        UIColor* darkGrey = [UIColor colorWithRed:86.0f/255.0f green:86.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
        [self setBackgroundImage:[UIImage imageNamed:@"btnSingleListItem-586h.png"] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setTitle:label forState:UIControlStateNormal];
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
        [self setFrame:CGRectMake(0, 0, 306, 65)];
        
        
        
        [self setTitleColor:darkGrey forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20.0f];
    
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

@end
