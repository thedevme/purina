//
//  PetMenuView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/7/12.
//
//

#import "PetMenuView.h"

@implementation PetMenuView
@synthesize btnIdentification;
@synthesize btnAppt;
@synthesize btnMedical;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //[self setBackground];
        [self createMenu];
    }
    return self;
}

- (void) setBackground
{
    UIImageView* imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile-middle-bg.png"]];
    imgBackground.frame = CGRectMake(10, 9, 300, 102);
    [self addSubview:imgBackground];
}

- (void) createMenu
{
    //Identification
    btnIdentification = [UIButton buttonWithType:UIButtonTypeCustom];
    btnIdentification.frame = CGRectMake(7, 20, 102, 86);
    btnIdentification.tag = 0;
    [btnIdentification setBackgroundImage:[UIImage imageNamed:@"iconPDIden.png"] forState:UIControlStateNormal];
    [btnIdentification addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnIdentification];
    
    //Medical
    btnMedical = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMedical.frame = CGRectMake(109, 20, 102, 86);
    btnMedical.tag = 1;
    [btnMedical setBackgroundImage:[UIImage imageNamed:@"iconPDMed.png"] forState:UIControlStateNormal];
    [btnMedical addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnMedical];
    
    //Appointments
    btnAppt = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAppt.frame = CGRectMake(211, 20, 102, 86);
    btnAppt.tag = 2;
    [btnAppt setBackgroundImage:[UIImage imageNamed:@"iconPDAppt.png"] forState:UIControlStateNormal];
    [btnAppt addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnAppt];
}

- (void) btnSelected:(id)sender
{
    NSLog(@"%i", [sender tag]);
    [_delegate changeView:[sender tag]];
}



@end
