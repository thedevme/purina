//
//  EditApptsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/4/13.
//
//

#import <EventKit/EventKit.h>
#import "EditApptsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "PetModel.h"
#import "AppointmentUpdater.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "ApptTypeViewController.h"
#import "ApptPetListViewController.h"

@interface EditApptsViewController ()

@end

@implementation EditApptsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    self.scrollView.delegate = self;

//    UITapGestureRecognizer *dtapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
//    dtapGestureRecognize.delegate = self;
//    dtapGestureRecognize.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:dtapGestureRecognize];
    //[self.scrollView endEditing:YES];
    [self.calendarSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
    self.isSetToCalendar = NO;

    // Do any additional setup after loading the view from its nib.
}



- (void) scrollViewTapped:(UIGestureRecognizer *)sender
{
    [self checkTextFields];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialize
{
    [self createNavigationButtons];
    self.arrSelectedPets = [[NSMutableArray alloc] init];
    self.appointmentUpdater = [[AppointmentUpdater alloc] init];
    self.appointmentUpdater.delegate = self;
    [self setFonts];
}

- (void)setFonts
{
    self.lblTitleDate.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitleDate.textColor = [UIColor purinaLightGrey];

    self.lblTitlePets.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitlePets.textColor = [UIColor purinaLightGrey];

    self.lblTitleNotes.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitleNotes.textColor = [UIColor purinaLightGrey];

    self.lblTitleSave.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitleSave.textColor = [UIColor purinaLightGrey];

    self.lblTitleType.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblTitleType.textColor = [UIColor purinaLightGrey];

    self.lblType.textColor = [UIColor purinaDarkGrey];
    self.lblType.font = [UIFont fontWithName:kHelveticaNeueCondBold size:13.0f];

    self.lblDate.textColor = [UIColor purinaDarkGrey];
    self.lblDate.font = [UIFont fontWithName:kHelveticaNeueCondBold size:13.0f];

    self.lblPets.textColor = [UIColor purinaDarkGrey];
    self.lblPets.font = [UIFont fontWithName:kHelveticaNeueCondBold size:13.0f];


    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"]; //24hr time format

    NSDate* today = [NSDate date];
    NSString *dateString = [outputFormatter stringFromDate:today];
    NSString *birthdate = [NSString stringWithFormat:@"%@, %@", [NSDate formatDate:today formatType:@"MM/dd/yyyy"], dateString];

    self.apptDate = birthdate;
    self.lblDate.text = birthdate;
    self.selectedDate = today;
}

- (void)initializeAppointmentData:(AppointmentData *)data
{
    self.appointmentData = data;
    self.apptDate = [NSString stringWithFormat:@"%@, %@", data.appointmentDate, data.time];
    self.lblDate.text = self.apptDate;
    self.txtNotes.text = self.appointmentData.notes;
    self.tfTitle.text = self.appointmentData.title;
    self.lblType.text = self.appointmentData.type;
    self.selectedType = self.appointmentData.type;
    //NSLog(@"%@", [data.pet allObjects]);
    //self.arrSelectedPets = data.pets;
    //NSMutableArray *arrPets = [[NSMutableArray alloc] init];
    self.isEditing = YES;

    NSMutableArray *pets = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.appointmentData.pets.count; i++)
    {
        [pets addObject:[[self.appointmentData.pets objectAtIndex:i] name]];
    }

//    for (int i = 0; i < [self.appointmentData.pets count]; i++)
//    {
//        [arrPets addObject:[[self.appointmentData.pets objectAtIndex:i] name] ];
//    }
//
//    if (self.arrSelectedPets.count > 0) [self.arrSelectedPets removeAllObjects];

    //NSLog(@"pets %@", data.pets);
    self.selectedPets = [pets componentsJoinedByString:@", "];
    self.lblPets.text = self.selectedPets;


    if (data.saveToCalendar) [self.calendarSwitch setOn:YES animated:YES];
    else [self.calendarSwitch setOn:NO animated:YES];
}


- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSaveItem];

    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
    [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:btnCancelItem];
}

- (void) onSaveTapped:(id)sender
{
    if (self.apptDate.length != 0 && self.tfTitle.text.length != 0)
    {
        AppointmentData* objAppointmentData = [[AppointmentData alloc] init];
        NSArray *appointmentDate = [self.apptDate componentsSeparatedByString:@", "];

        if (self.isEditing)
        {
            [self.appointmentUpdater deleteAppointment:self.appointmentData];

            self.appointmentData.pets = self.arrSelectedPets;
            self.appointmentData.appointmentDate = [appointmentDate objectAtIndex:0];
            self.appointmentData.time = [appointmentDate objectAtIndex:1];
            self.appointmentData.type = self.selectedType;
            self.appointmentData.notes = self.txtNotes.text;
            self.appointmentData.saveToCalendar = self.calendarSwitch.selected;
            self.appointmentData.title = self.tfTitle.text;
            [self saveToCalendar:self.appointmentData];
            [self.appointmentUpdater createAppointment:self.appointmentData];
            [self.delegate appointmentSaved];
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            objAppointmentData.pets = self.arrSelectedPets;
            objAppointmentData.appointmentDate = [appointmentDate objectAtIndex:0];
            objAppointmentData.time = [appointmentDate objectAtIndex:1];
            objAppointmentData.type = self.selectedType;
            objAppointmentData.notes = self.txtNotes.text;
            objAppointmentData.saveToCalendar = self.calendarSwitch.selected;
            objAppointmentData.title = self.tfTitle.text;
            [self saveToCalendar:objAppointmentData];

            [self.appointmentUpdater createAppointment:objAppointmentData];
            [self.delegate appointmentSaved];
            [self dismissModalViewControllerAnimated:YES];
        }

        [self reset];
    }
    else
    {
        BOOL isDateSet = NO;
        BOOL isTitleSet = NO;
        UIAlertView* alert;

        if (self.apptDate.length != 0 ) isDateSet = YES;
        if (self.tfTitle.text.length != 0) isTitleSet = YES;

        if (!isDateSet && !isTitleSet)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                               message:@"Please set a title & date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];

        }
        if (!isDateSet && isTitleSet)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                               message:@"Please set a date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        }
        if (isDateSet && !isTitleSet)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                               message:@"Please set a title"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        }

        [alert show];
    }
}

- (void)appointmentSaved
{

}

- (void) appointmentUpdated
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveToCalendar:(AppointmentData *)objAppointmentData {
    if (self.calendarSwitch.isOn)
    {

        NSLog(@"appointment was saved");
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = objAppointmentData.title;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:objAppointmentData.appointmentDate];
        event.startDate = dateFromString;
        event.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];

        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    }
}

- (void) switchToggled:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        NSLog(@"its on!");
        self.isSetToCalendar = YES;
    } else {
        NSLog(@"its off!");
        self.isSetToCalendar = NO;
    }
}

- (void) onCancelTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) reset
{
    self.selectedType = @"";
    self.apptDate = @"";
    self.txtNotes.text = @"";
    self.tfTitle.text = @"";
    self.lblDate.text = @"";
    [self.calendarSwitch setOn:NO animated:YES];
    self.isSetToCalendar = NO;
    self.lblPets.text = @"";

    [self.arrSelectedPets removeAllObjects];
}


- (IBAction)onTypeTapped:(id)sender
{
    [self checkTextFields];
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(showType) userInfo:nil repeats:NO];

}

- (void)showType 
{
    self.apptTypePickerViewController = [ApptTypeViewController new];
    self.apptTypePickerViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.apptTypePickerViewController];

    self.apptTypePickerViewController.contentSizeForViewInPopover = CGSizeMake(320, 200);

    if (self.apptTypePickerViewController == nil)
    {
        self.apptTypePickerViewController = [[UIPopoverController alloc] initWithContentViewController:navController];
    }


    CGRect buttonFrame;
    buttonFrame.origin.x = 200;
    buttonFrame.origin.y = 100;
    buttonFrame.size.height = 20;
    buttonFrame.size.width = 20;

    self.apptTypePickerViewController.view.superview.frame = CGRectMake(0, 0, 320, 200);
    self.apptTypePickerViewController.strSelectedType = self.appointmentData.type;
    self.typePickerPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [self.typePickerPopover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];


//    [self presentSemiViewController:self.apptTypePickerViewController withOptions:@{
//            KNSemiModalOptionKeys.pushParentBack : @(NO),
//            KNSemiModalOptionKeys.parentAlpha : @(0.2),
//            KNSemiModalOptionKeys.animationDuration : @(0.25)
//    }];
}

- (void)selectedType:(NSString *)type
{
    self.lblType.text = type;
    self.selectedType = type;
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog(@"touched ");
}

- (void)checkTextFields {
    [self.tfTitle resignFirstResponder];
    [self.txtNotes resignFirstResponder];
}

- (IBAction)onDateTapped:(id)sender
{
    [self checkTextFields];
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(showDatePicker) userInfo:nil repeats:NO];
}

- (void)showDatePicker
{
    self.datePickerView = [ApptDatePickerViewController new];
    self.datePickerView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.datePickerView];

    self.datePickerView.contentSizeForViewInPopover = CGSizeMake(320, 350);

    if (self.datePickerView == nil)
    {
        self.datePickerView = [[UIPopoverController alloc] initWithContentViewController:navController];
    }


    CGRect buttonFrame;
    buttonFrame.origin.x = 200;
    buttonFrame.origin.y = 165;
    buttonFrame.size.height = 20;
    buttonFrame.size.width = 20;

    self.datePickerView.view.superview.frame = CGRectMake(0, 0, 320, 300);
    self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [self.contactPopover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];


}

- (void)doneWithPets:(NSArray *)pets
{
    NSMutableArray *arrPets = [[NSMutableArray alloc] init];

    for (int i = 0; i < [pets count]; i++)
    {
        [arrPets addObject:[[pets objectAtIndex:i] name]];
    }

    [self.arrSelectedPets removeAllObjects];
    self.arrSelectedPets = [[NSMutableArray alloc] initWithArray:pets];
    self.selectedPets = [arrPets componentsJoinedByString:@", "];
    self.lblPets.text =  self.selectedPets;
}

- (void)dismiss
{
    [self dismissSemiModalView];
}

- (void)dismissDate
{
    [self dismissSemiModalView];
}

- (void)dismissType
{
    [self dismissSemiModalView];
}

- (void)doneWithSelectedDate:(NSString *)date andDate:(NSDate *)date1 {
    //self.apptDate = nil;
    self.apptDate = date;
    self.lblDate.text = self.apptDate;
}

- (void)doneWithSelectedType:(NSString *)type
{
    if ([type isEqualToString:@""]) self.selectedType = @"Grooming";
    self.selectedType = type;
    self.lblType.text = self.selectedType;
}

- (IBAction)onPetsTapped:(id)sender
{
    [self checkTextFields];
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(showPets) userInfo:nil repeats:NO];
}

- (void) showPets
{
    PetModel *petModel = [[PetModel alloc] init];
    NSArray *arrPets = [[NSArray alloc] initWithArray:[petModel getPetData]];

    if (arrPets.count > 0)
    {
        self.petPickerViewController = [ApptPetListViewController new];
        self.petPickerViewController.delegate = self;
        self.petPickerViewController.arrSelectedPets = self.arrSelectedPets;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.petPickerViewController];
        self.petPickerViewController.contentSizeForViewInPopover = CGSizeMake(320, 200);

        if (self.petPickerViewController == nil) self.petPickerViewController = [[UIPopoverController alloc] initWithContentViewController:navController];

        CGRect buttonFrame;
        buttonFrame.origin.x = 200;
        buttonFrame.origin.y = 330;
        buttonFrame.size.height = 20;
        buttonFrame.size.width = 20;

        self.petPickerViewController.view.superview.frame = CGRectMake(0, 0, 320, 200);

//        for (int i = 0; i < arrPets.count; i++)
//        {
//            [self.petPickerViewController.arrPets addObject:[[arrPets objectAtIndex:i] name]];
//        }

        self.petPickerPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
        [self.petPickerPopover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Pets"
                                                        message:@"You don't currently have any pets."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)selectedApptPets:(NSMutableArray *)pets
{
    NSLog(@"%@", pets);
    NSMutableArray *arrPets = [[NSMutableArray alloc] init];
    [self.arrSelectedPets removeAllObjects];

    for (int i = 0; i < [pets count]; i++)
    {
        [arrPets addObject:[[pets objectAtIndex:i] name]];
        [self.arrSelectedPets addObject:[pets objectAtIndex:i]];
    }

    self.arrUpdatedSelectedPets = [[NSMutableArray alloc] initWithArray:pets];
    self.selectedPets = [arrPets componentsJoinedByString:@", "];
    self.lblPets.text = self.selectedPets;
}


- (void)viewDidUnload
{
    [self setLblType:nil];
    [self setLblTitleDate:nil];
    [self setLblTitleSave:nil];
    [self setLblTitleNotes:nil];
    [self setLblTitlePets:nil];
    [self setCalendarSwitch:nil];
    [self setLblType:nil];
    [self setTfTitle:nil];
    [self setLblDate:nil];
    [self setTxtNotes:nil];
    [self setLblPets:nil];
    [self setScrollView:nil];
    [self setImgBackground:nil];

    [super viewDidUnload];
}

@end