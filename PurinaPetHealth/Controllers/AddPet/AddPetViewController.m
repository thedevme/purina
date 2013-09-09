//
//  AddPetViewController.m
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddPetViewController.h"
#import "Constants.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "PetModel.h"
//#import "Flurry.h"
//#import "FlurryTags.h"

@interface AddPetViewController ()

@end

@implementation AddPetViewController

@synthesize strGender;
@synthesize strSpecies;
@synthesize dataStack = _dataStack;
@synthesize btnBirthday;
@synthesize btnVet;
@synthesize btnGroomer;
@synthesize txtDogName;
@synthesize txtTitleName;
@synthesize txtTitleBirthday;
@synthesize txtTitleVet;
@synthesize txtTitleGroomer;
@synthesize txtTitleBreed;
@synthesize txtBreed;
@synthesize chkMale;
@synthesize chkFemale;
@synthesize chkDog;
@synthesize objBirthdayData;
@synthesize chkCat;
@synthesize objContactData;
@synthesize strName;
@synthesize btnIcon;
@synthesize imageData;
@synthesize objPrimaryVetData;
@synthesize objPrimaryGroomerData;
@synthesize primaryVetID;
@synthesize objPet;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
    self.strName = @"";

    numGroomerCount = [[Contact getContactData:kGroomer] count];
    numVetCount = [[Contact getContactData:kVeterinarian] count];
    self.objContactData = [[ContactData alloc] init];

    self.objPetData = [[PetData alloc] init];
    self.objPrimaryGroomerData = [[ContactData alloc] init];
    self.objPrimaryVetData = [[ContactData alloc] init];
    self.petModel = [[PetModel alloc] init];
    //self.objPetData = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Pet class]) inManagedObjectContext:self.dataStack.managedObjectContext];
}

- (void) initializeEdit:(PetData *)data
{
    self.objPetData = data;
    [self getPetContacts];
    [self setPetData];
    self.isPetBeingUpdated = YES;
}

- (void) getPetContacts
{
    for (int j = 0; j < [self.objPetData.contacts count]; j++)
    {
        [self saveCurrentContacts:[self.objPetData.contacts objectAtIndex:j]];
    }
}

- (void)setPetData
{
    NSLog(@"name %@", self.objPetData.name);
    self.txtDogName.text = self.objPetData.name;
    self.txtBreed.text = self.objPetData.breed;


    if (![self.objPetData.birthday isEqualToString:@"NA"]) [self.btnBirthday setTitle:self.objPetData.birthday forState: UIControlStateNormal];

    if ([self.objPetData.gender isEqualToString:@"Female"])
    {
        self.chkFemale.alpha = 1.0f;
        self.chkMale.alpha = 0.0f;
        self.strGender = @"Female";
    }
    else
    {
        self.chkFemale.alpha = 0.0f;
        self.chkMale.alpha = 1.0f;
        self.strGender = @"Male";

    }

    if ([self.objPetData.species isEqualToString:@"Dog"])
    {
        self.chkDog.alpha = 1.0f;
        self.chkCat.alpha = 0.0f;
        self.strSpecies = @"Dog";
    }
    else
    {
        self.chkDog.alpha = 0.0f;
        self.chkCat.alpha = 1.0f;
        self.strSpecies = @"Cat";
    }

    if (self.objPetData.imageData != NULL)
    {
        self.avatar.image = [UIImage imageWithData:self.objPetData.imageData];
        self.imgIcon.alpha = 0.0f;
    }


}

- (void) saveCurrentContacts:(ContactData *)contact
{
    if ([contact.type isEqualToString:kVeterinarian])
    {
        self.objPrimaryVetData = contact;

        [self.btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnVet setTitle:self.objPrimaryVetData.name forState:UIControlStateNormal];
        [self.btnVet setTitle:self.objPrimaryVetData.name forState:UIControlStateHighlighted];

        self.objPrimaryVetData = objContactData;
        NSLog(@"vet %@", self.objPrimaryVetData.name);
    }
    if ([contact.type isEqualToString:kGroomer])
    {
        self.objPrimaryGroomerData = contact;

        [self.btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnGroomer setTitle:self.objPrimaryGroomerData.name forState:UIControlStateNormal];
        [self.btnGroomer setTitle:self.objPrimaryGroomerData.name forState:UIControlStateHighlighted];



        self.objPrimaryGroomerData = objContactData;
        NSLog(@"groomer %@", self.objPrimaryGroomerData.name);
    }
    if ([contact.type isEqualToString:kKennel])
    {
//        self.objPrimaryKennelData = contact;
//
//        [_btnKennel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btnKennel setTitle:self.objPrimaryKennelData.name forState:UIControlStateNormal];
//        [_btnKennel setTitle:self.objPrimaryKennelData.name forState:UIControlStateHighlighted];
    }
}

- (void) setButtons
{
    //float r = 153; float g = 153; float b = 153; float a = 255;

    [self.btnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

    self.btnBirthday.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.f];
    self.btnVet.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.f];
    self.btnGroomer.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.f];
}

- (void) setFonts
{
    self.txtTitleName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    self.txtTitleBirthday.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    self.txtTitleVet.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    self.txtTitleGroomer.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    self.txtTitleBreed.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];

    _lblDog.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:13.0f];
    _lblCat.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:13.0f];
    _lblFemale.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:13.0f];
    _lblMale.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:13.0f];
}



- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(birthdaySet:) name:@"birthdaySet" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSaveContact:) name:kSaveNewContact object:nil];
}

- (void) createNavigationButtons
{
    //UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            //resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

//    UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
//    [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.navigationItem setRightBarButtonItem:btnSaveItem];

//    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
//    [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.navigationItem setLeftBarButtonItem:btnCancelItem];


    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
        [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setRightBarButtonItem:btnSaveItem];

        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }
    else
    {
        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }
}

- (void) setSegmentedControls
{
    self.strGender = @"Male";
    self.strSpecies = @"Dog";
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addObservers];
    [self createModel];
    [self createNavigationButtons];
    [self setSegmentedControls];
    [self setButtons];
    [self setFonts];

    [self createAvatar];
}

- (void) createAvatar
{
    UITapGestureRecognizer *dtapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizer:)];
    dtapGestureRecognize.delegate = self;
    dtapGestureRecognize.numberOfTapsRequired = 1;
    [self.avatar addGestureRecognizer:dtapGestureRecognize];
    //iPhone 5 - 52/50
    UIImageView *backingViewForRoundedCorner = [[UIImageView alloc] initWithFrame:CGRectMake(20, 17, 101, 101)];
    backingViewForRoundedCorner.layer.cornerRadius = 8.0f;
    backingViewForRoundedCorner.clipsToBounds = YES;
    backingViewForRoundedCorner.backgroundColor = [UIColor redColor];

    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 105, 105)];
    self.avatar.backgroundColor = [UIColor whiteColor];
    [backingViewForRoundedCorner addSubview:self.avatar];

    self.imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultPetIcon@2x.png"]];
    _imgIcon.frame = CGRectMake(18, 15, 105, 105);

    _btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnUpdate.frame = CGRectMake(33, 105, 76, 26);
    [_btnUpdate setBackgroundImage:[UIImage imageNamed:@"updateBtn@2x.png"] forState:UIControlStateNormal];
    [_btnUpdate addTarget:self action:@selector(avatarClicked:) forControlEvents:UIControlEventTouchUpInside];

    //[scrollView addSubview:imgBorder];
    [self.view addSubview:backingViewForRoundedCorner];
    [self.view addSubview:_imgIcon];
    [self.view addSubview:_btnUpdate];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([self.avatar isKindOfClass:[UIButton class]]) {      //change it to your condition
        return NO;
    }
    return YES;
}


- (void) savePet
{
    self.objPetData.name = txtDogName.text;
    self.objPetData.gender = strGender;
    self.objPetData.species = strSpecies;
    self.objPetData.breed = txtBreed.text;
    if (![self.btnBirthday.titleLabel.text isEqualToString:@"Tap to add birthday"]) self.objPetData.birthday = self.btnBirthday.titleLabel.text;
    if (!self.isPetBeingUpdated) self.objPetData.guid = [UniqueID getUUID];

    NSLog(@"birthday %@ obj bday %@", self.btnBirthday.titleLabel.text, self.objPetData.birthday);

    NSLog(@"save pet %@", self.objPrimaryVetData.name);

    if (self.objPrimaryVetData.name.length != 0 )
    {
        self.objPetData.primaryVet = self.objPrimaryVetData.guid;
        [self.objPetData.contacts addObject:self.objPrimaryVetData];
        NSLog(@"update primary vet data %@", self.objPrimaryVetData.name);
    }
    if (self.objPrimaryGroomerData.name.length != 0 )
    {
        self.objPetData.primaryGroomer = self.objPrimaryGroomerData.guid;
        [self.objPetData.contacts addObject:self.objPrimaryGroomerData];
    }

    if (imageData != NULL)
    {
        self.objPetData.imageData = imageData;
        NSLog(@"save image data not nil");
    }

    PetData *convertedPet = nil;
    if (!self.isPetBeingUpdated) convertedPet = [self.petModel savePet:self.objPetData];
    else  convertedPet = [self.petModel updatePet:self.objPetData];

    NSLog(self.isPetBeingUpdated ? @"Yes pet is being updated" : @"No pet is not being updated");

    [self.delegate newPetAdded];
    [self checkTextFields];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePet" object:self.objPetData];

    imageData = NULL;
    _imgIcon.alpha = 1.0f;
    _avatar.image = nil;
}





- (void)viewDidUnload
{
    [self setBtnBirthday:nil];
    [self setTxtDogName:nil];
    [self setChkMale:nil];
    [self setChkFemale:nil];
    [self setChkDog:nil];
    [self setChkCat:nil];
    [self setBtnVet:nil];
    [self setBtnGroomer:nil];
    [self setTxtTitleName:nil];
    [self setTxtTitleBirthday:nil];
    [self setTxtTitleVet:nil];
    [self setTxtTitleGroomer:nil];
    [self setTxtTitleBreed:nil];
    [self setTxtBreed:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) checkTextFields
{
    [self.txtDogName resignFirstResponder];
    [self.txtBreed resignFirstResponder];
}


- (void) onCancelTapped:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
    //NSLog(@"cancel tapped");
}

- (IBAction)onSaveTapped:(id)sender
{
    //NSLog(@"%@", txtDogName.text);
    self.strName = self.txtDogName.text;

    if (![self.strName isEqualToString:@""]) [self savePet];
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Sorry" message:@"Please add your pet's name before saving!"];
        [alert setDestructiveButtonWithTitle:@"OK" block:nil];
        [alert show];
    }
}

- (IBAction)onAddMoreTapped:(id)sender {
}

- (IBAction)onGroomerTapped:(id)sender
{
    [self checkTextFields];
    [self performSelector:@selector(showGroomer) withObject:self afterDelay:0];
}

- (void) showGroomer
{
//    ContactListViewController* contactListViewController = [[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil withType:kGroomer andPet:objPet displayAdd:YES];
//    contactListViewController.delegate = self;
//    [self.navigationController pushViewController:contactListViewController animated:YES];

    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddContactViewController_iPhone5* addViewController = [[AddContactViewController_iPhone5 alloc] initWithNibName:@"AddContactViewController_iPhone5" bundle:nil withType:kGroomer];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
    else
    {
        AddContactViewController* addViewController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:kGroomer];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
}

- (IBAction)onVetTapped:(id)sender
{
    [self checkTextFields];
    [self performSelector:@selector(showVet) withObject:self afterDelay:0];
//    NSString *vetTag = [NSString stringWithFormat:@"%@%@", kAddPet, @"addvet"];
//    [Flurry logEvent:vetTag];
}

- (void) showVet
{
    //NSLog(@"%@", );

//    ContactListViewController* contactListViewController = [[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil withType:kVeterinarian andPet:objPet displayAdd:YES];
//    contactListViewController.delegate = self;
//    [self.navigationController pushViewController:contactListViewController animated:YES];

    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddContactViewController_iPhone5* addViewController = [[AddContactViewController_iPhone5 alloc] initWithNibName:@"AddContactViewController_iPhone5" bundle:nil withType:kVeterinarian];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
    else
    {
        AddContactViewController* addViewController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:kVeterinarian];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
    }
}

- (IBAction)onBirthdayTapped:(id)sender
{
    [self checkTextFields];
    [self performSelector:@selector(showBirthday) withObject:self afterDelay:0.25];
}

- (void) showBirthday
{
    DatePickerViewController* datePickerViewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
    datePickerViewController.pickerDate.date = self.objBirthdayData.birthdayDate;
    [self.navigationController pushViewController:datePickerViewController animated:YES];
}

- (void) getContacts
{
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Contact"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];


    if ([array count] != 0)
    {
        for (int i = 0; i < [array count]; i++)
        {
            Contact* objData = [array objectAtIndex:i];

            if ([objData.type isEqualToString:@"vet"]) numVetCount++;
            if ([objData.type isEqualToString:@"groomer"]) numGroomerCount++;
        }
    }
    else
    {
        numGroomerCount = 0;
        numVetCount = 0;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textfield
{
    if (textfield == txtDogName)
    {
        [self.txtBreed becomeFirstResponder];
    }
    else
    {
        [textfield resignFirstResponder];
    }
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.txtDogName resignFirstResponder];
    [self.txtBreed resignFirstResponder];
}



- (IBAction)onMaleTapped:(id)sender
{
    chkFemale.alpha = 0.0f;
    chkMale.alpha = 1.0f;
    strGender = @"Male";
}

- (IBAction)onFemaleTapped:(id)sender
{
    chkFemale.alpha = 1.0f;
    chkMale.alpha = 0.0f;
    strGender = @"Female";
}

- (IBAction)onDogTapped:(id)sender
{
    chkCat.alpha = 0.0f;
    chkDog.alpha = 1.0f;
    strSpecies = @"Dog";
}

- (IBAction)onCatTapped:(id)sender
{
    chkCat.alpha = 1.0f;
    chkDog.alpha = 0.0f;
    strSpecies = @"Cat";
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtDogName resignFirstResponder];
}

- (void) birthdaySet:(NSNotification *)note
{
    objBirthdayData = [note object];
    [btnBirthday setTitle:[objBirthdayData birthdayDisplayDate] forState:UIControlStateNormal];
    [btnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

-(UIImage *)makeRoundedImage:(UIImage *)image radius:(float)radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;

    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;

    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return roundedImage;
}

- (void) onSaveContact:(NSNotification *)note
{


    ContactData *objContact = [note object];

    if ([objContact.type isEqualToString:kVeterinarian])
    {
        [btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnVet setTitle:objContact.name forState:UIControlStateNormal];
        [btnVet setTitle:objContact.name forState:UIControlStateHighlighted];

        self.objPrimaryVetData = objContact;
        NSLog(@"save contact vet %@", self.objPrimaryVetData);
    }
    else if ([objContact.type isEqualToString:kGroomer])
    {
        [btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnGroomer setTitle:objContact.name forState:UIControlStateNormal];
        [btnGroomer setTitle:objContact.name forState:UIControlStateHighlighted];

        self.objPrimaryGroomerData = objContact;
    }



//    Contact* objContact;
//
//    if ([[[note object] class] isEqual:[Contact class]])
//    {
//        Contact* objData = [note object];
//
//        NSError* error = nil;
//        NSEntityDescription *entityDescription = [NSEntityDescription
//                entityForName:@"Contact"
//       inManagedObjectContext:self.dataStack.managedObjectContext];
//
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entityDescription];
//        NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
//        NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"name == %@", [objData name]];
//        NSArray *arrContacts = [array filteredArrayUsingPredicate:typePredicate];
//        Contact* objConData = [arrContacts lastObject];
//
//        [objConData addPetObject:objPetData];
//        [objPetData addContactObject:objConData];
//
//        //NSLog(@"contact type is %@", objConData.type);
//
//
//        if ([objConData.type isEqualToString:kVeterinarian])
//        {
//            [btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [btnVet setTitle:objConData.name forState:UIControlStateNormal];
//            [btnVet setTitle:objConData.name forState:UIControlStateHighlighted];
//        }
//        else if ([objConData.type isEqualToString:kGroomer])
//        {
//            [btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [btnGroomer setTitle:objConData.name forState:UIControlStateNormal];
//            [btnGroomer setTitle:objConData.name forState:UIControlStateHighlighted];
//        }
//    }
//    else
//    {
//        objContactData = [note object];
//
//        objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];
//        objContact.name = objContactData.name;
//        objContact.streetAddress = objContactData.streetAddress;
//        objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];
//        objContact.type = objContactData.type;
//        objContact.phone = objContactData.phone;
//        objContact.state = objContactData.state;
//        objContact.listingID = [NSNumber numberWithInt:objContactData.listingID];
//        objContact.city = objContactData.city;
//        objContact.guid = [UniqueID getUUID];
//        objContact.longitude = [NSNumber numberWithFloat:objContactData.longCoordinate];
//        objContact.latitude = [NSNumber numberWithFloat:objContactData.latCoordinate];
//        [objContact addPetObject:objPetData];
//        [objPetData addContactObject:objContact];
//        [self updatePetForm:objContact.type];
//
//        //NSLog(@"add new vet %@", [Contact checkContact:objContactData]);
//    }

}

- (void) updatePetForm:(NSString *)type
{
    if ([type isEqualToString:kVeterinarian])
    {
        [btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnVet setTitle:objContactData.name forState:UIControlStateNormal];
        [btnVet setTitle:objContactData.name forState:UIControlStateHighlighted];

        self.objPrimaryVetData = objContactData;
        NSLog(@"update pet form - vet %@", self.objPrimaryVetData.name);
    }
    else if ([type isEqualToString:kGroomer])
    {
        [btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnGroomer setTitle:objContactData.name forState:UIControlStateNormal];
        [btnGroomer setTitle:objContactData.name forState:UIControlStateHighlighted];

        self.objPrimaryGroomerData = objContactData;
        NSLog(@"update pet form - groomer %@", self.objPrimaryGroomerData.name);
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addContact:(ContactData *)contact
{


    ContactData *objContact = contact;

    if ([objContact.type isEqualToString:kVeterinarian])
    {
        [btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnVet setTitle:objContact.name forState:UIControlStateNormal];
        [btnVet setTitle:objContact.name forState:UIControlStateHighlighted];

        self.objPrimaryVetData = objContact;

        NSLog(@"add contact name %@ type %@", self.objPrimaryVetData.type, self.objPrimaryVetData.name);
    }
    else if ([objContact.type isEqualToString:kGroomer])
    {
        [btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnGroomer setTitle:objContact.name forState:UIControlStateNormal];
        [btnGroomer setTitle:objContact.name forState:UIControlStateHighlighted];

        self.objPrimaryGroomerData = objContact;
    }
}


-(IBAction)avatarClicked:(id)sender
{
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    //picker.useStandardDevicePicker = YES;
    [picker setAllowedServices:APPAllowFacebook|APPAllowTwitter];
    [picker setDelegate:self];
    [picker setDefaultAccessToken:@"869d426184818feea2cb0a8af609552bf866811a848f6c6d71821b1d302fb7c9"];
    [self presentViewController:picker animated:YES completion:^(void) {}];
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_avatar setImage:[info objectForKey:AvatarPickerImage]];
    [self dismissModalViewControllerAnimated:YES];
    UIImage* img = [info objectForKey:AvatarPickerImage];
    imageData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    _imgIcon.alpha = 0.0f;
    //NSLog(@"did finish %@", imageData);
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
