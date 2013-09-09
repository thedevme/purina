//
//  AddVetViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/30/12.
//
//

#define TXT_ADD "Add a "
#define TXT_TITLE_VET "Veterinarian"
#define TXT_TITLE_GROOMER "Groomer"
#define TXT_TITLE_KENNEL "Kennel"


#define TXT_TYPE "Type in "

#define TXT_VET "your veterinarian's "
#define TXT_GROOMER "your groomer's "
#define TXT_KENNEL "your kennel's "

#define TXT_INFO "information or "
#define TXT_FIND "find one "
#define TXT_NEARBY "nearby"



#import "AddContactViewController_iPhone5.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Constants.h"
#import "OHASBasicHTMLParser.h"
#import "OHASBasicMarkupParser.h"

@interface AddContactViewController_iPhone5 ()
 
@end

@implementation AddContactViewController_iPhone5

@synthesize txtAddress;
@synthesize txtPhone;
@synthesize txtName;
@synthesize txtCity;
@synthesize txtState;
@synthesize txtZip;

@synthesize lblDescription;
@synthesize lblTitleName;
@synthesize lblTitlePhone;
@synthesize lblTitleAddress;
@synthesize lblTitleZip;
@synthesize lblTitleCity;
@synthesize lblTitleState;
@synthesize findContactView;
//@synthesize op;

@synthesize type;
@synthesize imgTitle;

@synthesize scrollView;
@synthesize dataStack = _dataStack;
@synthesize objContactData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)contactType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Back";
        self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        
        type = contactType;
        
        if ([type isEqualToString:kVeterinarian])
        {
            self.navigationItem.title = @"Add A Veterinarian";
        }
        else if ([type isEqualToString:kKennel])
        {
            self.navigationItem.title = @"Add A Kennel";
        }
        else if ([type isEqualToString:kGroomer])
        {
            self.navigationItem.title = @"Add A Groomer";
        }
    }
    return self;
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSaveItem];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObservers];
    [self createModel];
    [self createNavigationButtons];
    [self setLabel];
    [self getVetData];
    [self setPlaceholders];

    if ([type isEqualToString:kVeterinarian])
    {
        [self createDesc:@TXT_VET];
        [self createTitle:@TXT_TITLE_VET];
    }
    else if ([type isEqualToString:kKennel])
    {
        [self createDesc:@TXT_KENNEL];
        [self createTitle:@TXT_TITLE_KENNEL];
    }
    else if ([type isEqualToString:kGroomer])
    {
        [self createDesc:@TXT_GROOMER];
        [self createTitle:@TXT_TITLE_GROOMER];
    }
    
    [self addSaveBtn];
}


- (void)setPlaceholders
{
    self.txtName.placeholder = @"Enter Name";
    self.txtPhone.placeholder = @"(000) 000-0000";
    self.txtAddress.placeholder = @"Enter Full Address";
    self.txtCity.placeholder = @"Enter City";
    self.txtState.placeholder = @"Enter State";
    self.txtZip.placeholder = @"Enter Zip";
}

- (void) addSaveBtn
{
    type = [type stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[type substringToIndex:1] uppercaseString]];
    NSString* btnLabel = [NSString stringWithFormat:@"Find a %@ Near You", type];
    PurinaItemButton* btnFind = [[PurinaItemButton alloc] init:btnLabel];
    [btnFind addTarget:self action:@selector(onFindTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnFind.frame = CGRectMake(7, 425, 307, 51);
    [self.view addSubview:btnFind];
}

- (void) createTitle:(NSString *)strTitle
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@%@", @ TXT_ADD, strTitle];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:32]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:strTitle]];
    _lblTitle.attributedText = attrStr;
}

- (void) createDesc:(NSString *)descType
{
    NSString* strDesc = [NSString stringWithFormat:@"%@%@%@", @ TXT_TYPE, descType, @ TXT_INFO TXT_FIND TXT_NEARBY];
    NSString* txt = strDesc;
    
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:16]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:descType]];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@TXT_FIND]];
    _lblDesc.attributedText = attrStr;
}


- (void) addObservers
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVetSelected:) name:@"addNewVet" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onVetSelected:) name:@"addToPet" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddContactTapped:) name:kAddNewContact object:nil];
    //
}

- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setLblDescription:nil];
    [self setLblTitleName:nil];
    [self setLblTitlePhone:nil];
    [self setLblTitleAddress:nil];
    [self setLblTitleCity:nil];
    [self setLblTitleState:nil];
    [self setLblTitleZip:nil];
    [self setTxtAddress:nil];
    [self setTxtPhone:nil];
    [self setTxtName:nil];
    [self setTxtCity:nil];
    [self setTxtZip:nil];
    [self setTxtState:nil];
    [self setImgTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) getVetData
{
    NSLog(@"%@", [Contact getContactData:kVeterinarian]);
    if ([type isEqualToString:kVeterinarian])
    {
        imgTitle.frame = CGRectMake(35, 7, 250, 30);
        imgTitle.image = [UIImage imageNamed:@"titleAddAVet.png"];
    }
    else if ([type isEqualToString:kKennel])
    {
        imgTitle.frame = CGRectMake(35, 7, 185, 32);
        imgTitle.image = [UIImage imageNamed:@"titleAddAKennel.png"];
    }
    else if ([type isEqualToString:kGroomer])
    {
        imgTitle.frame = CGRectMake(35, 7, 210, 32);
        imgTitle.image = [UIImage imageNamed:@"titleAddAGroomer.png"];
    }
}

- (void) setLabel
{
    NSString* desc = [NSString stringWithFormat:@"Type in your %@'s information or find one nearby", type];
    [lblDescription setText:desc];
    [self setFonts];
    [self adjustLabel];
}

- (void)adjustLabel
{
    // MOCKUP
    CGSize maxSize;
    UIFont *originalFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.f];
    [lblDescription setFont:originalFont];
    
    maxSize = CGSizeZero;
    [lblDescription setTextColor:[UIColor blackColor]];
    [lblDescription adjustLabel];
}

- (void) setFonts
{
    lblTitleName.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    lblTitlePhone.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    lblTitleAddress.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    lblTitleZip.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    lblTitleCity.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    lblTitleState.font = [UIFont fontWithName:kHelveticaNeueBold size:13.0f];
    
    lblTitleName.textColor = [UIColor purinaDarkGrey];
    lblTitlePhone.textColor = [UIColor purinaDarkGrey];
    lblTitleAddress.textColor = [UIColor purinaDarkGrey];
    lblTitleZip.textColor = [UIColor purinaDarkGrey];
    lblTitleCity.textColor = [UIColor purinaDarkGrey];
    lblTitleName.textColor = [UIColor purinaDarkGrey];
    lblTitleState.textColor = [UIColor purinaDarkGrey];
    
    txtAddress.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    txtPhone.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    txtName.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    txtCity.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    txtState.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    txtZip.font = [UIFont fontWithName:kHelveticaNeue size:11.0f];
    
    txtAddress.textColor = [UIColor purinaLightGrey];
    txtPhone.textColor = [UIColor purinaLightGrey];
    txtName.textColor = [UIColor purinaLightGrey];
    txtCity.textColor = [UIColor purinaLightGrey];
    txtState.textColor = [UIColor purinaLightGrey];
    txtZip.textColor = [UIColor purinaLightGrey];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtName)
    {
        [txtPhone becomeFirstResponder];
    }
    else if (textField == txtPhone)
    {
        [txtAddress becomeFirstResponder];
    }
    else if (textField == txtAddress)
    {
        [txtCity becomeFirstResponder];
    }
    else if (textField == txtCity)
    {
        [txtState becomeFirstResponder];
    }
    else if (textField == txtState)
    {
        [txtZip becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}

- (void) saveContact
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    if (objContactData.longCoordinate == 0.000000 && objContactData.latCoordinate == 0.000000)
    {
        objContactData = [[ContactData alloc] init];
        objContactData.name = txtName.text;
        objContactData.streetAddress = txtAddress.text;
        objContactData.city = txtCity.text;
        objContactData.state = txtState.text;
        objContactData.zipCode = [txtZip.text intValue];
        objContactData.phone = txtPhone.text;
        objContactData.type = [type lowercaseString];
        
        NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %i", objContactData.streetAddress, objContactData.city, objContactData.state, objContactData.zipCode];
        address = [address stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString* theAddress = [NSString stringWithFormat:@"%@&output=json", address];
        
        NSString *urlString;
        NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        
        if ( 6 == [[versionCompatibility objectAtIndex:0] intValue] )
        {
            urlString = [NSString stringWithFormat:@"http://maps.apple.com/maps/geo?q=%@", theAddress];
        }
        else
        {
            urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@", theAddress];
        }
        
        
        
        NSURL* url = [NSURL URLWithString:urlString];
        NSURLRequest* req = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation* op;
        
        op = [AFJSONRequestOperation JSONRequestOperationWithRequest:req
                                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                 [self setLocationPoints:JSON];
                                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                         NSError *error, id JSON) {
                                                                 NSLog(@"error %@", [error description]);
                                                             }];
        
        [op start];
        
    }
    else
    {
        NSLog(@"save contact strData %@", objContactData);
        objContactData.name = txtName.text;
        objContactData.streetAddress = txtAddress.text;
        objContactData.city = txtCity.text;
        objContactData.state = txtState.text;
        objContactData.zipCode = [txtZip.text intValue];
        objContactData.phone = txtPhone.text;
        objContactData.type = [type lowercaseString];


        if (self.isEditable) [[NSNotificationCenter defaultCenter] postNotificationName:kEditPrimaryContact object:objContactData];
        else [[NSNotificationCenter defaultCenter] postNotificationName:kSaveNewContact object:objContactData];


        [self.delegate addContactData:objContactData];
    }
}

- (void) setLocationPoints:(NSDictionary *)data
{
    NSArray* arrCoordinates = [[[[data valueForKey:@"Placemark"] valueForKey:@"Point"] valueForKey:@"coordinates"] objectAtIndex:0];
    objContactData.longCoordinate = [[arrCoordinates objectAtIndex:0] floatValue];
    objContactData.latCoordinate = [[arrCoordinates objectAtIndex:1] floatValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSaveNewContact object:objContactData];
}

- (void) onAddContactTapped:(NSNotification *)note
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([[note object] class] == [ContactData class])
    {
        objContactData = [note object];
        txtName.text = objContactData.name;
        txtAddress.text = objContactData.streetAddress;
        txtCity.text = [objContactData city];
        txtState.text = [objContactData state];
        txtZip.text = [NSString stringWithFormat:@"%i", [objContactData zipCode]];
        txtPhone.text = objContactData.phone;
    }
}

- (void) updateContactForm:(ContactData *)data
{
    objContactData = data;
    txtName.text = objContactData.name;
    txtAddress.text = objContactData.streetAddress;
    txtCity.text = [objContactData city];
    txtState.text = [objContactData state];
    txtZip.text = [NSString stringWithFormat:@"%i", [objContactData zipCode]];
    txtPhone.text = objContactData.phone;
}

- (void) onSaveTapped:(id)sender
{
    if (![txtName.text isEqualToString:@""])
    {
        [self setPlaceholders];
        [self saveContact];
    }
}

- (void) onCancelTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onFindTapped:(id)sender
{
    findContactView = [[FindContactViewController alloc] initWithNibName:@"FindContactViewController" bundle:nil withType:type showAdd:YES];
    findContactView.delegate = self;
    findContactView.strType = [type lowercaseString];
    [self.navigationController pushViewController:findContactView animated:YES];
}

- (void)addContact:(ContactData *)contact
{
    NSLog(@"%@", contact);
    [self updateContactForm:contact];
}

@end
