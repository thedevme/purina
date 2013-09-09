//
//  CreateApptsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
//
//

#import <EventKit/EventKit.h>
#import "CreateApptsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "ApptTypePickerViewController.h"
#import "AppointmentUpdater.h"
#import "AppointmentData.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "PetModel.h"
#import "BlockAlertView.h"
#import "BlockAlertViewLandscape.h"


@interface CreateApptsViewController ()

@end

@implementation CreateApptsViewController


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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
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

    self.lblType.text = @"Veterinarian";
    self.selectedType = @"Veterinarian";

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"]; //24hr time format

    self.today = [NSDate date];
    NSString *dateString = [outputFormatter stringFromDate:self.today];
    self.todaysDate = [NSString stringWithFormat:@"%@, %@", [NSDate formatDate:self.today formatType:@"MM/dd/yyyy"], dateString];

    self.apptDate = self.todaysDate;
    self.lblDate.text = self.todaysDate;
    self.selectedDate = self.today;
}

- (void)initializeAppointmentData:(AppointmentData *)data
{
    self.appointmentData = data;
    self.apptDate = [NSString stringWithFormat:@"%@, %@", data.appointmentDate, data.time];
    self.lblDate.text = self.apptDate;
    self.txtNotes.text = data.notes;
    self.tfTitle.text = data.title;
    //NSLog(@"%@", [data.pet allObjects]);
    //self.arrSelectedPets = data.pets;
    NSMutableArray *arrPets = [[NSMutableArray alloc] init];
    self.isEditing = YES;
    for (int i = 0; i < [self.appointmentData.pets count]; i++)
    {
        [arrPets addObject:[[self.appointmentData.pets objectAtIndex:i] name]];
    }

    [self.arrSelectedPets removeAllObjects];
    self.arrSelectedPets = [[NSMutableArray alloc] initWithArray:self.appointmentData.pets];
    self.selectedPets = [arrPets componentsJoinedByString:@", "];
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

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }
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

            NSLog(@"is editing save tapped");

        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            NSDate *dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:objAppointmentData.appointmentDate];
            objAppointmentData.pets = self.arrSelectedPets;
            objAppointmentData.appointmentDate = [appointmentDate objectAtIndex:0];
            objAppointmentData.time = [appointmentDate objectAtIndex:1];
            objAppointmentData.type = self.selectedType;
            objAppointmentData.startDate = self.appointmentStartDate;
            objAppointmentData.notes = self.txtNotes.text;
            objAppointmentData.saveToCalendar = self.calendarSwitch.selected;
            objAppointmentData.title = self.tfTitle.text;

            [self saveToCalendar:objAppointmentData];

            [self.appointmentUpdater createAppointment:objAppointmentData];
            [self.delegate appointmentSaved];
            [self dismissModalViewControllerAnimated:YES];

            objAppointmentData = nil;
        }

        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_SAVEAPPOINTMENT"];

        [self reset];

    }
    else
    {
        BOOL isDateSet = NO;
        BOOL isTitleSet = NO;
        NSString *message;

        if (self.apptDate.length != 0 ) isDateSet = YES;
        if (self.tfTitle.text.length != 0) isTitleSet = YES;

        if (!isDateSet && !isTitleSet)
        {
            message = @"Please set a title & date";
        }
        if (!isDateSet && isTitleSet)
        {
            message = @"Please set a date";
        }
        if (isDateSet && !isTitleSet)
        {
            message = @"Please enter a title";
        }


        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Sorry!" message:message];
            [alert setCancelButtonWithTitle:@"OK" block:nil];
            [alert show];
        }
        else
        {

//            UIAlertView* alert;
//            alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
//                                               message:message
//                                              delegate:self
//                                     cancelButtonTitle:@"OK"
//                                     otherButtonTitles:nil, nil];
//
//            [alert show];

            BlockAlertViewLandscape *alert = [[BlockAlertViewLandscape alloc] init];
            alert.numTitleOffset = 15;
            alert.numMessageOffset = 80;
            alert.numButtonYOffset = 10;
            alert.numHeightOffset = 130;
            alert.numButtonXOffset = 110;
            [alert initWithTitle:@"Sorry!" message:message];
            [alert setCancelButtonWithTitle:@"OK" block:nil];
            [alert showWithOneButton];
        }



    }
}

- (void) updateAppointment
{

}

- (void)saveToCalendar:(AppointmentData *)objAppointmentData
{
    if (self.calendarSwitch.isOn)
    {
        EKEventStore *eventStore = [[EKEventStore alloc] init];




        if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
        {
            /* iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE */
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
            {
                if ( granted )
                {
                    NSLog(@"User has granted permission! %@", self.appointmentStartDate);
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = objAppointmentData.title;
                    event.startDate = self.appointmentStartDate;
                    event.endDate   = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:self.appointmentStartDate];
                    event.notes = [NSString stringWithFormat:@"%@ - %@",objAppointmentData.type, objAppointmentData.notes];
                    event.calendar = eventStore.defaultCalendarForNewEvents;
                    //[event setCalendar:[eventStore defaultCalendarForNewEvents]];

                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                }
            }];
        }
        else
        {
            EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            event.title     = objAppointmentData.title;
            event.startDate = self.appointmentStartDate;
            event.endDate   = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:self.appointmentStartDate];
            event.notes = [NSString stringWithFormat:@"%@ - %@",objAppointmentData.type, objAppointmentData.notes];
            event.calendar = eventStore.defaultCalendarForNewEvents;
            //[event setCalendar:[eventStore defaultCalendarForNewEvents]];

            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        }





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
    self.selectedType = @"Veterinarian";
    self.lblType.text = self.selectedType;
    self.apptDate = @"";
    self.txtNotes.text = @"";
    self.tfTitle.text = @"";
    self.lblDate.text = @"";
    [self.calendarSwitch setOn:NO animated:YES];
    self.isSetToCalendar = NO;
    self.isDateSelected = NO;
    self.isPetsSelected = NO;
    self.lblPets.text = @"";

    [self.arrSelectedPets removeAllObjects];

    self.apptDate = self.todaysDate;
    self.lblDate.text = self.todaysDate;
    self.selectedDate = self.today;
    self.appointmentData = nil;
}


- (IBAction)onTypeTapped:(id)sender
{

    [self checkTextFields];
    [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(showType) userInfo:nil repeats:NO];

}

- (void)showType
{
    if (!self.isTypeTapped)
    {
        self.apptTypePickerViewController = [[ApptTypePickerViewController alloc]
                initWithNibName:@"ApptTypePickerViewController"
                         bundle:nil];
        self.apptTypePickerViewController.delegate = self;

        [self presentSemiViewController:self.apptTypePickerViewController withOptions:@{
                KNSemiModalOptionKeys.pushParentBack : @(NO),
                KNSemiModalOptionKeys.parentAlpha : @(0.2),
                KNSemiModalOptionKeys.animationDuration : @(0.25)
        }];
    }

    self.isTypeTapped = YES;
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
    if (!self.isDateSelected)
    {
        self.datePickerView = [[ApptDatePickerViewController alloc]
                initWithNibName:@"ApptDatePickerViewController"
                         bundle:nil];
        self.datePickerView.delegate = self;

        [self presentSemiViewController:self.datePickerView withOptions:@{
                KNSemiModalOptionKeys.pushParentBack : @(NO),
                KNSemiModalOptionKeys.parentAlpha : @(0.2),
                KNSemiModalOptionKeys.animationDuration : @(0.25)
        }];
    }

    self.isDateSelected = YES;
}

- (void)doneWithPets:(NSArray *)pets
{

    NSLog(@"done with pets %@", pets);
    NSMutableArray *arrPets = [[NSMutableArray alloc] init];

    for (int i = 0; i < [pets count]; i++)
    {
        [arrPets addObject:[[pets objectAtIndex:i] name]];
    }

    //[self.arrSelectedPets removeAllObjects];
    self.arrSelectedPets = [[NSMutableArray alloc] initWithArray:pets];
    self.selectedPets = [arrPets componentsJoinedByString:@", "];
    self.lblPets.text =  self.selectedPets;
    [self dismissSemiModalView];

    NSLog(@"reset selected pets %@", self.arrSelectedPets);

    self.isPetsSelected = NO;
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
    self.appointmentStartDate = date1;
    self.apptDate = date;
    self.lblDate.text = self.apptDate;
    [self dismissSemiModalView];
    self.isDateSelected = NO;
}

- (void)doneWithSelectedType:(NSString *)type 
{
    if ([type isEqualToString:@""]) self.selectedType = @"Grooming";
    self.selectedType = type;
    self.lblType.text = self.selectedType;
    [self dismissSemiModalView];
    self.isTypeTapped = NO;
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
        if (!self.isPetsSelected)
        {
            self.petPickerViewController = [[PetPickerViewController alloc]
                    initWithNibName:@"PetPickerViewController"
                             bundle:nil];
            self.petPickerViewController.delegate = self;

            NSLog(@"selected pets %@", self.arrSelectedPets);
            self.petPickerViewController.selectedPetsData = self.arrSelectedPets;

            [self presentSemiViewController:self.petPickerViewController withOptions:@{
                    KNSemiModalOptionKeys.pushParentBack : @(NO),
                    KNSemiModalOptionKeys.parentAlpha : @(1),
                    KNSemiModalOptionKeys.animationDuration : @(0.25)
            }];
            
            self.isPetsSelected = YES;
        }
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
