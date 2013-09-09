//
//  HomeTipCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//


#import "HomeTipCell.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@implementation HomeTipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setFonts];
    }
    
    return self;
}

- (void)setFonts
{
    int numNameXPos = (self.lblTitle.center.x * 2) + 10;
    int numAddressXPos = (self.lblDesc.center.x * 2) + 10;
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(numNameXPos, 10, 244, 21)];
    self.lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:18.0f];
    self.lblTitle.textColor = [UIColor purinaRed];
    self.lblTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblTitle];
    //42
    self.lblDesc = [[UILabel alloc] initWithFrame:CGRectMake(numAddressXPos, 30, 207, 21)];
    self.lblDesc.font = [UIFont fontWithName:kHelveticaNeueMed size:12.0f];
    self.lblDesc.textColor = [UIColor purinaDarkGrey];
    self.lblDesc.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblDesc];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnTipArrow.png"]];
    arrow.frame = CGRectMake(370, 28, 30, 30);
    [self addSubview:arrow];
    
    UIImageView* horizontalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blogLine.png"]];
    horizontalLine.frame = CGRectMake(0, 78, 400, 2);
    [self addSubview:horizontalLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    NSNumber* myNum;
    myNum = @1.2f;
}

@end
