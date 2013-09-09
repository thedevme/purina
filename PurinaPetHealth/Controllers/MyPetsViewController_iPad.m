//
//  MyPetsViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//  

#import "MyPetsViewController_iPad.h"
#import "CreateMedicalItemViewController.h"
#import "MedicalData.h"
#import "IdentificationView_iPad.h"
#import "OHASBasicMarkupParser.h"
#import "PetInfoFormViewController_iPad.h"
#import "AppointmentData.h"
#import "DDPageControl.h"
#import "MyPetsAppointmentView.h"

@interface MyPetsViewController_iPad ()

@end

@implementation MyPetsViewController_iPad


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"My Pets";
        self.navigationItem.title = @"My Pets";
        self.tabBarItem.image = [UIImage imageNamed:@"tabIcon_paw.png"];
        [self.navigationController setNavigationBarHidden:YES];
        self.isFirstPetCreated = NO;
    }
    return self;
}

- (void)newPetAdded {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view did load");
    [self initialize];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
    [self.petDetails resetAppointments];
}

- (void) initialize
{
    [self addObservers];
    [self createPetDetails];
    [self createPetScroller];
    [self createNavigationButtons];
    [self createAddAPet];


    if ([[self.petModel getPetData] count] < 1)
    {
        NSLog(@"add a pet is shown");
        [self hideScroller];
    }

    [self createApptTitle];
}

- (void)createApptTitle 
{

}

- (void) hideScroller
{
    self.scrollView.alpha = 0;
    self.pageControls.alpha = 0;
    //if (self.objCurrentPetData.appointments.count == 0)
}

- (void) showScroller
{
    self.scrollView.alpha = 1;
    //self.lblApptMessage.alpha = 0;
    if (self.arrAppointments.count > 1) self.pageControls.alpha = 1;
    else self.pageControls.alpha = 0;
}



- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"pets"]];

    self.lblMessage.alpha = 1.0f;
    self.lblMessage.attributedText = attrStr;
}

- (void) createApptMessage:(NSString *)message
{

}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFirstPet:) name:kShowPet object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMedicalItem:) name:kSaveMedicalItem object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEditPrimaryContact:) name:kEditPrimaryContact object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editContactInfo:) name:kEditContactInfo object:nil];
}

- (void) showFirstPet:(NSNotification *)note
{
    //NSLog(@"show first pet %@", [note object]);
    if (!self.isFirstPetCreated)
    {
        self.objCurrentPetData = [note object];
        [self.petDetails initializeData:[note object]];
        self.isFirstPetCreated = YES;
    }
}

- (void)editPetData:(PetData *)pet
{
    EditPetViewController *editPetView = [[EditPetViewController alloc]
            initWithNibName:@"EditPetViewController"
                     bundle:nil];
    editPetView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:editPetView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentModalViewController:navController animated:YES];
    [editPetView initializeWithData:pet];
}

- (void) updatePetList
{
    
}

- (void)editPetData:(PetData *)pet withContactData:(ContactData *)contact
{
    EditPetViewController *editPetView = [[EditPetViewController alloc]
            initWithNibName:@"EditPetViewController" bundle:nil];
    editPetView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:editPetView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentModalViewController:navController animated:YES];
    [editPetView initializeWithData:pet andContactData:contact];
}

- (void)savedPetData:(PetData *)data
{
    self.objCurrentPetData = data;
    NSLog(@"save 1 %@", self.objCurrentPetData.name);
    NSArray *pets = [[NSArray alloc] initWithArray:[self.petModel getPetData]];
    NSLog(@"save 2");
    [self.petScroller updatePetInfo:pets];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePetInfo" object:self.objCurrentPetData];
    NSLog(@"save 3");
}

- (void)deletePetData:(PetData *)pet
{
    //NSLog(@"delete %@", pet);
    NSLog(@"name %@  guid %@", self.objCurrentPetData.name, self.objCurrentPetData.guid);
    NSLog(@"name %@  guid %@", pet.name, pet.guid);

    [self.petModel deletePet:pet];
    [self.petScroller resetScroller:[self.petModel getPetData]];


    if ([[_petModel getPetData] count] == 0)
    {
        self.lblMessage = [[OHAttributedLabel alloc] init];
        self.lblMessage.backgroundColor = [UIColor clearColor];
        self.lblMessage.frame = CGRectMake(100, 280, 401, 80);
        self.lblMessage.alpha = 0.0f;
        [self.view addSubview:self.lblMessage];

        [self createMessage:@"You currently\n have no pets added."];
        [self showAddNewPets];
        [self.addAPetView checkCancel];
        [self hideScroller];
    }
}

- (void) saveMedicalItem:(NSNotification *)note
{
    MedicalData *objMedicalData = [note object];
    PetData *objPetData = [[PetData alloc] init];

    if ([objMedicalData.type isEqualToString:kMedicalTypeNotes]) objPetData = [self.petModel saveMedicalMisc:objMedicalData withPet:self.objCurrentPetData];
    else if ([objMedicalData.type isEqualToString:kMedicalTypeDiet]) objPetData = [self.petModel saveMedicalMisc:objMedicalData withPet:self.objCurrentPetData];
    else if ([objMedicalData.type isEqualToString:kMedicalTypeInsurance]) objPetData = [self.petModel saveMedicalMisc:objMedicalData withPet:self.objCurrentPetData];
    else
    {
        objPetData = [self.petModel saveMedicalItem:objMedicalData withPet:self.objCurrentPetData];
    }
    self.objCurrentPetData = nil;
    self.objCurrentPetData = objPetData;



    //[self.petDetails updateMedical:self.objCurrentPetData];
    [self.petScroller createArray:[self.petModel getPetData]];

    //NSLog(@"there are %i medical items!", [self.objCurrentPetData.medicalItems count]);
}


- (void) editContactInfo:(NSNotification *)note
{
    EditPetViewController *editPetView = [[EditPetViewController alloc]
            initWithNibName:@"EditPetViewController"
                     bundle:nil];
    editPetView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:editPetView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentModalViewController:navController animated:YES];
    [editPetView initializeWithData:self.objCurrentPetData];
}

- (void)addContactData:(ContactData *)contact
{
    [self.petScroller createArray:[self.petModel getPetData]];
}

- (void) createAddAPet
{
    self.addAPetView = [[AddAPetView_iPad alloc] init];
    if ([[self.petModel getPetData] count] == 0) self.addAPetView.frame = CGRectMake(605, 0, 419, 660);
    else self.addAPetView.frame = CGRectMake(1050, 0, 419, 660);
    self.addAPetView.delegate = self;
    [self.view addSubview:self.addAPetView];



    if ([[self.petModel getPetData] count] == 0)
    {
        self.lblMessage = [[OHAttributedLabel alloc] init];
        self.lblMessage.backgroundColor = [UIColor clearColor];
        self.lblMessage.frame = CGRectMake(100, 280, 401, 80);
        self.lblMessage.alpha = 0.0f;
        [self.view addSubview:self.lblMessage];

        [self createMessage:@"You currently\n have no pets added."];
    }

    NSLog(@"%i", [[self.petModel getPetData] count]);
}

- (void) createPetDetails
{
    self.petDetails = [[PetDetailsView_iPad alloc] init];
    self.petDetails.delegate = self;
    self.petDetails.frame = CGRectMake(605, 0, 419, 660);
    [self.petDetails getPetAppointments];
    [self.view addSubview:self.petDetails];
}

- (void)createNewMedWithType:(NSString *)type andContentType:(NSString *)contentType
{
    CreateMedicalItemViewController *addContactView = [CreateMedicalItemViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 200);
    addContactView.type = type;
    addContactView.contentType = contentType;


    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 250;
    buttonFrame.size.height = 50;
    buttonFrame.size.width = 50;

    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 200);
    popover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [popover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (void)hideAddPets
{
    if ([[self.petModel getPetData] count] > 0) [self hideAddNewPets];
}

- (void)savePet:(PetData *)data
{
    NSLog(@"total pets %i", [[self.petModel getPetData] count]);

    self.objCurrentPetData = data;



    if (self.lblMessage != nil) self.lblMessage.alpha = 0.f;
    [self.petScroller updateScroller:[self.petModel getPetData]];


    self.petDetails.objPetData = self.objCurrentPetData;
    self.petDetails.identificationView.objPetData = self.objCurrentPetData;


    //[self.petDetails updateMedical:objPetData];


    [self.petDetails updateIdentification: self.objCurrentPetData];
    [self.petDetails resetAppointments];
    _imageData = NULL;
    _avatar.image = nil;
    //_imgIcon.alpha = 1.0f;

}

- (void)updateTextWithType:(NSString *)type withContentType:(NSString *)contentType andData:(NSString *)data
{
    CreateMedicalItemViewController *addContactView = [CreateMedicalItemViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 200);
    addContactView.type = type;
    addContactView.contentType = contentType;
    addContactView.data = data;


    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 250;
    buttonFrame.size.height = 50;
    buttonFrame.size.width = 50;

    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 200);
    popover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [popover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    self.btnAddNew = [[UIBarButtonItem alloc] initWithTitle:@"Add New" style:UIButtonTypeCustom target:self action:@selector(onNewTapped:)];
    [self.btnAddNew setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:self.btnAddNew];
}

- (void) createPetScroller
{
    self.petModel = [[PetModel alloc] init];
    //NSLog(@"%@", [self.petModel getPetData]);
    self.petScroller = [[PetScrollerView alloc] initWithArray:[self.petModel getPetData]];
    self.petScroller.frame = CGRectMake(0 , 40 , 656, 590);
    self.petScroller.delegate = self;
    [self.view insertSubview:self.petScroller atIndex:1];
}

- (void)showModal:(NSString *)type withData:(PetData *)data
{
    PetInfoFormViewController_iPad *petInfoForm = [[PetInfoFormViewController_iPad alloc]
            initWithNibName:@"PetInfoFormViewController_iPad"
                     bundle:nil];
    petInfoForm.objPetData = self.objCurrentPetData;
    petInfoForm.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:petInfoForm];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentModalViewController:navController animated:YES];
    //[petInfoForm setData:data];
}

- (void) onEditPrimaryContact:(NSNotification *)note
{
    ContactData *objData = [note object];
    [self.petModel updateContact:objData];
}


- (void)onNewTapped:(id)sender
{
    //NSLog(@"new tapped");
    [self showAddNewPets];
}

- (void)saveIdentificationData:(PetData *)petData
{
    PetData* objSavedPetData = [self.petModel savePetData:petData];
    self.objCurrentPetData = objSavedPetData;
    //NSLog(@"save 1 %@", self.objCurrentPetData.name);
    NSArray *pets = [[NSArray alloc] initWithArray:[self.petModel getPetData]];
    //NSLog(@"save 2");
    //[self.petScroller updatePetInfo:pets];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePetInfo" object:self.objCurrentPetData];



    //[self dismissModalViewControllerAnimated:YES];
}

- (void)didDismissModalView
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) showAddNewPets
{
    CGRect basketTopFrame = self.addAPetView.frame;
    basketTopFrame.origin.x = 605;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.addAPetView.frame = basketTopFrame;
    
    [UIView commitAnimations];
    self.isAddAPetShown = YES;
    [self hideScroller];
}


- (void) hideAddNewPets
{
    CGRect basketTopFrame = self.addAPetView.frame;
    basketTopFrame.origin.x = 1050;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.addAPetView.frame = basketTopFrame;
    
    [UIView commitAnimations];
    self.isAddAPetShown = NO;
    [self showScroller];
}




- (void) presentModal:(NSString *)type andRect:(CGRect)rect
{
    NSLog(@"add contact");

    AddContactViewController_iPhone5 *addContactView = [AddContactViewController_iPhone5 new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 480);
    addContactView.type = type;

    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 480);

    popover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];

}

- (void)showBirthdayModal
{
    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 125;
    buttonFrame.size.height = 320;
    buttonFrame.size.width = 480;

    self.datePickerView = [DatePickerViewController new];
    self.datePickerView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.datePickerView];
    self.datePickerView.contentSizeForViewInPopover = CGSizeMake(320, 380);
    popover = [[UIPopoverController alloc] initWithContentViewController:navController ];
    //popover.popoverBackgroundViewClass
    [popover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (void)dateSelected:(BirthdayData *)data
{
    //NSLog(@"petNames bday selected was %@", strData);
}


- (void)dismissModal
{

}

- (void)showPet:(PetData *)pet
{
    NSArray *arrPets = [self.petModel getPetData];
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"guid == %@", pet.guid];
    PetData *objPet = [[arrPets filteredArrayUsingPredicate:typePredicate] lastObject];

    NSLog(@"show pet %@ filtered name %@", pet.name, objPet.name);

    self.objCurrentPetData = objPet;
    self.petDetails.objPetData = objPet;
    self.petDetails.identificationView.objPetData = objPet;


    //[self.petDetails updateMedical:objPetData];


    [self.petDetails updateIdentification: self.objCurrentPetData];
    [self.petDetails.identificationView resetIdentification: self.objCurrentPetData];

    //[self.petDetails.medicalView updateWithNewPet:objPetData];
    [self.petScroller createArray:[self.petModel getPetData]];


    [self.petDetails resetAppointments];
}

- (void)addPhoto
{
    NSLog(@"my pets view controller - addPhoto");
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    //picker.useStandardDevicePicker = YES;
    [picker setAllowedServices:nil];


    [picker setDelegate:self];
    [picker setDefaultAccessToken:@"869d426184818feea2cb0a8af609552bf866811a848f6c6d71821b1d302fb7c9"];
    [self presentViewController:picker animated:YES completion:^(void) {}];
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_avatar setImage:[info objectForKey:AvatarPickerImage]];
    [self dismissModalViewControllerAnimated:YES];
    UIImage* img = [info objectForKey:AvatarPickerImage];


    [self.addAPetView updateImage:img];
    //btnIcon.alpha = 0.0f;
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
