//
//  CreateApptsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
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
#import "Flurry.h"

@class TDDatePickerController;
@class PetPickerViewController;
@class ApptDatePickerViewController;
@class ApptTypePickerViewController;
@class AppointmentUpdater;


@protocol CreateApptDelegate <NSObject>

- (void) appointmentSaved;

@end



@interface CreateApptsViewController : UIViewController  <UIScrollViewDelegate, PetPickerDelegate, ApptDatePickerDelegate, ApptTypePickerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

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
@property (strong, nonatomic) NSDate* today;
@property (assign) BOOL isSetToCalendar;
@property (assign) BOOL isEditing;
@property (nonatomic, weak) id <CreateApptDelegate> delegate;
//@property(nonatomic, strong) UIView *coverView;

@property (strong, nonatomic) IBOutlet UIImageView *imgBackground;



@property (nonatomic, retain) NSDate* selectedDate;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic, strong) ApptDatePickerViewController *datePickerView;
@property(nonatomic, strong) PetPickerViewController *petPickerViewController;
@property(nonatomic, strong) ApptTypePickerViewController *apptTypePickerViewController;


@property(nonatomic, copy) NSString *apptDate;

@property(nonatomic, copy) NSString *todaysDate;

@property(nonatomic, strong) NSMutableArray *arrSelectedPets;

@property(nonatomic, copy) NSString *selectedType;

@property(nonatomic, strong) AppointmentUpdater *appointmentUpdater;
@property(nonatomic, strong) AppointmentData *appointmentData;

@property(nonatomic, strong) NSDate *appointmentStartDate;

@property(nonatomic) BOOL isTypeTapped;

@property(nonatomic) BOOL isDateSelected;

@property(nonatomic) BOOL isPetsSelected;

- (IBAction)onTypeTapped:(id)sender;
- (IBAction)onDateTapped:(id)sender;
- (IBAction)onPetsTapped:(id)sender;
- (void) initializeAppointmentData:(AppointmentData *)data;

@end
