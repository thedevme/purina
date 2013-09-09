//
//  IdentificationViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import "IdentificationViewController.h"

@interface IdentificationViewController ()

@end

@implementation IdentificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withPetData:(PetData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Identification";
        self.objPetData = data;
    }
    return self;
}

- (IBAction)onDateTapped:(id)sender
{
    self.datePickerView = [[TDDatePickerController alloc]
            initWithNibName:@"TDDatePickerController"
                     bundle:nil];
    self.datePickerView.delegate = self;
   [self presentSemiModalViewController:self.datePickerView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"view did load");

    self.petModel = [[PetModel alloc] init];

    UIImageView* formHeaderBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"petHeaderBG.png"]];
    formHeaderBG.frame = CGRectMake(0, 0, 320, 60);

    [self.view addSubview:formHeaderBG];
    
    
    UILabel* lblPetName = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 300, 30)];
    lblPetName.font = [UIFont fontWithName:kHelveticaNeueBold size:20.0f];
    lblPetName.textColor = [UIColor purinaDarkGrey];
    lblPetName.textAlignment = UITextAlignmentCenter;
    lblPetName.backgroundColor = [UIColor clearColor];
    lblPetName.text = self.objPetData.name;
    
    [self.view addSubview:lblPetName];

    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(320, 1125);

    [self setLabels];
    [self createNavigationButtons];
    [self setData:self.objPetData];
    //_scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, numHeight);
    // Do any additional setup after loading the view from its nib.
}

- (void)setData:(PetData *)pet
{
    self.objPetData = pet;

    if (![self.objPetData.weight isEqualToString:@"NA"]) self.tfWeight.text = self.objPetData.weight;
    if (![self.objPetData.color isEqualToString:@"NA"]) self.tfColor.text = self.objPetData.color;
    if (![self.objPetData.eyeColor isEqualToString:@"NA"]) [self.tfEyeColor setText:self.objPetData.eyeColor];
    if (![self.objPetData.coatMarkings isEqualToString:@"NA"]) self.tfCoatMarkings.text = self.objPetData.coatMarkings;
    if (![self.objPetData.price isEqualToString:@"NA"]) self.tfPrice.text = self.objPetData.price;
    if (![self.objPetData.tagNo isEqualToString:@"NA"]) self.tfTagNo.text = self.objPetData.tagNo;
    if (![self.objPetData.chipNo isEqualToString:@"NA"]) self.tfChipNo.text = self.objPetData.chipNo;
    if (![self.objPetData.licenseNo isEqualToString:@"NA"]) self.tfLicenseNo.text = self.objPetData.licenseNo;
    if (![self.objPetData.pedigree isEqualToString:@"NA"]) self.tfPedigree.text = self.objPetData.pedigree;
    
    
    if ([self.objPetData.spayedNeutered isEqualToString:@"No"])
    {
        self.imgNo.alpha = 1.0f;
        self.imgYes.alpha = 0.0f;
    }
    else
    {
        self.imgNo.alpha = 0.0f;
        self.imgYes.alpha = 1.0f;
    }
    //if (![self.objPetData.owned isEqualToString:@"NA"]) self.tfOw.text = owned;
}


-(void)datePickerSetDate:(TDDatePickerController*)viewController
{
    [self dismissSemiModalViewController:self.datePickerView];

    self.selectedDate = viewController.datePicker.date;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy"];

    NSString *dateOwned = [formatter stringFromDate:self.selectedDate];
    self.lblDateValue.text = dateOwned;
}
- (IBAction)onYesNoTapped:(id)sender
{
    if ([sender tag] == 0)
    {
        self.imgNo.alpha = 1.0f;
        self.imgYes.alpha = 0.0f;
        self.objPetData.spayedNeutered = @"No";
    }
    else
    {
        self.imgNo.alpha = 0.0f;
        self.imgYes.alpha = 1.0f;
        self.objPetData.spayedNeutered = @"Yes";
    }
}

-(void)datePickerClearDate:(TDDatePickerController*)viewController
{
    [self dismissSemiModalViewController:self.datePickerView];

    self.selectedDate = nil;
}

-(void)datePickerCancel:(TDDatePickerController*)viewController
{
    [self dismissSemiModalViewController:self.datePickerView];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
    resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSaveItem];
}

- (void) onSaveTapped:(id)sender
{
    [self saveData];
}

- (void) saveData
{
    if (![self.tfChipNo.text isEqualToString:@""] || ![self.tfChipNo.text isEqualToString:self.objPetData.chipNo]) self.objPetData.chipNo = self.tfChipNo.text;
    if (![self.tfCoatMarkings.text isEqualToString:@""] || ![self.tfCoatMarkings.text isEqualToString:self.objPetData.coatMarkings]) self.objPetData.coatMarkings = self.tfCoatMarkings.text;
    if (![self.tfLicenseNo.text isEqualToString:@""] || ![self.tfLicenseNo.text isEqualToString:self.objPetData.licenseNo]) self.objPetData.licenseNo = self.tfLicenseNo.text;
    if (![self.tfPedigree.text isEqualToString:@""] || ![self.tfPedigree.text isEqualToString:self.objPetData.pedigree]) self.objPetData.pedigree = self.tfPedigree.text;
    if (![self.tfTagNo.text isEqualToString:@""] || ![self.tfTagNo.text isEqualToString:self.objPetData.tagNo]) self.objPetData.tagNo = self.tfTagNo.text;
    if (![self.tfColor.text isEqualToString:@""] || ![self.tfColor.text isEqualToString:self.objPetData.color]) self.objPetData.color = self.tfColor.text;
    if (![self.tfEyeColor.text isEqualToString:@""] || ![self.tfEyeColor.text isEqualToString:self.objPetData.eyeColor]) self.objPetData.eyeColor = self.tfEyeColor.text;
    if (![self.tfPrice.text isEqualToString:@""] || ![self.tfPrice.text isEqualToString:self.objPetData.price]) self.objPetData.price = self.tfPrice.text;
    if (![self.tfWeight.text isEqualToString:@""] || ![self.tfWeight.text isEqualToString:self.objPetData.weight]) self.objPetData.weight = self.tfWeight.text;
    if (self.selectedDate != nil) self.objPetData.owned = self.lblDateValue.text;

    PetData *objSavedPetData = [self.petModel savePetData:self.objPetData];

    self.objPetData = objSavedPetData;
    [self.navigationController popViewControllerAnimated:YES];

//    NSString *message = [NSString stringWithFormat:@"%@ identification information was saved!", self.objPetData.name];
//    NSString *title = [NSString stringWithFormat:@"%@ identification", self.objPetData.name];
//    BlockAlertView *alert = [BlockAlertView alertWithTitle:title message:message];
//    [alert setCancelButtonWithTitle:@"OK" block:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//
//    [alert show];

}


- (void) setLabels
{
    self.tfChipNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblChipNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfColor.textColor = [UIColor purinaDarkGrey];
    self.lblColor.textColor = [UIColor purinaDarkGrey];
    self.lblColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfEyeColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblEyeColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfCoatMarkings.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblCoatMarkings.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfPrice.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfPrice.textColor = [UIColor purinaDarkGrey];
    self.lblPrice.textColor = [UIColor purinaDarkGrey];
    self.lblPrice.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfTagNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTagNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfLicenseNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblLicenseNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfPedigree.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfPedigree.textColor = [UIColor purinaDarkGrey];
    self.lblPedigree.textColor = [UIColor purinaDarkGrey];
    self.lblPedigree.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfWeight.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfWeight.textColor = [UIColor purinaDarkGrey];
    self.lblWeight.textColor = [UIColor purinaDarkGrey];
    self.lblWeight.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];


    self.lblDateOwned.textColor = [UIColor purinaDarkGrey];
    self.lblDateOwned.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    //self.lblDateValue.text = @"Tap to add";
    self.lblDateValue.textColor = [UIColor purinaDarkGrey];
    self.lblDateValue.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblNo.textColor = [UIColor purinaDarkGrey];
    self.lblNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblYes.textColor = [UIColor purinaDarkGrey];
    self.lblYes.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    if ([self.objPetData.gender isEqualToString:@"Male"]) self.lblSpayed.text = @"Neutered";
    else self.lblSpayed.text = @"Spayed";
    self.lblSpayed.textColor = [UIColor purinaDarkGrey];
    self.lblSpayed.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setLblNo:nil];
    [self setLblYes:nil];
    [self setLblDateOwned:nil];
    [self setLblDateValue:nil];
    [super viewDidUnload];
}
@end
