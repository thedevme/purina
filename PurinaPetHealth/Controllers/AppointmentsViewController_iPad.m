//
//  AppointmentsViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//

#import "AppointmentsViewController_iPad.h"
#import "DayView.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "OHAttributedLabel.h"
#import "OHASBasicMarkupParser.h"
#import "CreateApptsViewController.h"
#import "AppointmentCell.h"
#import "EditApptsViewController.h"

@interface AppointmentsViewController_iPad ()
{
    NSInteger day;
    NSInteger month;
    NSInteger year;
}

@end

@implementation AppointmentsViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Appointments";
        self.navigationItem.title = @"Appointments";
        self.tabBarItem.image = [UIImage imageNamed:@"iconAppointments.png"];
        [self.navigationController setNavigationBarHidden:YES];

    }

    return self;
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    self.btnAddNew = [[UIBarButtonItem alloc] initWithTitle:@"Add New" style:UIButtonTypeCustom target:self action:@selector(onNewTapped:)];
    [self.btnAddNew setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:self.btnAddNew];

}

- (void) createGrid
{
    
    NSRange range = [self.cal rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:[self.cal dateFromComponents:self.dateComps]];
    
    NSDate *dateOfKeynote = [self.dateComps date];
    NSDateComponents *weekdayComponents = [self.gregorian components:NSWeekdayCalendarUnit fromDate:dateOfKeynote];
    NSInteger weekday = [weekdayComponents weekday];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentMonth = [components month];
    
    
    int numTotalGridWidth = 7;
    int numCount = 0;
    
    for (int i = 0; i < range.length; i++)
    {
        int numRange;
        
        if (i == 0)  numRange = weekday - 1;
        else numRange = 0;
        
        for (int colIndex = numRange; colIndex < numTotalGridWidth; colIndex++)
        {
            if (numCount < range.length)
            {
                numCount++;
                
                float numXSpacing = (float) (colIndex * 82);
                float numYSpacing = (float) (i * 93);
                
                DayView* dayView = [[DayView alloc] initWithDay:[self getDate:numCount]];
                dayView.tag = numCount;
                if (currentMonth == month)
                {
                    if (numCount == day) dayView.isSelected = YES;
                }
                else
                {
                    if (numCount == 1) dayView.isSelected = YES;
                    else dayView.isSelected = NO;
                }
                
                [dayView setSelected];
                
                UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayTapped:)];
                gestureRecognizer.numberOfTapsRequired = 1;
                [dayView addGestureRecognizer:gestureRecognizer];
                dayView.frame = CGRectMake(numXSpacing, numYSpacing, 83, 93);
                [self.days addObject:dayView];
                [self.container addSubview:dayView];
            }
        }
    }
}

- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:22]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"Appointments"]];
    
    self.lblMessage.attributedText = attrStr;
}

- (void) setSelectedDay:(NSInteger)numDay
{
    NSString *strDate = [NSString stringWithFormat:@"%i-%i-%i", numDay, [self.dateComps month], [self.dateComps year]];
    //NSLog(@"get date: %@", [self getDate:numDay]);
    NSDate *dateFromString = [self getDate:numDay];
    //dateFromString = [self getShortDate:strDate];
    NSString *dayOfWeek = [self getDayOfTheWeek:dateFromString];
    //dateFromString = ;
    
    //NSString *calendarDate = [self getFullDate:strDate];
    
    self.objSelectedDate = dateFromString;
    //NSLog(@"selected date %@", self.objSelectedDate);
    
    self.lblMonthYr.text = [NSString stringWithFormat:@"%@",[self getMonthYr:strDate]];
    self.lblSelectedDay.text = [NSString stringWithFormat:@"%@, %@", dayOfWeek, [self getFullDate:strDate]];

    [self checkForAppointments];
}

- (NSString *)getMonthYr:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d-M-yyyy"];
    NSDate *fullDate = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    NSString *resultString =  [dateFormatter stringFromDate:fullDate];
    
    return resultString;
}


- (NSString *)getFullDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d-M-yyyy"];
    NSDate *fullDate = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    NSString *resultString =  [dateFormatter stringFromDate:fullDate];
    
    return resultString;
}

- (NSString *)getDayOfTheWeek:(NSDate *)date
{
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    
    return [weekday stringFromDate:date];
}

- (void)setLabels
{
    self.lblTitleMon.textColor = [UIColor purinaDarkGrey];
    self.lblTitleTue.textColor = [UIColor purinaDarkGrey];
    self.lblTitleWed.textColor = [UIColor purinaDarkGrey];
    self.lblTitleThu.textColor = [UIColor purinaDarkGrey];
    self.lblTitleFri.textColor = [UIColor purinaDarkGrey];
    self.lblTitleSat.textColor = [UIColor purinaDarkGrey];
    self.lblTitleSun.textColor = [UIColor purinaDarkGrey];
    
    self.lblTitleMon.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleTue.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleWed.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleThu.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleFri.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleSat.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblTitleSun.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    
    self.lblSelectedDay.textColor = [UIColor purinaDarkGrey];
    self.lblSelectedDay.font = [UIFont fontWithName:kHelveticaNeueCondBold size:25.0f];
}


- (NSDate *) getDate:(int)count
{
    NSString *strDate = [NSString stringWithFormat:@"%i-%i-%i", count, [self.dateComps month], [self.dateComps year]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d-M-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:strDate];
    
    return dateFromString;
}

- (void) createCalendar
{
    self.container = [[UIView alloc] init];
    self.container.frame = CGRectMake(25, 84, 578, 561);
    [self.view addSubview:self.container];
    
    self.cal = [NSCalendar currentCalendar];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.pacificTime = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    self.dateComps = [[NSDateComponents alloc] init];
    self.components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    day = [self.components day];
    month = [self.components month];
    year = [self.components year];
    
    [self.dateComps setCalendar:self.gregorian];
    [self.dateComps setYear:year];
    [self.dateComps setMonth:month];
    [self.dateComps setDay:1];
    [self.dateComps setTimeZone:self.pacificTime];
    
    self.lblMonthYr.text = [NSString stringWithFormat:@"December %i", year];
    self.lblMonthYr.textColor = [UIColor purinaDarkGrey];
    self.lblMonthYr.font = [UIFont fontWithName:kHelveticaNeueCondBold size:35.0f];
    
    [self setSelectedDay:day];
}

- (void)dayTapped:(UIGestureRecognizer *)sender
{
    [self resetSelected:[[sender view] tag]];
    [self setSelectedDay:[[sender view] tag]];
    
}

- (void)resetSelected:(NSInteger)tag
{
    for (int i = 0; i < [self.days count]; i++)
    {
        DayView *dayView = [self.days objectAtIndex:i];
        
        if (tag == [dayView tag]) dayView.isSelected = YES;
        else dayView.isSelected = NO;
        
        [dayView setSelected];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
}

- (void)initialize
{

    self.updater = [[AppointmentUpdater alloc] init];
    self.updater.delegate = self;

    [self setArrays];
    [self createMessage:@"You currently have no \nAppointments set today!"];
    [self createCalendar];
    [self createGrid];
    [self createNavigationButtons];
    [self setLabels];
    [self checkForAppointments];



    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAppointment:) name:@"deleteAppointment" object:nil];
}

- (void) deleteAppointment:(NSNotification *)note
{
    [self.updater deleteAppointment:[note object]];

    [self resetCalendar];
    [self createGrid];

    [self.arrAppointments removeAllObjects];
    self.arrAppointments = [self.updater getAppointments];
    [self checkForAppointments];

}

- (void)checkForAppointments
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    [self.arrSelectedDayApppintments removeAllObjects];

    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSLog(@"selected date %@", self.objSelectedDate);
    
    for (int i = 0; i < [self.arrAppointments count]; i++)
    {
        AppointmentData *appt = [self.arrAppointments objectAtIndex:i];
        NSDateComponents* components = [calendar components:flags fromDate:appt.startDate];
        NSDate* dateOnly = [calendar dateFromComponents:components];
        
        if ([self isSameDay:appt.startDate otherDay:self.objSelectedDate]){
            NSLog(@"dates are the same %@", appt.title);
            [self.arrSelectedDayApppintments addObject:appt];
        }
        else
        {
            NSLog(@"dates are not the same");
        }
        
        for (int j = 0; j < [self.days count]; j++)
        {
            DayView *dayView = [self.days objectAtIndex:j];
            NSDateComponents* components = [calendar components:flags fromDate:dayView.objDate];
            NSDate* dateViewOnly = [calendar dateFromComponents:components];
            BOOL same = [dateOnly isEqualToDate:dateViewOnly];
            
            if (same)
            {
                [dayView setApptDay:same];
                //NSLog(@"today is true %@", dayView);
            }
            
            //NSLog(@"selected date %@", self.objSelectedDate);
            NSDateComponents* todayComponents = [calendar components:flags fromDate:self.objSelectedDate];
            NSDate* selectedDate = [calendar dateFromComponents:todayComponents];
            BOOL today = [selectedDate isEqualToDate:dateOnly];
            
            if (today)
            {
                //NSLog(@"today is true %@", appt);
            }
        }
    }
    
    [self.tableView reloadData];

    if ([self.arrSelectedDayApppintments count] > 0)
    {
        self.lblMessage.alpha = 0;
    }
    else
    {
        self.lblMessage.alpha = 1;
    }
    //NSLog(@"count %i", [self.arrSelectedDayApppintments count]);
}

- (void)appointmentUpdated
{
    //[self resetCalendar];
    //[self createGrid];
    //[self checkForAppointments];
}

- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

- (void)setArrays
{
    self.days = [[NSMutableArray alloc] init];
    self.arrSelectedDayApppintments = [[NSMutableArray alloc] init];
    self.arrAppointments = [[NSMutableArray alloc] initWithArray:[self.updater getAppointments]];
    NSLog(@"set array %@", self.arrAppointments);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLblMonthYr:nil];
    [self setLblTitleSun:nil];
    [self setLblTitleMon:nil];
    [self setLblTitleTue:nil];
    [self setLblTitleWed:nil];
    [self setLblTitleThu:nil];
    [self setLblTitleFri:nil];
    [self setLblTitleSat:nil];
    [self setLblSelectedDay:nil];
    [self setLblMessage:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void) resetCalendar
{
    for (UIView *i in self.container.subviews)
        [i removeFromSuperview];
}

- (IBAction)onArrowTapped:(id)sender
{
    //NSLog(@"%i", [sender tag]);
    if ([sender tag] == 2)
    {
        if (month == 12)
        {
            month = 1;
            year = year + 1;
        }
        else
        {
            month = month + 1;
        }
    }
    else
    {
        if (month == 1)
        {
            month = 12;
            year = year - 1;
        }
        else
        {
            month = month - 1;
        }
    }
    
    [self.dateComps setCalendar:self.gregorian];
    [self.dateComps setYear:year];
    [self.dateComps setMonth:month];
    [self.dateComps setDay:1];
    [self setSelectedDay:1];
    
    [self.days removeAllObjects];
    
    [self resetCalendar];
    [self createGrid];
    [self checkForAppointments];
}

- (void)onNewTapped:(id)sender
{
    [self presentModal];
}

- (void) presentModal
{
    CreateApptsViewController *createApptsView = [CreateApptsViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createApptsView];
    createApptsView.delegate = self;
    createApptsView.contentSizeForViewInPopover = CGSizeMake(320, 450);
    createApptsView.view.superview.frame = CGRectMake(0, 0, 320, 450);

    if (popover == nil)
    {
        popover = [[UIPopoverController alloc] initWithContentViewController:navController];
    }

    [popover presentPopoverFromBarButtonItem:self.btnAddNew permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrSelectedDayApppintments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AppointmentCell *cell = (AppointmentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"AppointmentCell" owner:self options:nil];
    AppointmentData* objAppointment = [self.arrSelectedDayApppintments objectAtIndex:[indexPath row]];

    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.lblDate.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    cell.lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
    cell.lblType.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    cell.lblTime.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    cell.lblTitle.textColor = [UIColor purinaRed];
    cell.lblDate.textColor = [UIColor purinaDarkGrey];
    cell.lblType.textColor = [UIColor purinaDarkGrey];
    cell.lblTime.textColor = [UIColor purinaDarkGrey];

    cell.lblTitle.text = objAppointment.title;
    cell.lblType.text = objAppointment.type;
    cell.lblDate.text = [NSString stringWithFormat:@"%@, %@", objAppointment.appointmentDate, objAppointment.time];

//    AppointmentData *objAppointmentData = [[AppointmentData alloc] init];
//    objAppointmentData.appointmentDate = objAppointment.appointmentDate;
//    objAppointmentData.time = objAppointment.time;
//    objAppointmentData.notes = objAppointment.notes;
//    objAppointmentData.title = objAppointment.title;
//    objAppointmentData.type = objAppointment.type;
//    objAppointmentData.guid = objAppointment.guid;
//    objAppointmentData.saveToCalendar = objAppointment.saveToCalendar.boolValue;
//    objAppointmentData.pets = [objAppointment.pet allObjects];
//    NSLog(@"pets appt %@", objAppointmentData.pets);
//
//    NSArray *arrPetData = [[NSMutableArray alloc] initWithArray:[objAppointment.pet allObjects]];
    NSMutableArray *pets = [[NSMutableArray alloc] init];
    for (int i = 0; i < objAppointment.pets.count; i++)
    {
        [pets addObject:[[objAppointment.pets objectAtIndex:i] name]];
    }

    cell.appointmentData = objAppointment;

    self.selectedPets = [pets componentsJoinedByString:@", "];
    cell.lblTime.text = self.selectedPets;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentData* objAppointmentData = [self.arrSelectedDayApppintments objectAtIndex:[indexPath row]];
    NSLog(@"%@", objAppointmentData.title);

    EditApptsViewController *editApptsViewController = [[EditApptsViewController alloc]
            initWithNibName:@"EditApptsViewController"
                     bundle:nil];
    editApptsViewController.delegate = self;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editApptsViewController];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navController animated:YES];

    self.objSelectedAppointment = nil;
    self.objSelectedAppointment = objAppointmentData;


    NSLog(@"pets appt %@", self.objSelectedAppointment);


    
    [editApptsViewController initializeAppointmentData:self.objSelectedAppointment];
}

- (void) appointmentSaved
{

    [self resetCalendar];
    [self createGrid];

    [self.arrAppointments removeAllObjects];
    self.arrAppointments = [self.updater getAppointments];
    NSLog(@"appt array %@", self.arrAppointments);
    [self checkForAppointments];
}

- (void) appointmentUpdated:(Appointment *)appointment
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", appointment.guid];
    Appointment *objAppointment = [[self.arrAppointments filteredArrayUsingPredicate:predicate] lastObject];
    NSUInteger index = [self.arrAppointments indexOfObject:objAppointment];

    [self resetCalendar];
    [self createGrid];

    [self.arrAppointments removeObjectAtIndex:index];
    [self.arrAppointments insertObject:appointment atIndex:index];
    [self checkForAppointments];
    [self.tableView reloadData];

    NSLog(@"appointment saved");
}

- (void)updateApptDetails:(AppointmentData *)data
{
}

@end
