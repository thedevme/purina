//
//  ViewApptsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
//
//

#import "ViewApptsViewController.h"
#import "BlockAlertView.h"

@interface ViewApptsViewController ()

@end

@implementation ViewApptsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Appointments";
        //self.navigationItem.title = @"Appointments";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,0,0)];
    [self initialize];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAppointment:) name:@"deleteAppointment" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if (self.arrAppointments.count == 0)
    {
        [self createMessage:@"You currently\n have no appointments added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
}

- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"appointments"]];

    self.lblMessage.alpha = 1.0f;
    self.lblMessage.attributedText = attrStr;
}

- (void) deleteAppointment:(NSNotification *)note
{
    self.selectedAppointmentData = [note object];

    NSString *message = [NSString stringWithFormat:@"Are you sure you want to delete this %@ appointment?", self.selectedAppointmentData.title];
    NSString *title = [NSString stringWithFormat:@"Delete %@?", self.selectedAppointmentData.title];
    BlockAlertView *alert = [BlockAlertView alertWithTitle:title message:message];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];

    [alert setDestructiveButtonWithTitle:@"Delete" block:^{
        
        
        
        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_DELETEAPPOINTMENT"];
        [self.updater deleteAppointment:self.selectedAppointmentData];
        [self sortAppointmentsByDate];
    }];

    [alert show];
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(alertView.tag==0)
//    {
//        if(buttonIndex == 0)
//        {
//
//        }
//    }
//}

- (void) initialize
{
    _updater = [[AppointmentUpdater alloc] init];
    NSArray *arrAppointments = [[NSArray alloc] initWithArray:[_updater getAppointments]];
    NSArray *sortedAllDataArray = [arrAppointments sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES]]];

    _arrAppointments = [[NSMutableArray alloc] initWithArray:sortedAllDataArray];

    [self createNavigationButtons];

    if (self.arrAppointments.count == 0)
    {
        [self createMessage:@"You currently\n have no appointments added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIButtonTypeCustom target:self action:@selector(onAddTapped:)];
    [btnAdd setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnAdd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    // Return the number of rows in the section.
    return [_arrAppointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    AppointmentCell *cell = (AppointmentCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"AppointmentCell" owner:self options:nil];
    AppointmentData *objAppointment = [_arrAppointments objectAtIndex:[indexPath row]];

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

    cell.appointmentData = objAppointment;
    cell.lblTitle.text = objAppointment.title;
    cell.lblType.text = objAppointment.type;
    cell.lblDate.text = [NSString stringWithFormat:@"%@, %@", objAppointment.appointmentDate, objAppointment.time];

    

    NSMutableArray *arrPets = [[NSMutableArray alloc] init];


    for (int i = 0; i < [objAppointment.pets count]; i++)
    {
        [arrPets addObject:[[objAppointment.pets objectAtIndex:i] name]];
    }

    [self.arrSelectedPets removeAllObjects];
    self.arrSelectedPets = [[NSMutableArray alloc] initWithArray:objAppointment.pets];
    self.selectedPets = [arrPets componentsJoinedByString:@", "];

    cell.lblTime.text = self.selectedPets;

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void) onAddTapped:(id)sender
{
    CreateApptsViewController* createView = [[CreateApptsViewController alloc] initWithNibName:@"CreateApptsViewController" bundle:nil];
    createView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navController animated:YES];
}

- (void) appointmentSaved
{
    [_arrAppointments removeAllObjects];
    [self sortAppointmentsByDate];
    if (self.arrAppointments.count == 0)
    {
        [self createMessage:@"You currently\n have no appointments added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
    NSLog(@"appointment saved");

}

- (void)sortAppointmentsByDate {
    NSArray *data = [[NSArray alloc] initWithArray:[_updater getAppointments]];
    NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    NSArray *sortDescriptors = @[ageDescriptor];
    NSArray *sortedArray = [data sortedArrayUsingDescriptors:sortDescriptors];
    
    self.arrAppointments.array = sortedArray;
    NSLog(@"%@", self.arrAppointments);
    
    [self.tableView reloadData];
    if (self.arrAppointments.count == 0)
    {
        [self createMessage:@"You currently\n have no appointments added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
    NSLog(@"log sort by appt done");
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentData* objAppointmentData = [_arrAppointments objectAtIndex:[indexPath row]];
    NSLog(@"%@", [_arrAppointments objectAtIndex:[indexPath row]]);
    CreateApptsViewController *createApptsViewController = [[CreateApptsViewController alloc]
    initWithNibName:@"CreateApptsViewController"
    bundle:nil];
    createApptsViewController.delegate = self;
    createApptsViewController.isEditing = YES;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createApptsViewController];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navController animated:YES];
    [createApptsViewController initializeAppointmentData:objAppointmentData];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblMessage:nil];
    [super viewDidUnload];
}
@end
