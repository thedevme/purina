//
//  AppointmentCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/19/12.
//
//

#import <UIKit/UIKit.h>
#import "AppointmentData.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@interface AppointmentCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblType;
@property (retain, nonatomic) IBOutlet UILabel *lblDate;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;

@property (nonatomic, retain) AppointmentData* appointmentData;

- (IBAction)onDeleteTapped:(id)sender;


@end
