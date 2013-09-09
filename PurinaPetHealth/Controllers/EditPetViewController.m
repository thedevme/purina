//
//  EditPetViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "EditPetViewController.h"
#import "PetData.h"
#import "PetModel.h"
#import "EditContactViewController_iPad.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface EditPetViewController ()

@end

@implementation EditPetViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.objPetData = [[PetData alloc] init];

        self.objPrimaryGroomerData = [[ContactData alloc] init];
        self.objPrimaryKennelData = [[ContactData alloc] init];
        self.objPrimaryVetData = [[ContactData alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *dtapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
    dtapGestureRecognize.delegate = self;
    dtapGestureRecognize.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:dtapGestureRecognize];
    // Do any additional setup after loading the view from its nib.
}

- (void) scrollViewTapped:(UIGestureRecognizer *)sender
{
    [self checkTextFields];
}

- (void)initializeWithData:(PetData *)data
{
    [self initialize:data];
}

- (void)initializeWithData:(PetData *)data andContactData:(ContactData *)contact
{
    [self initialize:data];

    EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
            initWithNibName:@"EditContactViewController_iPad" bundle:nil andContactData:contact];
    editContact.delegate = self;
    editContact.type = contact.type;
    [self.navigationController pushViewController:editContact animated:YES];
}

- (void)initialize:(PetData *)data
{
    self.objPetData.name = @"";
    self.objPetData.gender = @"";
    self.objPetData.species = @"";
    self.objPetData.breed = @"";
    self.objPetData.guid = @"";
    self.objPrimaryKennelData = nil;
    self.objPrimaryVetData = nil;
    self.objPrimaryGroomerData = nil;

    [self addObservers];
    [self createModel];
    [self setSegmentedControls];
    [self clearForm];
    [self setFonts];

    self.objPetData = data;

    [self.txtBreed setReturnKeyType:UIReturnKeyDone];
    [self.txtDogName setReturnKeyType:UIReturnKeyDone];
    [self.txtBreed addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.txtDogName addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];

    [self reset];
    [self createAvatar];

    [self createNavigationButtons];
    [self setPetData];
    [self getPetContacts];
}

- (void)setPetData
{
    NSLog(@"name %@", self.objPetData.name);
    self.txtDogName.text = self.objPetData.name;
    self.txtBreed.text = self.objPetData.breed;

    if (![self.objPetData.birthday isEqualToString:@"NA"])
    {
        [self.btnBirthday setTitle:self.objPetData.birthday forState: UIControlStateNormal];
        [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateHighlighted];
    }

    if ([self.objPetData.gender isEqualToString:@"Female"])
    {
        self.chkFemale.alpha = 1.0f;
        self.chkMale.alpha = 0.0f;
        _strGender = @"Female";
    }
    else
    {
        self.chkFemale.alpha = 0.0f;
        self.chkMale.alpha = 1.0f;
        _strGender = @"Male";

    }

    if ([self.objPetData.species isEqualToString:@"Dog"])
    {
        self.chkDog.alpha = 1.0f;
        self.chkCat.alpha = 0.0f;
        _strSpecies = @"Dog";
    }
    else
    {
        self.chkDog.alpha = 0.0f;
        self.chkCat.alpha = 1.0f;
        _strSpecies = @"Cat";
    }


    self.avatar.image = [UIImage imageWithData:self.objPetData.imageData];

}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}




- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSave setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSave];

    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onDoneTapped:)];
    [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:btnCancelItem];
}

- (void)onDoneTapped:(id)sender
{
    [self saveUpdatedPet];



}

- (void) createAvatar
{
    
    
    UITapGestureRecognizer *dtapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizer:)];
    dtapGestureRecognize.delegate = self;
    dtapGestureRecognize.numberOfTapsRequired = 1;
    [self.avatar addGestureRecognizer:dtapGestureRecognize];
    
    UIImageView *backingViewForRoundedCorner = [[UIImageView alloc] initWithFrame:CGRectMake(80, 7, 138, 138)];
    backingViewForRoundedCorner.layer.cornerRadius = 5.0f;
    backingViewForRoundedCorner.clipsToBounds = YES;
    backingViewForRoundedCorner.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backingViewForRoundedCorner];
    
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 144, 144)];
    self.avatar.backgroundColor = [UIColor clearColor];
    [backingViewForRoundedCorner addSubview:self.avatar];
    
    self.imgBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addPhotoAvatarBorder.png"]];
    self.imgBorder.frame = CGRectMake(18, 35, 144, 144);
    
    _btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnIcon.frame = CGRectMake(18, 36, 144, 144);
    [_btnIcon setBackgroundImage:[UIImage imageNamed:@"addPhotoAvatar.png"] forState:UIControlStateNormal];
    [_btnIcon addTarget:self action:@selector(avatarClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.imgBorder];
    [self.view addSubview:_btnIcon];
    
    self.btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnUpdate.frame = CGRectMake(100, 125, 104, 36);
    [self.btnUpdate setImage:[UIImage imageNamed:@"updateBtn@2x.png"] forState:UIControlStateNormal];
    [self.btnUpdate addTarget:self action:@selector(avatarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnUpdate];


}



- (void) createModel
{
    _strName = @"";
    
    _objContactData = [[ContactData alloc] init];
    self.petModel = [[PetModel alloc] init];
}

- (void) setFonts
{
    _lblDog.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _lblCat.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _lblFemale.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _lblMale.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    
    _lblDog.textColor = [UIColor purinaDarkGrey];
    _lblCat.textColor = [UIColor purinaDarkGrey];
    _lblFemale.textColor = [UIColor purinaDarkGrey];
    _lblMale.textColor = [UIColor purinaDarkGrey];
    
    _txtTitleName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _txtTitleBirthday.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _txtTitleVet.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _txtTitleGroomer.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _txtTitleKennel.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _txtTitleBreed.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    
    _txtTitleName.textColor = [UIColor purinaDarkGrey];
    _txtTitleBirthday.textColor = [UIColor purinaDarkGrey];
    _txtTitleVet.textColor = [UIColor purinaDarkGrey];
    _txtTitleGroomer.textColor = [UIColor purinaDarkGrey];
    _txtTitleKennel.textColor = [UIColor purinaDarkGrey];
    _txtTitleBreed.textColor = [UIColor purinaDarkGrey];

    _txtDogName.textColor = [UIColor purinaDarkGrey];
    _txtBreed.textColor = [UIColor purinaDarkGrey];
}



- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(birthdaySet:) name:@"birthdaySet" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSaveContact:) name:kSaveNewContact object:nil];
}


- (void) setSegmentedControls
{
    _strGender = @"Male";
    _strSpecies = @"Dog";
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([self.avatar isKindOfClass:[UIButton class]]) {      //change it to your condition
        return NO;
    }
    return YES;
}

- (void) updateImage:(UIImage *)img
{
    self.imageData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    self.imgBorder.alpha = 0.0f;
    //NSLog(@"update image data %@", self.imageData);
}


- (void) savePet
{
//    self.objPetData.name = _txtDogName.text;
//    self.objPetData.gender = _strGender;
//    self.objPetData.species = _strSpecies;
//    self.objPetData.breed = _txtBreed.text;
//    //self.objPetData.guid = [UniqueID getUUID];
//    //NSLog(@"image data %@", _imageData);
//
//    if (self.objPrimaryKennelData.name.length != 0 ) [self.objPetData.contacts addObject:self.objPrimaryKennelData];
//    if (self.objPrimaryVetData.name.length != 0 ) [self.objPetData.contacts addObject:self.objPrimaryVetData];
//    if (self.objPrimaryGroomerData.name.length != 0 ) [self.objPetData.contacts addObject:self.objPrimaryGroomerData];
//
//    if (_imageData != NULL)
//    {
//        self.objPetData.imageData = _imageData;
//        NSLog(@"save image data not nil");
//    }
//
//    PetData *convertedPet = [self.petModel updatePet:self.objPetData];
//
//    NSLog(@"converted pet %@", convertedPet);


    self.objPetData.name = _txtDogName.text;
    self.objPetData.gender = _strGender;
    if (![self.btnBirthday.titleLabel.text isEqualToString:@"Tap to add birthday"]) self.objPetData.birthday = self.btnBirthday.titleLabel.text;
    NSLog(@"%@", self.btnBirthday.titleLabel.text);
    self.objPetData.species = _strSpecies;
    self.objPetData.breed = _txtBreed.text;
    //NSLog(@"image data %@", _imageData);



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

    if (_imageData != NULL)
    {
        self.objPetData.imageData = _imageData;
        NSLog(@"save image data not nil");
    }

    PetData *convertedPet = [self.petModel updatePet:self.objPetData];

    NSLog(@"converted pet %@", convertedPet);
    [self clearForm];

    //[self.delegate savedPetData:convertedPet];
    [self checkTextFields];



    _imageData = NULL;
    _avatar.image = nil;

    [self clearForm];
    [self checkTextFields];

    [self.delegate savedPetData:convertedPet];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    //[confirm show];
}

- (void)clearForm
{
    self.txtBreed.text = @"";
    self.txtDogName.text = @"";
    
    [self.btnBirthday setTitle: @"Tap to add birthday" forState: UIControlStateNormal];
    [self.btnVet setTitle: @"Tap to add primary veterinarian" forState: UIControlStateNormal];
    [self.btnGroomer setTitle: @"Tap to add primary groomer" forState: UIControlStateNormal];
    [self.btnKennel setTitle: @"Tap to add primary kennel" forState: UIControlStateNormal];
    
    [self.btnBirthday setTitleColor:[UIColor purinaLightGrey] forState:UIControlStateNormal];
    [self.btnVet setTitleColor:[UIColor purinaLightGrey] forState:UIControlStateNormal];
    [self.btnGroomer setTitleColor:[UIColor purinaLightGrey] forState:UIControlStateNormal];
    [self.btnKennel setTitleColor:[UIColor purinaLightGrey] forState:UIControlStateNormal];
    
    self.btnBirthday.titleLabel.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.btnVet.titleLabel.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.btnGroomer.titleLabel.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.btnKennel.titleLabel.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    
    self.txtDogName.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    self.txtBreed.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    
    
    [self reset];
}

- (void) getPetContacts
{
    for (int j = 0; j < [self.objPetData.contacts count]; j++)
    {
        [self saveCurrentContacts:[self.objPetData.contacts objectAtIndex:j]];
    }
}

- (void) saveCurrentContacts:(ContactData *)contact
{
    if ([contact.type isEqualToString:kVeterinarian])
    {
        self.objPrimaryVetData = contact;

        [_btnVet setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [_btnVet setTitle:self.objPrimaryVetData.name forState:UIControlStateNormal];
        [_btnVet setTitle:self.objPrimaryVetData.name forState:UIControlStateHighlighted];
    }
    if ([contact.type isEqualToString:kGroomer])
    {
        self.objPrimaryGroomerData = contact;

        [_btnGroomer setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [_btnGroomer setTitle:self.objPrimaryGroomerData.name forState:UIControlStateNormal];
        [_btnGroomer setTitle:self.objPrimaryGroomerData.name forState:UIControlStateHighlighted];
    }
    if ([contact.type isEqualToString:kKennel])
    {
        self.objPrimaryKennelData = contact;

        [_btnKennel setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [_btnKennel setTitle:self.objPrimaryKennelData.name forState:UIControlStateNormal];
        [_btnKennel setTitle:self.objPrimaryKennelData.name forState:UIControlStateHighlighted];
    }
}


- (void) checkTextFields
{
    [self.txtDogName resignFirstResponder];
    [self.txtBreed resignFirstResponder];
}


- (IBAction)onVetTapped:(id)sender
{
    [self checkTextFields];

    EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
            initWithNibName:@"EditContactViewController_iPad"
                     bundle:nil
                   withType:kVeterinarian];
    editContact.delegate = self;
    [self.navigationController pushViewController:editContact animated:YES];
    NSLog(@"vet tapped");
}

- (void)saveContact:(ContactData *)contact
{
    if ([contact.type isEqualToString:kVeterinarian])
    {
        [self.btnVet setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [self.btnVet setTitle:contact.name forState:UIControlStateNormal];
        [self.btnVet setTitle:contact.name forState:UIControlStateHighlighted];


        //if (self.objPrimaryVetData != nil) [self.objPetData.contacts removeObject:self.objPrimaryVetData];
        self.objPrimaryVetData = contact;
        self.objPetData.primaryVet = self.objPrimaryVetData.guid;
    }
    else if ([contact.type isEqualToString:kGroomer])
    {
        [self.btnGroomer setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [self.btnGroomer setTitle:contact.name forState:UIControlStateNormal];
        [self.btnGroomer setTitle:contact.name forState:UIControlStateHighlighted];

        //if (self.objPrimaryGroomerData != nil) [self.objPetData.contacts removeObject:self.objPrimaryGroomerData];
        self.objPrimaryGroomerData = contact;
        self.objPetData.primaryGroomer = self.objPrimaryGroomerData.guid;
    }
    else if ([contact.type isEqualToString:kKennel])
    {
        [self.btnKennel setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
        [self.btnKennel setTitle:contact.name forState:UIControlStateNormal];
        [self.btnKennel setTitle:contact.name forState:UIControlStateHighlighted];

        //if (self.objPrimaryKennelData != nil) [self.objPetData.contacts removeObject:self.objPrimaryKennelData];
        NSLog(@"kennel name before %@", self.objPrimaryKennelData.name);
        self.objPrimaryKennelData = contact;
        self.objPetData.primaryKennel = self.objPrimaryKennelData.guid;
        NSLog(@"updated kennel to %@", self.objPrimaryKennelData.name);
    }
}

- (IBAction)onGroomerTapped:(id)sender
{
    [self checkTextFields];

    EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
            initWithNibName:@"EditContactViewController_iPad"
                     bundle:nil
                   withType:kGroomer];
    editContact.delegate = self;
    [self checkTextFields];
    [self.navigationController pushViewController:editContact animated:YES];
    NSLog(@"groomer tapped");

}

- (IBAction)onKennelTapped:(id)sender
{
    [self checkTextFields];

    EditContactViewController_iPad* editContact = [[EditContactViewController_iPad alloc]
            initWithNibName:@"EditContactViewController_iPad"
                     bundle:nil
                   withType:kKennel];
    editContact.delegate = self;
    [self checkTextFields];
    [self.navigationController pushViewController:editContact animated:YES];
    NSLog(@"kennel tapped");

}


- (IBAction)onBirthdayTapped:(id)sender
{
    [self checkTextFields];


    DateOwnedPicker *addContactView = [DateOwnedPicker new];
    addContactView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 216);

    if(self.contactPopover == nil)
    {
        self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    }


    [self checkTextFields];
    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 216);
    self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    CGRect buttonFrame;
    buttonFrame.origin.x = 95;
    buttonFrame.origin.y = 248;
    buttonFrame.size.height = 20;
    buttonFrame.size.width = 20;

    [self.contactPopover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];

    NSLog(@"on bday tapped");
    //NSLog(@";%@", self.selectedTf);
    //[_delegate showBirthdayModal];
}

- (void)updateSelectedDate:(NSString *)date
{
    NSLog(@"date owned %@", date);
    self.selectedDate = date;

    [_btnBirthday setTitle:self.selectedDate forState:UIControlStateNormal];
    [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
    [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateHighlighted];
}

- (void) reset
{
    self.chkFemale.alpha = 0.0f;
    self.chkCat.alpha = 0.0f;
    self.chkDog.alpha = 1.0f;
    self.chkMale.alpha = 1.0f;
    
    _strGender = @"Male";
    _strSpecies = @"Dog";
    
    self.objPrimaryGroomerData = nil;
    self.objPrimaryVetData = nil;
    self.objPrimaryKennelData = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textfield
{
    if (textfield == _txtDogName)
    {
        [_txtBreed becomeFirstResponder];
    }
    else
    {
        [textfield resignFirstResponder];
    }
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [_txtDogName resignFirstResponder];
    [_txtBreed resignFirstResponder];
}

- (IBAction)onSaveTapped:(id)sender
{
    [self saveUpdatedPet];
}

- (void)saveUpdatedPet
{
    self.strName = self.txtDogName.text;

    if (![self.strName isEqualToString:@""]) [self savePet];
}


- (IBAction)onMaleTapped:(id)sender
{
    _chkFemale.alpha = 0.0f;
    _chkMale.alpha = 1.0f;
    _strGender = @"Male";
}

- (IBAction)onFemaleTapped:(id)sender
{
    _chkFemale.alpha = 1.0f;
    _chkMale.alpha = 0.0f;
    _strGender = @"Female";
}

- (IBAction)onDogTapped:(id)sender
{
    _chkCat.alpha = 0.0f;
    _chkDog.alpha = 1.0f;
    _strSpecies = @"Dog";
}

- (IBAction)onCatTapped:(id)sender
{
    _chkCat.alpha = 1.0f;
    _chkDog.alpha = 0.0f;
    _strSpecies = @"Cat";
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtDogName resignFirstResponder];
}

- (void) birthdaySet:(NSNotification *)note
{
    _objBirthdayData = [note object];
    [_btnBirthday setTitle:[_objBirthdayData birthdayDisplayDate] forState:UIControlStateNormal];
    [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
    [_btnBirthday setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateHighlighted];
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


//- (void) updatePetForm:(NSString *)type
//{
//    if ([type isEqualToString:kVeterinarian])
//    {
//        [_btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btnVet setTitle:_objContactData.name forState:UIControlStateNormal];
//        [_btnVet setTitle:_objContactData.name forState:UIControlStateHighlighted];
//    }
//    else if ([type isEqualToString:kGroomer])
//    {
//        [_btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btnGroomer setTitle:_objContactData.name forState:UIControlStateNormal];
//        [_btnGroomer setTitle:_objContactData.name forState:UIControlStateHighlighted];
//    }
//    else if ([type isEqualToString:kKennel])
//    {
//        [_btnKennel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_btnKennel setTitle:_objContactData.name forState:UIControlStateNormal];
//        [_btnKennel setTitle:_objContactData.name forState:UIControlStateHighlighted];
//    }
//}

-(IBAction)avatarClicked:(id)sender
{
    AvatarPickerPlus *picker = [[AvatarPickerPlus alloc] init];
    //picker.useStandardDevicePicker = YES;
    //[picker setAllowedServices:APPAllowFacebook|APPAllowTwitter];

    [picker setDelegate:self];
    [picker setDefaultAccessToken:@"869d426184818feea2cb0a8af609552bf866811a848f6c6d71821b1d302fb7c9"];
    [self presentViewController:picker animated:YES completion:^(void) {}];
}

-(void)AvatarPickerController:(AvatarPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_avatar setImage:[info objectForKey:AvatarPickerImage]];
    [self dismissModalViewControllerAnimated:YES];
    UIImage* img = [info objectForKey:AvatarPickerImage];


    [self updateImage:img];
    //btnIcon.alpha = 0.0f;
}

-(void)AvatarPickerControllerDidCancel:(AvatarPickerPlus *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
