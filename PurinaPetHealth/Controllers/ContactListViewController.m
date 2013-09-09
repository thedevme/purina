//
//  ContactListViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/25/12.
//
//

#import "ContactListViewController.h"
#import "Constants.h"
#import "PetData.h"

@interface ContactListViewController ()

@end

@implementation ContactListViewController

@synthesize tableView = _tableView;
@synthesize dataStack = _dataStack;
@synthesize contacts = _contacts;
@synthesize objContact;
@synthesize isAddVisible;
@synthesize type;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)contactType andPet:(PetData *)pet displayAdd:(BOOL)add
{
    // 
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.contacts = [[NSMutableArray alloc] initWithArray:[Contact getContactData:contactType]];
        type = contactType;
        self.isAddVisible = add;
    }
    
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // withType:(NSString *)contactType andPet:(Pet *)pet displayAdd:(BOOL)add
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {


        //        self.contacts = [[NSMutableArray alloc] initWithArray:[Contact getContactData:contactType]];
        //        type = contactType;
        //        self.isAddVisible = add;
        //NSLog(@"Contact List ");
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavigationButtons];
    [self getContactData];
    [self addObservers];
    [self createModel];
    [self setDefaults];
    //NSLog(@"create %@ contact type", type);
    // Do any additional setup after loading the view from its nib.
}


- (void) setDefaults
{
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,0,0)];
    [NSTimer    scheduledTimerWithTimeInterval:0.5    target:self    selector:@selector(viewControllerDelay)    userInfo:nil repeats:NO];
    //NSLog(@" is add visible %s", isAddVisible ? "true" : "false");
}


- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    UIBarButtonItem *btnAddItem = [[UIBarButtonItem alloc] initWithTitle:@"Add New" style:UIButtonTypeCustom target:self action:@selector(onAddNewTapped:)];
    [btnAddItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnAddItem];
}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSaveContact:) name:kSaveNewContact object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddNewContactTapped:) name:kAddToPet object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddExistingContactTapped:) name:kAddExistingContact object:nil];
}

- (void) getContactData
{
    //self.contacts = [[NSMutableArray alloc] initWithArray:[[pet contact] allObjects] ];
}

- (void)addContact:(ContactData *)contact
{
    NSLog(@"contact list contact data %@", contact);
    [self.delegate addContact:contact];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) checkVetTotal
{
//    if (self.contacts.count == 0)
//    {
//
//    }

    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddContactViewController_iPhone5* addViewController = [[AddContactViewController_iPhone5 alloc] initWithNibName:@"AddContactViewController_iPhone5" bundle:nil withType:type];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
    else
    {
        AddContactViewController* addViewController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:type];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    FindAContactCell *cell;
    NSArray* nib;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        cell = (FindAContactCell_iPhone *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate = self;
        nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell_iPhone" owner:self options:nil];
    }
    else
    {
        cell = (FindAContactCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate = self;
        nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell" owner:self options:nil];
    }


    ContactData *contact = [self.contacts objectAtIndex:indexPath.row];
    //NSLog(@"%@", self.data);

    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.lblBusinessName.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    cell.lblBusinessName.textColor = [UIColor purinaDarkGrey];
    cell.lblBusinessName.backgroundColor = [UIColor clearColor];

    //42

    cell.lblAddress.font = [UIFont fontWithName:kHelveticaNeueMed size:11.0f];
    cell.lblAddress.textColor = [UIColor purinaDarkGrey];
    cell.lblAddress.backgroundColor = [UIColor clearColor];
    //55

    cell.lblCity.font = [UIFont fontWithName:kHelveticaNeueMed size:11.0f];
    cell.lblCity.textColor = [UIColor purinaDarkGrey];
    cell.lblCity.backgroundColor = [UIColor clearColor];

    //70

    cell.lblMiles.font = [UIFont fontWithName:kHelveticaNeueMed size:11.0f];
    cell.lblMiles.textColor = [UIColor purinaDarkGrey];
    cell.lblMiles.textAlignment = UITextAlignmentCenter;
    cell.lblMiles.backgroundColor = [UIColor clearColor];

    cell.lblPhone.font = [UIFont fontWithName:kHelveticaNeueMed size:11.0f];
    cell.lblPhone.textColor = [UIColor purinaDarkGrey];
    cell.lblPhone.textAlignment = UITextAlignmentLeft;
    cell.lblPhone.backgroundColor = [UIColor clearColor];

    NSString* city = [NSString stringWithFormat:@"%@, %@, %i", [contact city], [contact state], [contact zipCode]];
    cell.objContactData = contact;
    cell.lblBusinessName.text = [contact name];
    cell.lblAddress.text = [contact streetAddress];
    cell.lblPhone.text = [contact phone];
    cell.lblCity.text = city;
    cell.lblMiles.text = [NSString stringWithFormat:@"%.2f mi", [contact.distance floatValue]];

    if (!contact.isPreferred)
    {
        cell.imgStar.alpha = 0.0f;
        cell.lblBusinessName.frame = CGRectMake(10, 14, 256, 21);
    }

    NSLog(@"name %@", contact.name);

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}



- (void)onAddSelectedVetTapped:(NSNotification *)note
{
    //NSLog(@"%@", [note object]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddNewTapped:(id)sender
{
    //NSLog(@"add new tapped %@", type);
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddContactViewController_iPhone5* addVetController = [[AddContactViewController_iPhone5 alloc] initWithNibName:@"AddContactViewController_iPhone5" bundle:nil withType:type];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addVetController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
    else
    {
        AddContactViewController* addVetController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:type];
        addVetController.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addVetController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
}

- (void)addContactData:(ContactData *)contact
{
    [self.delegate addContact:contact];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSMutableArray* arrPhases = [[NSMutableArray alloc] initWithArray:[[[arrChallenges objectAtIndex:[indexPath row]] phases] allObjects]];
    //    PetDetailsViewController* petDetails = [[PetDetailsViewController alloc] initWithNibName:@"PetDetailsViewController" bundle:nil];
    //    petDetails.objPetData = [self.petNames objectAtIndex:[indexPath row]];
    //    [self.navigationController pushViewController:petDetails animated:YES];
}

- (void) onSaveContact:(NSNotification *)note
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) onAddNewContactTapped:(NSNotification *)note
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.tableView reloadData];
}

- (void) onAddExistingContactTapped:(NSNotification *)note
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSaveNewContact object:[note object]];
}

- (void) onVetSelected:(NSNotification *)note
{
}

-(void)viewControllerDelay
{
    [self checkVetTotal];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end


