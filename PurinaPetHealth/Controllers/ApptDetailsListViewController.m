//
//  ApptDetailsListViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import "ApptDetailsListViewController.h"
#import "Constants.h"

@interface ApptDetailsListViewController ()
{
    NSIndexPath* lastIndexPath;
}

@end

@implementation ApptDetailsListViewController

@synthesize arrListItems;
@synthesize strType;
@synthesize strSelectedItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andListType:(NSString *)listType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self setArrayData:listType];
    }
    
    return self;
}

- (void) setArrayData:(NSString *)type
{
    strType = type;
    
    if ([type isEqualToString:kReminder])
    {
        arrListItems = [[NSMutableArray alloc] initWithObjects:@"None",
                        @"At time of event",
                        @"5 minutes before",
                        @"10 minutes before",
                        @"15 minutes before",
                        @"30 minutes before",
                        @"1 hour before",
                        @"2 hour before",
                        @"1 day before",
                        @"2 days before",
                        nil];
    }
    
    if ([type isEqualToString:kAppointment])
    {
        arrListItems = [[NSMutableArray alloc] initWithObjects:@"Veterinarian",
                        @"Grooming",
                        @"Vaccination",
                        @"Medication",
                        @"Heartworm Prevention",
                        @"Flea Control",
                        @"Surgery",
                        @"Training",
                        @"Walking/Sitting",
                        nil];
    }
    
    if ([type isEqualToString:kRepeat])
    {
        arrListItems = [[NSMutableArray alloc] initWithObjects:@"Never",
                        @"Every Day",
                        @"Every Week",
                        @"Every 2 Weeks",
                        @"Every Month",
                        @"Every Year",
                        nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavigationButtons];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrListItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellAccessoryCheckmark reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
    cell.textLabel.text = [arrListItems objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void) createNavigationButtons
{
    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(onDoneTapped:)];
    btnDoneItem.tintColor = [UIColor colorWithRed:145.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = btnDoneItem;
}

- (void) onDoneTapped:(id)sender
{
    AppointmentTypeData* objAppointmentData = [[AppointmentTypeData alloc] init];
    objAppointmentData.type = strType;
    objAppointmentData.value = strSelectedItem;
    objAppointmentData.minutes = [self getTotalMinutes];
    
    
    
    
    
    
    [self.delegate addItemViewController:self didFinishEnteringItem:objAppointmentData];
    [self.navigationController popViewControllerAnimated:YES];
}


- (int) getTotalMinutes
{
    if ([strType isEqualToString:kAppointment]) return 0;
    
    if ([strType isEqualToString:kReminder])
    {
        if ([strSelectedItem isEqualToString:@"None"]) return 0;
        if ([strSelectedItem isEqualToString:@"At time of event"]) return 0;
        if ([strSelectedItem isEqualToString:@"5 minutes before"]) return -5;
        if ([strSelectedItem isEqualToString:@"10 minutes before"]) return -10;
        if ([strSelectedItem isEqualToString:@"15 minutes before"]) return -15;
        if ([strSelectedItem isEqualToString:@"30 minutes before"]) return -30;
        if ([strSelectedItem isEqualToString:@"1 hour before"]) return -60;
        if ([strSelectedItem isEqualToString:@"2 hour before"]) return -120;
        if ([strSelectedItem isEqualToString:@"1 day before"]) return -1440;
        if ([strSelectedItem isEqualToString:@"2 days before"]) return -2880;
    }
    
    
    if ([strType isEqualToString:kRepeat])
    {
        if ([strSelectedItem isEqualToString:@"Never"]) return 0;
        if ([strSelectedItem isEqualToString:@"Every Day"]) return 1440;
        if ([strSelectedItem isEqualToString:@"Every Week"]) return 10080;
        if ([strSelectedItem isEqualToString:@"Every 2 Weeks"]) return 20160;
        if ([strSelectedItem isEqualToString:@"Every Month"]) return 0;
        if ([strSelectedItem isEqualToString:@"Every Year"]) return 0;
    }
    
    
    return 0;
    
    
    
    //1440 = 1 day
    //10080 = 1 week
    //20160 = 2 weeks
    //Reminder every month by calendar
    //Reminder every year by calendar
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* newCell = [tableView cellForRowAtIndexPath:indexPath];
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;
    
    if(newRow != oldRow)
    {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell* oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;
        strSelectedItem = [arrListItems objectAtIndex:[indexPath row]];
    }
}

@end
