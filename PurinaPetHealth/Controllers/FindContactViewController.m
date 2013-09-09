//
//  FindContactViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/24/12.
//
//

#define kAPIKEY "8729ab9732ea172e4b4bc8ba02525d5c"
#define kCLIENTID "GXIH1IWYPYB3CQGVI1K2Q540ENTXE0HDH13AK2IK0MIVBFIZ"
#define kCLIENTSECRET "0WWV3PV51MG5GPRONV4VRHS0L23WOUBZ5INB3OKC5NAVAECQ"

#import "FindContactViewController.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@interface FindContactViewController ()
 
@end

@implementation FindContactViewController

@synthesize data;
@synthesize tableView;
@synthesize searchBar;
@synthesize searchLocation;
@synthesize clController;
@synthesize isAddVisible;
@synthesize strType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)type showAdd:(BOOL)add
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        strType = type;
        
        if ([strType isEqualToString:kGroomer]) self.navigationItem.title = @"Groomers";
        if ([strType isEqualToString:kVeterinarian]) self.navigationItem.title = @"Veterinarians";
        if ([strType isEqualToString:kKennel]) self.navigationItem.title = @"Kennels";
        if ([strType isEqualToString:kDogPark]) self.navigationItem.title = @"Dog Parks";
        
        isAddVisible = add;
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) self.view.superview.bounds = CGRectMake(0, 0, 320, 480);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavBar];
    [self setDefaults];
    [self createCoreLocation];
    [self addObservers];
    [self addNavButton];
    [self getUsersPosition];

    self.lblPreferred.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblPreferred.textColor = [UIColor purinaDarkGrey];

    [self checkType];
}

- (void)checkType
{
    if ([self.strType isEqualToString:kVeterinarian])
    {
        self.tableView.frame = CGRectMake(0, 79, 320, self.view.frame.size.height);
    }
    else
    {
        self.imgHeaderBG.alpha = 0.0f;
        self.imgStar.alpha = 0.0f;
        self.lblPreferred.alpha = 0.0f;
    }

}

- (void) createNavBar
{
    NSLog(@"contentType is %@", strType);
    if ([strType isEqualToString:kDogPark])
    {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) createCoreLocation
{
    clController = [[CoreLocationController alloc] init];
    clController.delegate = self;
    [clController.locationManager startUpdatingLocation];
}

- (void) fetchVetData
{
    AFJSONRequestOperation* op;
    NSLog(@"fetch strData: %@", strType);
    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:[YPRequest getYellowPagesData:searchLocation withSearhType:strType]
                                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                             [self parseData:JSON];
                                                             [SVProgressHUD showSuccessWithStatus:@"Load Complete"];
                                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                     NSError *error, id JSON) {
                                                             //[self displayError];
                                                             [SVProgressHUD showErrorWithStatus:@"There was an error!"];
                                                             NSLog(@"error");
                                                             //[_hud hide:YES];
                                                         }];
    
    [op start];
}

- (void) parseData:(NSDictionary *)searchData
{
    NSDictionary* items = [searchData objectForKey:@"Result"];

    NSMutableArray*arrContacts = [[NSMutableArray alloc] init];

    for (NSDictionary* dictionary in [items copy])
    {
        ContactData* contact = [[ContactData alloc] init];
        contact.name = [dictionary objectForKey:@"Firm_Name"];
        contact.streetAddress = [dictionary objectForKey:@"Address"];
        contact.city = [dictionary objectForKey:@"City"];
        contact.state = [dictionary objectForKey:@"State"];
        contact.listingID = [dictionary objectForKey:@"ListingID"];
        contact.phone = [dictionary objectForKey:@"Phone"];

        NSString *strPreferred = [dictionary objectForKey:@"PreferredVendor"];
        if ([strPreferred isEqualToString:@"False"]) contact.isPreferred = NO;
        if ([strPreferred isEqualToString:@"True"]) contact.isPreferred = YES;

        //NSLog(@"contact preferred %@", strPreferred);

        contact.distance = [NSNumber numberWithFloat:[[dictionary objectForKey:@"Miles"] floatValue]];
        contact.type = self.strType;
        contact.longCoordinate = [[dictionary objectForKey:@"Longitude"] floatValue];
        contact.latCoordinate = [[dictionary objectForKey:@"Latitude"] floatValue];
        contact.zipCode = [[dictionary objectForKey:@"ZipCode"] intValue];
        [arrContacts addObject:contact];
    }

//    NSArray *sortedArray;
//    sortedArray = [arrContacts sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
//        NSNumber *first = [(ContactData *) a distance];
//        NSNumber *second = [(ContactData *) b distance];
//        return [first compare:second];
//    }];
//    self.data = nil;
    self.data = arrContacts;

    [self.tableView reloadData];


    NSLog(@"there are %i total", self.data.count);
}

- (void) getUsersPosition
{
    CLLocationCoordinate2D location = [clController getUsersCurrentPosition];
    NSLog(@"%f %f", location.latitude, location.longitude);
    searchLocation = [NSString stringWithFormat:@"%f%@%f", location.latitude, @":", location.longitude];
    NSLog(@"%f %f", location.latitude, location.longitude);
    
    if (location.latitude != 0 && location.longitude != 0)
    {
        [SVProgressHUD showWithStatus:@"Loading ..."];
        [self sendRequest];
    }
}

- (void) setDefaults
{
    self.searchBar.delegate = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,0,0)];
}

- (void) addNavButton
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIImage *locationIcon = [UIImage imageNamed:@"locationIcon.png"];
        UIButton *btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLocation.bounds = CGRectMake( 0, 0, 32, 32 );
        [btnLocation setImage:locationIcon forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnLocation];
        [item setTarget:self];
        [item setAction:@selector(onLocationTapped:)];
        [self.navigationItem setRightBarButtonItem:item];
    }
}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onContactSelected:) name:kAddNewContact object:nil];
}

- (void)sendRequest
{
    if (![searchLocation isEqualToString:@""])
    {
        [self fetchVetData];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setSearchBar:nil];
    [self setLblPreferred:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    FindAContactCell *cell;
    NSArray* nib;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        cell = (FindAContactCell_iPhone *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell_iPhone" owner:self options:nil];
    }
    else
    {
        cell = (FindAContactCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell" owner:self options:nil];
    }


    ContactData *contact = [self.data objectAtIndex:indexPath.row];
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

    if (!isAddVisible)
    {
        cell.imgArrow.alpha = 1.0f;
        cell.btnAdd.alpha = 0;
    }


    if (!contact.isPreferred)
    {
        cell.imgStar.alpha = 0.0f;
        cell.lblBusinessName.frame = CGRectMake(10, 14, 256, 21);
    }

    return cell;





}

- (void)addContact:(ContactData *)contact
{
    NSLog(@"add contact find contact");
    [self.delegate addContact:contact];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text = NSLocalizedString(@"", nil);
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchLocation = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self sendRequest];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
}

- (void) onContactSelected:(NSNotification *)note
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) onLocationTapped:(id)sender
{
    [self getUsersPosition];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) locationUpdate:(CLLocation *)location
{
}

- (void) locationError:(NSString *)text
{
    NSLog(@"%@", [text description]);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        MapViewController* mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        ContactData* contact = [data objectAtIndex:[indexPath row]];
        mapView.latCoord = [contact latCoordinate];
        mapView.longCoord = [contact longCoordinate];
        mapView.selectedContactName = [contact name];
        mapView.currentLocation = [clController getUsersCurrentPosition];
        mapView.arrContactData = data;
        [self.navigationController pushViewController:mapView animated:YES];
    }
    else
    {
        ContactData *contact = [data objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:kAddNewContact object:contact];
    }
}

@end
