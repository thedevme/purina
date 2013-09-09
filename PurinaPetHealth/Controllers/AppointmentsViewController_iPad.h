//
//  AppointmentsViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//


#import <UIKit/UIKit.h>
#import "CreateApptsViewController.h"
#import "AppointmentUpdater.h"

@class OHAttributedLabel;

@interface AppointmentsViewController_iPad : UIViewController <CreateApptDelegate,
        UITableViewDataSource, UITableViewDelegate, CreateApptDelegate, AppointmentDelegate>
{
    UIPopoverController *popover;
}


@property (nonatomic, retain) NSDateComponents *components;
@property (nonatomic, retain) NSDateComponents *dateComps;
@property (nonatomic, retain) NSCalendar* cal;
@property (nonatomic, retain) NSCalendar *gregorian;
@property (nonatomic, retain) NSTimeZone *pacificTime;

@property (weak, nonatomic) IBOutlet UILabel *lblMonthYr;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleSun;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleMon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleTue;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleWed;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleThu;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleFri;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleSat;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedDay;
@property (nonatomic, retain) NSString * selectedPets;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblMessage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *arrAppointments;
@property (nonatomic, retain) NSMutableArray *arrSelectedDayApppintments;
@property (nonatomic, strong) UIBarButtonItem *btnAddNew;
@property (nonatomic, retain) UIView * container;
@property (nonatomic, strong) NSMutableArray *days;
@property (nonatomic, retain) NSDate* objSelectedDate;
@property (nonatomic, retain) AppointmentUpdater* updater;


@property(nonatomic, strong) AppointmentData *objSelectedAppointment;

- (IBAction)onArrowTapped:(id)sender;

@end

