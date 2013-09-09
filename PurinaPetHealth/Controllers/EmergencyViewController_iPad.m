//
//  EmergencyViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//


#define SPAN_VALUE 0.04f

#import <CoreLocation/CoreLocation.h>
#import "EmergencyViewController_iPad.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "YPRequest.h"
#import "SVProgressHUD.h"
#import "MapViewController.h"
#import "OHASBasicMarkupParser.h"
#import "Contact.h"
#import "ContactListViewController.h"
#import "EmergencyVet.h"
#import "EmergencyVetModel.h"
#import "EditContactViewController_iPad.h"

@interface EmergencyViewController_iPad ()

@end

@implementation EmergencyViewController_iPad


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = @"Emergency";
        self.navigationItem.title = @"Emergency";
        self.tabBarItem.image = [UIImage imageNamed:@"iconEmergency.png"];
        [self.navigationController setNavigationBarHidden:YES];
        self.strType = kVeterinarian;
        self.isAddVisible = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view from its nib.
}

- (void)initialize
{
    [self setSearchBar];
    [self setLabels];
    [self createCoreLocation];
    [self setDefaults];
    
    NSLog(@"%f %f", self.longCoord, self.latCoord);
    self.strType = kVeterinarian;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self getUsersPosition];
    [self addObservers];
    [self createModel];
    [self checkForEmergencyVet];
}

- (void)addContact:(ContactData *)contact
{
    
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_SAVEEMERGENCYVET"];
    
    self.contactData = contact;
    NSLog(@"add contact %@", self.contactData);

    self.lblMessage.alpha = 0.0f;
    [self displayLabels:1.0f];
    [self saveContactData];
    [self setEmergencyContactLabels];
}

- (void)checkForEmergencyVet
{
    ContactData* emergencyVet = [self.emergencyModel getEmergencyVet];


    if (emergencyVet.name == nil)
    {
        [self createMessage:@"You currently have no Emergency Veterinarian set! Tap here to add one."];
        [self displayLabels:0.0f];
        [self displayIcons:0.0f];
        NSLog(@"check for vet none set");
    }
    else
    {
        self.contactData = emergencyVet;


        [self setEmergencyContactLabels];

        NSLog(@"contact data: %@", self.contactData);
//        self.objEmergencyVet.name = emergencyVet.name;
//        self.objEmergencyVet.streetAddress = emergencyVet.streetAddress;
//        self.objEmergencyVet.zipCode = [NSString stringWithFormat:@"%i", emergencyVet.zipCode];
//        self.objEmergencyVet.type = kVeterinarian;
//        self.objEmergencyVet.phone = emergencyVet.phone;
//        self.objEmergencyVet.state = emergencyVet.state;
//        self.objEmergencyVet.city = emergencyVet.city;
//        self.objEmergencyVet.guid = emergencyVet.guid;
//        self.objEmergencyVet.longitude = [NSNumber numberWithFloat:emergencyVet.longCoordinate];
//        self.objEmergencyVet.latitude = [NSNumber numberWithFloat:emergencyVet.latCoordinate];
    }
    
    
    
}

- (void)setEmergencyContactLabels
{
    self.lblName.text = self.contactData.name;
    self.lblAddress.text = self.contactData.streetAddress;
    self.lblCity.text = [NSString stringWithFormat:@"%@, %@, %i", self.contactData.city, self.contactData.state, self.contactData.zipCode];
    self.lblPhone.text = self.contactData.phone;
}

- (void)displayIcons:(float)value
{
    self.btnEmail.alpha = value;
    self.btnMap.alpha = value;
}

- (void)displayLabels:(float)value
{
    self.lblTitleEmergency.alpha = value;
    self.lblName.alpha = value;
    self.lblAddress.alpha = value;
    self.lblCity.alpha = value;
    self.lblPhone.alpha = value;
}

- (void)setLabels
{
    self.lblTitleSearch.font = [UIFont fontWithName:kHelveticaNeueBold size:12.0f];
    self.lblTitleSearch.textColor = [UIColor purinaDarkGrey];
    
    self.lblTitleEmergency.font = [UIFont fontWithName:kHelveticaNeueCondBold size:25.0f];
    self.lblTitleEmergency.textColor = [UIColor purinaRed];
    
    self.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:18.0f];
    self.lblName.textColor = [UIColor purinaDarkGrey];
    
    self.lblAddress.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.lblAddress.textColor = [UIColor purinaDarkGrey];
    
    self.lblCity.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.lblCity.textColor = [UIColor purinaDarkGrey];
    
    self.lblPhone.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.lblPhone.textColor = [UIColor purinaDarkGrey];
}

- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:22]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"Emergency Veterinarian"]];
    
    self.lblMessage.attributedText = attrStr;
}

- (void)setSearchBar
{
    [[[self.searchBar subviews] objectAtIndex:0] setHidden:YES];
    
    
    for (id img in self.searchBar.subviews)
    {
        if ([img isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [img removeFromSuperview];
        }
    }
}


- (void) createCoreLocation
{
    self.clController = [[CoreLocationController alloc] init];
    self.clController.delegate = self;
    [self.clController.locationManager startUpdatingLocation];
}


- (void)saveContactData
{
    NSLog(@"on save contact notification");
    [self.emergencyModel saveEmergencyVet:self.contactData];
}

- (void)fetchData
{
    AFJSONRequestOperation* op;
    
    //NSLog(@"fetch strData: %@", self.strType);
    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:[YPRequest getYellowPagesData:self.searchLocation withSearhType:self.strType]
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
        contact.phone = [dictionary objectForKey:@"Phone"];
        
        NSString *strPreferred = [dictionary objectForKey:@"PreferredVendor"];
        if ([strPreferred isEqualToString:@"False"]) contact.isPreferred = NO;
        if ([strPreferred isEqualToString:@"True"]) contact.isPreferred = YES;
        
        contact.distance = [NSNumber numberWithFloat:[[dictionary objectForKey:@"Miles"] floatValue]];
        contact.type = self.strType;
        contact.longCoordinate = [[dictionary objectForKey:@"Longitude"] floatValue];
        contact.latCoordinate = [[dictionary objectForKey:@"Latitude"] floatValue];
        contact.zipCode = [[dictionary objectForKey:@"ZipCode"] intValue];
        [arrContacts addObject:contact];
        
        
    }


    self.data = arrContacts;
    
    NSLog(@"There are %i total contacts", [self.data count]);
    NSLog(@"%@", self.data);
    
    [self.tableView reloadData];
    
    //[self getUsersPosition];
    [self setMapRegion];
}

- (void) getUsersPosition
{
    CLLocationCoordinate2D location = [self.clController getUsersCurrentPosition];
    NSLog(@"%f %f", location.latitude, location.longitude);
    self.searchLocation = [NSString stringWithFormat:@"%f%@%f", location.latitude, @":", location.longitude];
    NSLog(@"%f %f", location.latitude, location.longitude);
    
    
    
    if (location.latitude != 0 && location.longitude != 0)
    {
        [SVProgressHUD showWithStatus:@"Loading ..."];
        [self sendRequest];
    }
}

- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.emergencyModel = [[EmergencyVetModel alloc] init];
}

- (void) setDefaults
{
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,0,0)];
    self.contactData = [[ContactData alloc] init];
}


- (void) setMapRegion
{
    ContactData* contact = [self.data objectAtIndex:0];
    
    self.latCoord = contact.latCoordinate;
    self.longCoord = contact.longCoordinate;
    
    MKCoordinateRegion region;
    region.center.latitude = self.latCoord;
    region.center.longitude = self.longCoord;
    region.span.latitudeDelta = SPAN_VALUE;
    region.span.longitudeDelta = SPAN_VALUE;
    
    //NSLog(@"%f %f", self.longCoord, self.latCoord);
    [self.mapView setRegion:region animated:NO];
    [self createAnnotations];
}

- (void) createAnnotations
{
    self.arrAnnotations = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.data count]; i++)
    {
        //NSLog(@"create ann");
        CLLocationCoordinate2D location;
        location.latitude = [[self.data objectAtIndex:i] latCoordinate];
        location.longitude = [[self.data objectAtIndex:i] longCoordinate];
        ContactAnnotation* annotation = [[ContactAnnotation alloc] init];
        [annotation setCoordinate:location];
        annotation.title = [[self.data objectAtIndex:i] name];
        annotation.subtitle = [[self.data objectAtIndex:i] streetAddress];
        annotation.phone = [[self.data objectAtIndex:i] phone];
        
        if (self.latCoord == location.latitude && self.longCoord == location.longitude &&  [self.selectedContactName isEqualToString:[[self.data objectAtIndex:i] name]])
        {
            self.annotationToSelect = annotation;
        }
        
        [self.arrAnnotations addObject:annotation];
    }
    
    //NSLog(@"%@", self.arrAnnotations);
    
    [self.mapView addAnnotations:self.arrAnnotations];
    
    [self setSelectAnnotation];
}

- (void) setSelectAnnotation
{
    for (id<MKAnnotation> currentAnnotation in self.mapView.annotations)
    {
        if ([currentAnnotation isEqual:self.annotationToSelect])
        {
            [self.mapView selectAnnotation:currentAnnotation animated:FALSE];
        }
    }
}


- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    
    NSLog(@"map view did finish loading");
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView)
    {
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        UIButton *btnDirections = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIButton *btnCall = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnDirections setBackgroundImage:[UIImage imageNamed:@"btnAnnDirections.png"] forState:UIControlStateNormal];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            [btnCall setBackgroundImage:[UIImage imageNamed:@"btnAnnCall.png"] forState:UIControlStateNormal];
            customPinView.leftCalloutAccessoryView = btnCall;
            customPinView.leftCalloutAccessoryView.tag = 1;
        }
        customPinView.rightCalloutAccessoryView = btnDirections;
        customPinView.rightCalloutAccessoryView.tag = 2;
        customPinView.enabled = YES;
        
        return customPinView;
    }
    
    else
    {
        pinView.annotation = annotation;
        return pinView;
    }
}


- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    ContactAnnotation* annotation = (ContactAnnotation *)[view annotation];
    if ([control tag] == 1)
    {
        NSString *phoneStripped = [[annotation phone]
                                   stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString* phoneNo = [NSString stringWithFormat:@"tel:%@", phoneStripped];
        //NSLog(@"%@", phoneNo);
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneNo];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    
    if ([control tag] == 2)
    {
        NSString* address = [annotation subtitle];
        NSString *url;
        NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        
        if ( 6 == [[versionCompatibility objectAtIndex:0] intValue] )
        {
            url = [NSString stringWithFormat: @"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@",
                   self.currentLocation.latitude, self.currentLocation.longitude,
                   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
                   self.currentLocation.latitude, self.currentLocation.longitude,
                   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
}

- (void) addNavButton
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

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onContactSaved:) name:kSaveNewContact object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddNewContact:) name:kAddNewContact object:nil];
}

- (void)sendRequest
{
    if (![self.searchLocation isEqualToString:@""])
    {
        [self fetchData];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setSearchBar:nil];
    [self setMapView:nil];
    [self setLblMessage:nil];
    [self setBtnMap:nil];
    [self setBtnEmail:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view strData source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    FindAContactCell *cell = (FindAContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell" owner:self options:nil];
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

    if (!contact.isPreferred)
    {
        cell.imgStar.alpha = 0.0f;
        cell.lblBusinessName.frame = CGRectMake(10, 14, 256, 21);
    }
    
    NSLog(@"name %@", contact.name);
    
    return cell;
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
    self.searchLocation = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self sendRequest];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
}

- (void)onContactSaved:(NSNotification *)note
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.contactData = [note object];
    //NSLog(@"%@", self.contactData);
    
    
    self.lblName.text = [self.contactData name];
    self.lblAddress.text = [self.contactData streetAddress];
    NSString *strCityState = [NSString stringWithFormat:@"%@, %@, %i", [self.contactData city], [self.contactData state], [self.contactData zipCode]];
    self.lblCity.text = strCityState;
    self.lblPhone.text = [self.contactData phone];
    self.lblMessage.alpha = 0.0f;
    [self displayLabels:1.0f];
    [self displayIcons:1.0f];

    [self saveContactData];
}

- (void)onAddNewContact:(NSNotification *)note
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.contactData = [note object];

    self.lblName.text = [self.contactData name];
    self.lblAddress.text = [self.contactData streetAddress];
    NSString *strCityState = [NSString stringWithFormat:@"%@, %@, %i", [self.contactData city], [self.contactData state], [self.contactData zipCode]];
    self.lblCity.text = strCityState;
    self.lblPhone.text = [self.contactData phone];
    self.lblMessage.alpha = 0.0f;
    [self displayLabels:1.0f];
    [self displayIcons:1.0f];

    [self saveContactData];
}

- (void)saveContact:(ContactData *)contact
{
    if (contact.name.length > 0)
    {
        self.contactData = contact;
        //NSLog(@"%@", self.contactData);


        self.lblName.text = [self.contactData name];
        self.lblAddress.text = [self.contactData streetAddress];
        NSString *strCityState = [NSString stringWithFormat:@"%@, %@, %i", [self.contactData city], [self.contactData state], [self.contactData zipCode]];
        self.lblCity.text = strCityState;
        self.lblPhone.text = [self.contactData phone];
        self.lblMessage.alpha = 0.0f;
        [self displayLabels:1.0f];
        [self displayIcons:1.0f];

        [self saveContactData];
    }
    else
    {
        NSLog(@"there was no contact data");
    }
}

//


- (void) onLocationTapped:(id)sender
{
    [self getUsersPosition];
}

- (void) locationUpdate:(CLLocation *)location
{
}

- (void) locationError:(NSString *)text
{
    NSLog(@"%@", [text description]);
}

- (void) presentModal:(NSString *)type andRect:(CGRect)rect
{
    NSLog(@"present modal");



    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPhoneTapped:(id)sender
{
    
}

- (IBAction)onEmailTapped:(id)sender
{
    
}

- (IBAction)onMapTapped:(id)sender
{
    
}

- (IBAction)onCardTapped:(id)sender
{
    //
    if (self.contactData.name.length == 0)
    {

        EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
                initWithNibName:@"EditContactViewController_iPad"
                         bundle:nil
                       withType:kVeterinarian];
        editContact.delegate = self;
        editContact.isEmergencyContact = YES;

        UINavigationController *navController = [[UINavigationController alloc]
                initWithRootViewController:editContact];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navController.modalPresentationStyle = UIModalPresentationFormSheet;

        [self presentModalViewController:navController animated:YES];
    }
    else
    {
        EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
                initWithNibName:@"EditContactViewController_iPad" bundle:nil andContactData:self.contactData];
        editContact.delegate = self;
        editContact.type = kVeterinarian;
        editContact.isEmergencyContact = YES;

        UINavigationController *navController = [[UINavigationController alloc]
                initWithRootViewController:editContact];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navController.modalPresentationStyle = UIModalPresentationFormSheet;

        [self presentModalViewController:navController animated:YES];
    }


}


@end
