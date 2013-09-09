//
//  DayView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//

#import "DayView.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@implementation DayView
{
    NSInteger day;
    NSInteger month;
    NSInteger year;
}

- (id)initWithDay:(NSDate *)date
{
    self = [super init];

    if (self)
    {
       self.objDate = [[NSDate alloc] init];
       self.objDate = date;
       NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.objDate];
       day = [components day];
       month = [components month];
       year = [components year];

       [self createLabel];
       [self createBackground];
       [self createDot];
    }

    return self;
}

- (void)createBackground 
{
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedDay.png"]];
    self.background.frame = CGRectMake(0, 0, 83, 92);
    self.background.alpha = 1.0f;
    [self addSubview:self.background];
}

- (void) createDot
{
    self.apptCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendarDot.png"]];
    self.apptCircle.frame = CGRectMake(5, 50, 37, 37);
    self.apptCircle.alpha = 0.0f;
    [self addSubview:self.apptCircle];
}

- (void)createLabel 
{
    self.lblDate = [[UILabel alloc] init];
    self.lblDate.text = [NSString stringWithFormat:@"%i", day];
    self.lblDate.textAlignment = UITextAlignmentRight;
    self.lblDate.backgroundColor = [UIColor clearColor];
    self.lblDate.textColor = [UIColor purinaDarkGrey];
    self.lblDate.font = [UIFont fontWithName:kHelveticaNeueCondBold size:16.0f];
    self.lblDate.frame = CGRectMake(0, 3, 76, 21);
    [self addSubview:self.lblDate];
}

- (void) setApptDay:(BOOL)value
{
    if (value) self.apptCircle.alpha = 1.0f;
    else self.apptCircle.alpha = 0.0f;
}

- (void) setSelected
{
    //self.background.alpha = 1.0f;
    if (self.isSelected) self.background.alpha = 1.0f;
    else self.background.alpha = 0.0f;
}






@end
