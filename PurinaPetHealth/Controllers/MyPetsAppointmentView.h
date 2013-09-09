//
//  MyPetsAppointmentView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import <UIKit/UIKit.h>

@class AppointmentData;

@interface MyPetsAppointmentView : UIView

@property(nonatomic, strong) AppointmentData *objAppointmentData;


@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblType;
@property (retain, nonatomic) IBOutlet UILabel *lblDate;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;


- (id)initWithData:(AppointmentData *)data;

@end
