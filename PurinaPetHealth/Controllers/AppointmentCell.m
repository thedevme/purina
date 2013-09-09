//
//  AppointmentCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/19/12.
//
//

#import "AppointmentCell.h"

@implementation AppointmentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(AppointmentData *)data
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        //NSLog(@"%@", strData);
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 250, 20)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblType = [[UILabel alloc] initWithFrame:CGRectMake(25, 30, 250, 20)];
        _lblType.backgroundColor = [UIColor clearColor];
        
        _lblTime = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 250, 20)];
        _lblTime.backgroundColor = [UIColor clearColor];
        
        _lblDate = [[UILabel alloc] initWithFrame:CGRectMake(25, 45, 250, 20)];
        _lblDate.backgroundColor = [UIColor clearColor];
        
        _lblDate.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
        _lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
        _lblType.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
        _lblTime.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
        
        _lblTitle.textColor = [UIColor purinaRed];
        _lblDate.textColor = [UIColor purinaDarkGrey];
        _lblType.textColor = [UIColor purinaDarkGrey];
        _lblTime.textColor = [UIColor purinaDarkGrey];
        
        UIImageView* background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnDoubleListItem.png"]];
        background.frame = CGRectMake(10, 0, 300, 90);
        
        [self addSubview:background];
        [self createLabels:data];
        
    }
    return self;
}

- (void) createLabels:(AppointmentData *)data
{
    self.appointmentData = data;
    NSLog(@"%@", [data title] );
    if ([data title].length == 0) _lblTitle.text = @"No Title";
    else _lblTitle.text = [data title];
    [self addSubview:_lblTitle];
    
    _lblType.text = [data type];
    [self addSubview:_lblType];
    
    
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMM dd, yyyy"];
    NSString *strDate = [dateformatter stringFromDate:[data startDate]];
    
    NSDateFormatter *timeformatter = [[NSDateFormatter alloc] init];
    [timeformatter setDateFormat:@"h:mm a"];
    NSString *strTime = [timeformatter stringFromDate:[data startDate]];
    
    _lblDate.text = strDate;
    _lblTime.text = strTime;
    
    [self addSubview:_lblTime];
    [self addSubview:_lblDate];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onDeleteTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAppointment" object:self.appointmentData];
}
@end
