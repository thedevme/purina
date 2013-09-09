//
//  AddAPetView_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import "AddAPetView_iPad.h"
#import "PetData.h"
#import "PetModel.h"
#import "TPKeyboardAvoidingScrollView.h"

@implementation AddAPetView_iPad
@synthesize objPetData = _objPetData;
@synthesize petModel = _petModel;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"AddAPetView_iPad" owner:self options:nil];
        self = [nib objectAtIndex:0];
        
        [self initialize];
    }
    
    return self;
}


- (void)initialize
{
    [self addObservers];
    [self createModel];
    [self setSegmentedControls];
    [self clearForm];
    [self setFonts];
    self.objPetData = [[PetData alloc] init];
    self.objPrimaryGroomerData = [[ContactData alloc] init];
    self.objPrimaryKennelData = [[ContactData alloc] init];
    self.objPrimaryVetData = [[ContactData alloc] init];

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
    [self checkCancel];
}

- (void)checkCancel
{
   int numCount = [[self.petModel getPetData] count];

   if (numCount == 0) self.btnCancel.alpha = 0.0f;
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

- (void) createAvatar
{


    UITapGestureRecognizer *dtapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizer:)];
    dtapGestureRecognize.delegate = self;
    dtapGestureRecognize.numberOfTapsRequired = 1;
    [self.avatar addGestureRecognizer:dtapGestureRecognize];

    UIImageView *backingViewForRoundedCorner = [[UIImageView alloc] initWithFrame:CGRectMake(57, 17, 144, 144)];
    backingViewForRoundedCorner.layer.cornerRadius = 5.0f;
    backingViewForRoundedCorner.clipsToBounds = YES;
    backingViewForRoundedCorner.backgroundColor = [UIColor clearColor];
    [self addSubview:backingViewForRoundedCorner];
    
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 144, 144)];
    self.avatar.backgroundColor = [UIColor clearColor];
    [backingViewForRoundedCorner addSubview:self.avatar];
    
    self.imgBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addPhotoAvatarBorder.png"]];
    self.imgBorder.frame = CGRectMake(18, 35, 144, 144);
    
    _btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnIcon.frame = CGRectMake(18, 36, 144, 144);
    [_btnIcon setBackgroundImage:[UIImage imageNamed:@"addPhotoAvatar.png"] forState:UIControlStateNormal];
    [_btnIcon addTarget:self action:@selector(avatarClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.imgBorder];
    [self addSubview:_btnIcon];

    self.btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnUpdate.frame = CGRectMake(76, 138, 104, 36);
    [self.btnUpdate setImage:[UIImage imageNamed:@"updateBtn@2x.png"] forState:UIControlStateNormal];
    [self.btnUpdate addTarget:self action:@selector(avatarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnUpdate];
}



- (void) createModel
{
    _strName = @"";
    
    numGroomerCount = [[Contact getContactData:kGroomer] count];
    numVetCount = [[Contact getContactData:kVeterinarian] count];
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
    self.avatar.image = [UIImage imageWithData:self.imageData];
    //NSLog(@"update image data %@", self.imageData);
}


- (void) savePet
{



    self.objPetData.name = _txtDogName.text;
    self.objPetData.gender = _strGender;
    if (![self.btnBirthday.titleLabel.text isEqualToString:@"Tap to add birthday"]) self.objPetData.birthday = self.btnBirthday.titleLabel.text;
    else self.objPetData.birthday = @"";
    NSLog(@"%@", self.btnBirthday.titleLabel.text);
    self.objPetData.species = _strSpecies;
    self.objPetData.breed = _txtBreed.text;
    self.objPetData.guid = [UniqueID getUUID];
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

    if (self.objPrimaryKennelData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryKennelData];
    if (self.objPrimaryVetData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryVetData];
    if (self.objPrimaryGroomerData.name.length != 0) [self.objPetData.contacts addObject:self.objPrimaryGroomerData];


    NSLog(@"contacts %@", self.objPetData.contacts);

    if (_imageData != NULL)
    {
        self.objPetData.imageData = _imageData;
        NSLog(@"save image data not nil");
    }

    PetData *convertedPet = [self.petModel savePet:self.objPetData];

    NSLog(@"converted pet %@", convertedPet);
    [self clearForm];

    [self.delegate savePet:convertedPet];
    [self.delegate hideAddPets];
    [self checkTextFields];

    self.objPetData.name = @"";
    self.objPetData.gender = @"";
    self.objPetData.species = @"";
    self.objPetData.breed = @"";
    self.objPetData.guid = @"";
    self.objPrimaryKennelData = nil;
    self.objPrimaryVetData = nil;
    self.objPrimaryGroomerData = nil;
    self.avatar.image = nil;
    
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


- (void) checkTextFields
{
    [self.txtDogName resignFirstResponder];
    [self.txtBreed resignFirstResponder];
}


- (IBAction)onVetTapped:(id)sender
{
    [self checkTextFields];
    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 185;
    buttonFrame.size.height = 320;
    buttonFrame.size.width = 480;

    [_delegate presentModal:kVeterinarian andRect:buttonFrame];

}

- (IBAction)onGroomerTapped:(id)sender
{
    [self checkTextFields];

    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 248;
    buttonFrame.size.height = 320;
    buttonFrame.size.width = 480;
    [_delegate presentModal:kGroomer andRect:buttonFrame];
}

- (IBAction)onKennelTapped:(id)sender
{
    [self checkTextFields];

    CGRect buttonFrame;
    buttonFrame.origin.x = 650;
    buttonFrame.origin.y = 305;
    buttonFrame.size.height = 320;
    buttonFrame.size.width = 480;

    [_delegate presentModal:kKennel andRect:buttonFrame];
}


- (IBAction)onBirthdayTapped:(id)sender
{
    [self checkTextFields];
    [_delegate showBirthdayModal];
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
    self.objBirthdayData = nil;

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
    self.strName = self.txtDogName.text;

    if (![self.strName isEqualToString:@""]) [self savePet];
    else
    {
//        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Sorry" message:@"Please add your pet's name before saving!"];
//        [alert setDestructiveButtonWithTitle:@"OK" block:nil];
//        [alert show];
    }
}

- (IBAction)onCancelTapped:(id)sender
{
    [self clearForm];
    [self reset];
    [self.delegate hideAddPets];
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
    [_btnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
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
    ContactData *objContactData = [note object];


    if ([objContactData.type isEqualToString:kVeterinarian])
    {
        [self.btnVet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnVet setTitle:objContactData.name forState:UIControlStateNormal];
        [self.btnVet setTitle:objContactData.name forState:UIControlStateHighlighted];

        self.objPrimaryVetData = objContactData;
        self.objPrimaryVetData.guid = [UniqueID getUUID];
        self.objPetData.primaryVet = self.objPrimaryVetData.guid;

        NSLog(@"contact data %@", objContactData);
        NSLog(@"pet data primary vet %@", self.objPetData.primaryVet);
        NSLog(@"primary vet data %@", self.objPrimaryVetData);
    }
    else if ([objContactData.type isEqualToString:kGroomer])
    {
        [self.btnGroomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnGroomer setTitle:objContactData.name forState:UIControlStateNormal];
        [self.btnGroomer setTitle:objContactData.name forState:UIControlStateHighlighted];

        self.objPrimaryGroomerData = objContactData;
        self.objPrimaryGroomerData.guid = [UniqueID getUUID];
        self.objPetData.primaryGroomer = self.objPrimaryGroomerData.guid;
    }
    else if ([objContactData.type isEqualToString:kKennel])
    {
        [self.btnKennel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnKennel setTitle:objContactData.name forState:UIControlStateNormal];
        [self.btnKennel setTitle:objContactData.name forState:UIControlStateHighlighted];

        self.objPrimaryKennelData = objContactData;
        self.objPrimaryKennelData.guid = [UniqueID getUUID];
        self.objPetData.primaryKennel = self.objPrimaryKennelData.guid;
    }
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)avatarClicked:(id)sender
{
    [self.delegate addPhoto];
}

@end
