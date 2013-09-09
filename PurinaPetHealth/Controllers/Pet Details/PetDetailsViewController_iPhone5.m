//
//  PetDetailsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/30/12.
//
//

#import "PetDetailsViewController_iPhone5.h"
#import "Constants.h"
#import "MedicalViewController.h"
#import "PetData.h"
#import "ViewApptsViewController.h"
#import "AddPetViewController.h"
#import "AddPetViewController_iPhone5.h"

@interface PetDetailsViewController_iPhone5 ()

@end

@implementation PetDetailsViewController_iPhone5

@synthesize objPetData;
@synthesize scrollView;
@synthesize petInfoView;
@synthesize petMenuView;
@synthesize arrContacts;
@synthesize arrContactData;
@synthesize dataStack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCoreDataStack:(CoreDataStack *)cds
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //dataStack = cds;


        self.objPrimaryGroomerData = [[ContactData alloc] init];
        self.objPrimaryKennelData = [[ContactData alloc] init];
        self.objPrimaryVetData = [[ContactData alloc] init];
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PetData *objUpdatedPet = [self.petModel getPetByID:self.objPetData];
    self.objPetData = objUpdatedPet;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    arrContactData = [[NSMutableArray alloc] init];

    [self createModel];
    [self addViews];
    [self addObservers];
    //[self setScrollViewHeight];
    [self createNavigationButtons];
}

- (void) createModel
{
    self.petModel = [[PetModel alloc] init];
//    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
//    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIButtonTypeCustom target:self action:@selector(onDeleteTapped:)];
    [btnDoneItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = btnDoneItem;
}


- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUpdatedTapped:) name:@"updateTapped" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewContact:) name:@"viewContact" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewContact:) name:@"addNewContact" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSaveContact:) name:kSaveNewContact object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewContactList:) name:kViewList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPetAdded:) name:@"updatePet" object:nil];
}



- (void) removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateTapped" object:nil];
}

- (void)editPet:(PetData *)pet
{
    AddPetViewController_iPhone5* addPetViewController = [[AddPetViewController_iPhone5 alloc] initWithNibName:@"AddPetViewController_iPhone5" bundle:nil];
    //addPetViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPetViewController];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController presentModalViewController:navController animated:YES];
    [addPetViewController initializeEdit:self.objPetData];
    NSLog(@"edit pet");
}

- (void)newPetAdded:(NSNotification *)notification
{
    [self reset];
    self.objPetData = [self.petModel getPetByID:objPetData];

    arrContacts = nil;
    self.lblPetName.text = self.objPetData.name;
    //[self addViews];
    [self clearScrollView];
    [self addViews];
    [self createContactCards];
    [self resetScrollView];
}


- (void) addViews
{
    petInfoView = [[PetInfoView alloc] initWithData:objPetData];
    petInfoView.frame = CGRectMake(0, 0, 320, 156);
    petInfoView.delegate = self;
    [self.scrollView addSubview:petInfoView];

    petMenuView = [[PetMenuView alloc] initWithFrame:CGRectMake(0, 125, 320, 120)];
    petMenuView.delegate = self;
    [self.scrollView addSubview:petMenuView];
    //if ([[UIScreen mainScreen] bounds].size.height == 568) self.scrollView.frame = CGRectMake(0, -35, 320, 414);

    [self createContactCards];
}

- (void) changeView:(int)sender
{
    switch (sender)
    {
        case 0:
            [self showIdentification];
            break;

        case 1:
            [self showMedical];
            break;

        case 2:
            [self showAppointments];
            break;

        default:
            break;
    }
}

- (void)showAppointments
{
    ViewApptsViewController* viewApptsViewController = [[ViewApptsViewController alloc] initWithNibName:@"ViewApptsViewController" bundle:nil];
    [self.navigationController pushViewController:viewApptsViewController animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_SHOWAPPOINTMENTS"];
}

- (void)showMedical
{
    MedicalViewController *medicalViewController = [[MedicalViewController alloc] initWithNibName:@"MedicalViewController" bundle:nil];
    medicalViewController.objPetData = self.objPetData;
    [self.navigationController pushViewController:medicalViewController animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_SHOWPETMEDICAL"];
}

- (void) showIdentification
{
    IdentificationViewController* identificationView = [[IdentificationViewController alloc] initWithNibName:@"IdentificationViewController" bundle:nil withPetData:self.objPetData];
    [self.navigationController pushViewController:identificationView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_SHOWPETIDENTIFICATION"];
}

- (void) createContactCards
{
    NSLog(@" appointments %@", objPetData.appointments);
//    NSArray* arrGroomers;
//    NSArray* arrVets;
//    NSArray* arrKennels;


    _lblPetName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:27.0f];
    _lblPetName.textColor = [UIColor darkGrayColor];
    _lblPetName.text = [objPetData name];


    arrContacts = objPetData.contacts;



    for (int i = 0; i < 3; i++)
    {
        ContactCardView* contactCardView;
        ContactData *objVet;
        ContactData *objGroomer;
        ContactData *objKennel;

        for (int i = 0; i < [self.objPetData.contacts count]; i++)
        {
            ContactData *contact = [self.objPetData.contacts objectAtIndex:i];
            if ([contact.type isEqualToString:kVeterinarian]) objVet = [self.objPetData.contacts objectAtIndex:i];
            if ([contact.type isEqualToString:kGroomer]) objGroomer = [self.objPetData.contacts objectAtIndex:i];
            if ([contact.type isEqualToString:kKennel]) objKennel = [self.objPetData.contacts objectAtIndex:i];
        }


        self.objPrimaryVetData = objVet;
        self.objPrimaryGroomerData = objGroomer;
        self.objPrimaryKennelData = objKennel;

        if (i == 0) contactCardView = [[ContactCardView alloc] initWithContactData:objVet withType:kVeterinarian];
        if (i == 1) contactCardView = [[ContactCardView alloc] initWithContactData:objGroomer withType:kGroomer];
        if (i == 2) contactCardView = [[ContactCardView alloc] initWithContactData:objKennel  withType:kKennel];

        contactCardView.delegate = self;

        contactCardView.frame = CGRectMake(0, (135 * i) + 230, 320, 156);
        [self.scrollView addSubview:contactCardView];
    }

    self.scrollView.contentSize = CGSizeMake(320, 650);
}


- (void)addContactData:(ContactData *)contact
{
    NSLog(@"name %@", self.objPetData.name);

//    [self.objPetData.contacts addObject:contact];
//
//    PetData *convertedPet = [self.petModel updatePet:self.objPetData];


//    self.objPetData.name = _txtDogName.text;
//    self.objPetData.gender = _strGender;
//    if (![self.btnBirthday.titleLabel.text isEqualToString:@"Tap to add birthday"]) self.objPetData.birthday = self.btnBirthday.titleLabel.text;
//    NSLog(@"%@", self.btnBirthday.titleLabel.text);
//    self.objPetData.species = _strSpecies;
//    self.objPetData.breed = _txtBreed.text;
    //NSLog(@"image data %@", _imageData);

    if ([contact.type isEqualToString:kVeterinarian]) self.objPrimaryVetData = contact;
    if ([contact.type isEqualToString:kGroomer]) self.objPrimaryGroomerData = contact;
    if ([contact.type isEqualToString:kKennel]) self.objPrimaryKennelData = contact;

    NSLog(@"pet id %@", self.objPetData.guid);
    NSLog(@"kennel id %@", self.objPetData.primaryKennel);
    NSLog(@"vet id %@", self.objPetData.primaryVet);
    NSLog(@"groomer id %@", self.objPetData.primaryGroomer);
    NSLog(@"name %@", self.objPetData.name);
    NSLog(@"breed %@", self.objPetData.breed);
    NSLog(@"gender %@", self.objPetData.gender);
    NSLog(@"birthday %@", self.objPetData.birthday);
    NSLog(@"species %@", self.objPetData.species);

    NSLog(@"kennel %@", self.objPrimaryKennelData);
    NSLog(@"vet %@", self.objPrimaryVetData);
    NSLog(@"groomer %@", self.objPrimaryGroomerData);

    [self.objPetData.contacts removeAllObjects];

    if (self.objPrimaryKennelData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryKennelData];
    if (self.objPrimaryVetData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryVetData];
    if (self.objPrimaryGroomerData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryGroomerData];


    NSLog(@"contacts %@", self.objPetData.contacts);


    PetData *convertedPet = [self.petModel updatePet:self.objPetData];

    NSLog(@"converted pet %@", convertedPet);

    self.objPetData = convertedPet;
    [self reset];
    [arrContactData removeAllObjects];
    [self addViews];
}

- (void) reset
{
    for (UIView *i in self.scrollView.subviews)
        [i removeFromSuperview];
}


- (void)addContact:(NSString *)type withData:(ContactData *)data {
    NSLog(@"add contact ");
    AddContactViewController* addViewController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:type];
    addViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navController animated:YES];
    [addViewController updateContactForm:data];
}

- (NSArray *) getContactData:(NSString *)type
{
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == %@", type];
    NSArray *arrContactsFiltered = [arrContacts filteredArrayUsingPredicate:typePredicate];

    NSLog(@"%@", arrContactsFiltered);

    if (arrContactsFiltered != nil) return arrContactsFiltered;
    else return nil;
}


- (void) viewContact:(NSNotification *)note
{
    //NSLog(@"%@", [note object]);
    EditContactViewController* editContactView = [[EditContactViewController alloc] initWithNibName:@"EditContactViewController" bundle:nil contactData:[note object]];
    [self.navigationController pushViewController:editContactView animated:YES];
}

- (void) addNewContact:(NSNotification *)note
{
    NSLog(@"%@", [note object]);
    AddContactViewController* addVetController = [[AddContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil withType:[note object]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addVetController];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navController animated:YES];
}

- (void) viewContactList:(NSNotification *)note
{
    ContactListViewController* contactList = [[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil withType:[note object] andPet:objPetData displayAdd:NO];
    [self.navigationController pushViewController:contactList animated:YES];
}


- (void) setScrollViewHeight
{
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }

    [scrollView setContentSize:(CGSizeMake(320, scrollViewHeight))];
}


//- (void) getContactData
//{
//    NSMutableArray* contacts = [[NSMutableArray alloc] init];
//    [contacts addObjectsFromArray:[[objPetData contacts] allObjects]];
//}

- (void)viewDidUnload
{
    [self removeObservers];
    [self setLblPetName:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) onUpdatedTapped:(NSNotification *)note
{
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    //picker.useStandardDevicePicker = YES;
    //[picker setAllowedServices:APPAllowFacebook|APPAllowTwitter];
    [picker setDelegate:self];
    [picker setDefaultAccessToken:@"869d426184818feea2cb0a8af609552bf866811a848f6c6d71821b1d302fb7c9"];
    [self presentViewController:picker animated:YES completion:^(void){


    }];
}

- (void) onSaveContact:(NSNotification *)note
{
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
//        NSArray *arrContactsData = [array filteredArrayUsingPredicate:typePredicate];
//        Contact* objConData = [arrContactsData lastObject];
//
//        [objConData addPetObject:objPetData];
//        [objPetData addContactObject:objConData];
//
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
//
//        NSError* error = nil;
//        NSEntityDescription *entityDescription = [NSEntityDescription
//                entityForName:@"Pet"
//       inManagedObjectContext:self.dataStack.managedObjectContext];
//
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entityDescription];
//        NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
//        NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
//        Pet* objPetData = [[array filteredArrayUsingPredicate:typePredicate] lastObject];
//
//
//        NSLog(@"pet guid %@", objPetData.guid);
//        NSLog(@"pet count %i", [[array filteredArrayUsingPredicate:typePredicate] count]);
//
//        [objPetData addContactObject:objContact];
//        [objContact addPetObject:objPetData];
//
//        objPetData = objPetData;
//    }
//
//
//    [self.dataStack saveOrFail:^(NSError* error) {
//        NSLog(@"There was an error %@", [error description]);
//    }];
//
//    [self clearScrollView];
//
//    arrContacts = nil;
//
//    [self addViews];
//    [self createContactCards];
//    [self resetScrollView];
}


- (void) resetScrollView
{
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;

    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void) clearScrollView
{
    for(UIView *subview in [scrollView subviews])
    {
        [subview removeFromSuperview];
    }
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [petInfoView updatePhoto:[info objectForKey:AvatarPickerImage]];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)onDeleteTapped:(id)sender
{
    NSString *message = [NSString stringWithFormat:@"Are you sure you want to delete %@?", self.objPetData.name];
    NSString *title = [NSString stringWithFormat:@"Delete %@?", self.objPetData.name];
    BlockAlertView *alert = [BlockAlertView alertWithTitle:title message:message];
    [alert setCancelButtonWithTitle:@"Cancel" block:nil];

    [alert setDestructiveButtonWithTitle:@"Delete" block:^{
        [self.petModel deletePet:self.objPetData];
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate updatePetList];
        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_DELETEPET"];
    }];

    [alert show];
}

@end
