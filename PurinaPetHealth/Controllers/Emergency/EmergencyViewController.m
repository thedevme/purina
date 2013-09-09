//
//  EmergencyViewController.m
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmergencyViewController.h"
#import "EmergencyVetModel.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"
#import "OHAttributedLabel.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Emergency";
        self.navigationItem.title = @"Emergency";
        self.tabBarItem.image = [UIImage imageNamed:@"tabIcon_medical.png"];
        _strType = @"emergency+veterinarian";
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialize];
}

- (void)initialize
{
    [self setSearchBar];
    [self setLabels];
    [self createCoreLocation];
    [self setDefaults];

    [self getUsersPosition];
    //[self addObservers];
    [self createModel];
    [self checkForEmergencyVet];
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


- (void)setLabels
{
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

    self.lblTitleNearby.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleNearby.textColor = [UIColor purinaDarkGrey];
}

- (void) setDefaults
{
    self.searchBar.delegate = self;
    self.contactData = [[ContactData alloc] init];
}

- (void) createModel
{
     self.emergencyModel = [[EmergencyVetModel alloc] init];
}


- (void) createCoreLocation
{
    _clController = [[CoreLocationController alloc] init];
    _clController.delegate = self;
    [_clController.locationManager startUpdatingLocation];
}

- (void) fetchVetData
{
    AFJSONRequestOperation* op;
    
    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:[YPRequest getYellowPagesData:_searchLocation withSearhType:_strType]
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
}

- (void)checkForEmergencyVet
{
    ContactData* emergencyVet = [self.emergencyModel getEmergencyVet];


    if (emergencyVet.name == nil)
    {
        [self createMessage:@"You currently have no Emergency Veterinarian set! Tap here to add one."];
        [self displayLabels:0.0f];
        [self displayIcons:0.0f];
        self.btnArrow.alpha = 0.0f;
        NSLog(@"check for vet none set");
    }
    else
    {
        self.contactData = emergencyVet;
        [self setEmergencyContactLabels];
        //self.btnArrow.alpha = 1.0f;
        [self displayIcons:1.0f];
        NSLog(@"contact data: %@", self.contactData);
    }
}

- (void)displayIcons:(float)value
{
    self.btnEmail.alpha = value;
    self.btnMap.alpha = value;
    self.btnPhone.alpha = value;
}

- (void)displayLabels:(float)value
{
    self.lblTitleEmergency.alpha = value;
    self.lblName.alpha = value;
    self.lblAddress.alpha = value;
    self.lblCity.alpha = value;
    self.lblPhone.alpha = value;
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

- (void)addContact:(ContactData *)contact
{
    self.contactData = contact;
    NSLog(@"add contact %@", self.contactData);

    self.lblMessage.alpha = 0.0f;
    [self displayLabels:1.0f];
    [self saveContact];
    [self setEmergencyContactLabels];
}


- (void)saveContact
{
    NSLog(@"on save contact notification");
    [self.emergencyModel saveEmergencyVet:self.contactData];
}


- (void)setEmergencyContactLabels
{
    self.lblName.text = self.contactData.name;
    self.lblAddress.text = self.contactData.streetAddress;
    self.lblCity.text = [NSString stringWithFormat:@"%@, %@, %i", self.contactData.city, self.contactData.state, self.contactData.zipCode];
    self.lblPhone.text = self.contactData.phone;
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

- (void)sendRequest
{
    if (![_searchLocation isEqualToString:@""])
    {
        [self fetchVetData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    FindAContactCell_iPhone *cell = (FindAContactCell_iPhone *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"FindAContactCell_iPhone" owner:self options:nil];
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

- (void) locationUpdate:(CLLocation *)location
{
}

- (void) locationError:(NSString *)text
{
    NSLog(@"%@", [text description]);
}

- (void)viewDidUnload
{
    [self setLblTitleEmergency:nil];
    [self setLblName:nil];
    [self setLblAddress:nil];
    [self setLblCity:nil];
    [self setLblPhone:nil];
    [self setBtnEmail:nil];
    [self setBtnMap:nil];
    [self setBtnPhone:nil];
    [self setSearchBar:nil];
    [self setBtnArrow:nil];
    [self setLblTitleNearby:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onPhoneTapped:(id)sender
{
    NSString *phoneStripped = [[self.contactData phone]
            stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phoneNo = [NSString stringWithFormat:@"tel:%@", phoneStripped];
    NSLog(@"%@", phoneNo);
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneNo];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (IBAction)onEmailTapped:(id)sender
{
    if ([self.contactData email] != nil || [[self.contactData email] isEqualToString:@""])
    {
        //NSLog(@"send email");
    }
    else
    {
        NSString* subject = @"";
        NSString* body = @"";
        NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                                                          [[self.contactData name] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                                          [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                                          [body  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
    }
}

- (IBAction)onMapTapped:(id)sender
{
    CLLocationCoordinate2D location = [_clController getUsersCurrentPosition];
    NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %d", [self.contactData streetAddress], [self.contactData city], [self.contactData state], [self.contactData zipCode]];

    NSString *url;
    NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ( 6 == [[versionCompatibility objectAtIndex:0] intValue] )
    {
        url = [NSString stringWithFormat: @"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@",
               location.latitude, location.longitude,
               [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
               location.latitude, location.longitude,
               [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    //NSLog(@"%@, %f %f", address, location.longitude, location.latitude);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
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


@end
