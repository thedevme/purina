//
//  EditApptsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/4/13.
//
//

#import <UIKit/UIKit.h>



#import "NSDate+Helper.h"
#import "PetListViewController.h"
#import "AppointmentData.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "PetPickerViewController.h"
#import "ApptDatePickerViewController.h"
#import "ApptTypePickerViewController.h"
#import "ApptTypeViewController.h"
#import "ApptPetListViewController.h"
#import "AppointmentUpdater.h"

@class TDDatePickerController;
@class PetPickerViewController;
@class ApptDatePickerViewController;
@class ApptTypePickerViewController;

@class ApptPetListViewController;


@protocol EditApptDelegate <NSObject>

- (void) appointmentSaved;

@optional
- (void)appointmentUpdated:(Appointment *)appointment;
@end



@interface EditApptsViewController : UIViewController  <UIScrollViewDelegate, PetPickerDelegate, ApptDatePickerDelegate,
        ApptTypeDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, ApptPetListDelegate, AppointmentDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTitleType;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleDate;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleSave;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleNotes;
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePets;
@property (strong, nonatomic) IBOutlet UISwitch *calendarSwitch;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblPets;
@property (strong, nonatomic) IBOutlet UITextView *txtNotes;
@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (nonatomic, retain) NSString * selectedPets;
@property (assign) BOOL isSetToCalendar;
@property (assign) BOOL isEditing;
@property (nonatomic, weak) id <EditApptDelegate> delegate;
//@property(nonatomic, strong) UIView *coverView;

@property (strong, nonatomic) IBOutlet UIImageView *imgBackground;



@property (nonatomic, retain) NSDate* selectedDate;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic, strong) ApptDatePickerViewController *datePickerView;
@property(nonatomic, strong) ApptPetListViewController *petPickerViewController;
@property(nonatomic, strong) ApptTypeViewController *apptTypePickerViewController;


@property(nonatomic, copy) NSString *apptDate;

@property(nonatomic, strong) NSMutableArray *arrSelectedPets;

@property(nonatomic, copy) NSString *selectedType;

@property(nonatomic, strong) AppointmentUpdater *appointmentUpdater;
@property(nonatomic, strong) Appointment *appointment;
@property(nonatomic, strong) AppointmentData *appointmentData;

@property(nonatomic, strong) UIPopoverController *contactPopover;

@property(nonatomic, strong) UIPopoverController *petPickerPopover;

@property(nonatomic, strong) UIPopoverController *typePickerPopover;

@property(nonatomic, strong) NSMutableArray *arrUpdatedSelectedPets;

- (IBAction)onTypeTapped:(id)sender;
- (IBAction)onDateTapped:(id)sender;
- (IBAction)onPetsTapped:(id)sender;

- (void) initializeAppointmentData:(Appointment *)data;

@end
