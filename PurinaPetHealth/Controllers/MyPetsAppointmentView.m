//
//  MyPetsAppointmentView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import "MyPetsAppointmentView.h"
#import "AppointmentData.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"

@implementation MyPetsAppointmentView

- (id)initWithData:(AppointmentData *)data
{
    self = [super init];

    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MyPetsAppointmentView" owner:self options:nil];

        self = [nib objectAtIndex:0];
        self.objAppointmentData = data;
        [self initialize];
        [self setData];
    }

    return self;
}

- (void)setData
{
    self.lblTitle.text = self.objAppointmentData.title;
    self.lblType.text = self.objAppointmentData.type;
    self.lblDate.text = self.objAppointmentData.appointmentDate;
    self.lblTime.text = self.objAppointmentData.time;
}

- (void) initialize
{
    self.lblDate.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
    self.lblType.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTime.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblTitle.textColor = [UIColor purinaRed];
    self.lblDate.textColor = [UIColor purinaDarkGrey];
    self.lblType.textColor = [UIColor purinaDarkGrey];
    self.lblTime.textColor = [UIColor purinaDarkGrey];
}

@end
