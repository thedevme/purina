//
//  IdentificationItem.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//

#import "IdentificationItem.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@implementation IdentificationItem

- (id)initWithLabel:(NSString *)label andData:(NSString *)data
{
    self = [super init];

    if (self)
    {
        self.label = label;
        self.value = data;
        
        [self createBackground];
        [self createLabels];
        [self createValue];
    }
    return self;
}

- (void)createBackground
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnSingleListItem.png"]];
    background.frame = CGRectMake(0, 0, 307, 51);
    [self addSubview:background];
}

- (void) createLabels
{
    self.lblName = [[UILabel alloc] init];
    self.lblName.backgroundColor = [UIColor clearColor];
    self.lblName.frame = CGRectMake(10, 12, 200, 21);
    self.lblName.text = self.label;
    [self addSubview:self.lblName];
}

- (void)createValue
{
    self.lblValue = [[UILabel alloc] init];
    self.lblValue.backgroundColor = [UIColor clearColor];
    self.lblValue.frame = CGRectMake(95, 12, 200, 21);
    self.lblValue.textColor = [UIColor purinaDarkGrey];
    self.lblValue.textAlignment = UITextAlignmentRight;
    self.lblValue.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    if (![self.value isEqualToString:@"NA"]) self.lblValue.text = self.value;
    [self addSubview:self.lblValue];
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
