//
//  EditContactViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/11/12.
//
//

#import "EditContactViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface EditContactViewController ()

@end

@implementation EditContactViewController

@synthesize objContact;
@synthesize txtAddress;
@synthesize txtPhone;
@synthesize txtName;
@synthesize txtWebsite;
@synthesize txtCity;
@synthesize txtEmail;
@synthesize txtZip;
@synthesize lblDescription;
@synthesize lblTitleName;
@synthesize lblTitlePhone;
@synthesize lblTitleCity;
@synthesize lblTitleZip;
@synthesize lblTitleAddress;
@synthesize lblTitleWebsite;
@synthesize lblTitleEmail;
@synthesize scrollView;
@synthesize dataStack = _dataStack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contactData:(Contact *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        objContact = data;
        
        self.title = [objContact name];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //objContact = strData;

        //self.title = [objContact name];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createModel];
    [self setData];
    [self createNavigationButtons];
    [self setLabel];
    // Do any additional setup after loading the view from its nib.
}

- (void) setData
{
    NSString* address = [NSString stringWithFormat:@"%@, %@", [objContact city], [objContact state]];
    txtName.text = objContact.name;
    txtAddress.text = objContact.streetAddress;
    txtCity.text = address;
    txtZip.text = [NSString stringWithFormat:@"%@", [objContact zipCode]];
    txtPhone.text = objContact.phone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
}

- (void) setLabel
{
    [lblDescription setText:NSLocalizedString(@"Type in your veternarian's information or find one nearby", nil)];
    [self setFonts];
    [self adjustLabel];
}

- (void) createNavigationButtons
{
    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonSystemItemDone target:self action:@selector(onSaveTapped:)];
    btnDoneItem.tintColor = [UIColor colorWithRed:145.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = btnDoneItem;
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
    lblTitleName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitlePhone.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitleAddress.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitleEmail.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitleWebsite.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitleCity.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    lblTitleZip.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
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
        [txtWebsite becomeFirstResponder];
    }
    else if (textField == txtWebsite)
    {
        [txtEmail becomeFirstResponder];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
