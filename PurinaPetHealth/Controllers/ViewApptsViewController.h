//
//  ViewApptsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
//
//

#import <UIKit/UIKit.h>
#import "AppointmentUpdater.h"
#import "AppointmentData.h"
#import "AppointmentCell.h"
#import "CreateApptsViewController.h"
#import "OHAttributedLabel.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"
#import "Flurry.h"


@interface ViewApptsViewController : UIViewController <CreateApptDelegate>

@property (nonatomic, retain) AppointmentUpdater* updater;
@property (nonatomic, retain) NSMutableArray* arrAppointments;
@property (nonatomic, retain) NSMutableArray* arrSelectedPets;
@property (nonatomic, retain) NSString * selectedPets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblMessage;


@property(nonatomic, strong) AppointmentData* selectedAppointmentData;
@end
