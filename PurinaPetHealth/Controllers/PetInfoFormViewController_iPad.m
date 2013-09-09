//
//  PetInfoFormViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "PetInfoFormViewController_iPad.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "MedicalCell_iPad.h"
#import "PetData.h"
#import "IdentificationFormViewController.h"
#import "AddMedicalInfoViewController.h"

@interface PetInfoFormViewController_iPad ()

@end

@implementation PetInfoFormViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    NSLog(@"inititalize");
    [self setLabels];
    [self createMedicalMenuData];
    [self setData];
    [self showIdentification];
    [self setFormFields];
    [self setPetData];
    [self setScroller];
    [self createNavigationButtons];
}

- (void)setScroller
{
    self.identificationScrollView.pagingEnabled = NO;
    self.identificationScrollView.showsHorizontalScrollIndicator = NO;
    self.identificationScrollView.showsVerticalScrollIndicator = YES;
    self.identificationScrollView.contentSize = CGSizeMake(self.identificationScrollView.frame.size.width, 1000);

}

//

- (void)setFormFields
{
    [self.tfEyeColor setReturnKeyType:UIReturnKeyDone];
    [self.tfWeight setReturnKeyType:UIReturnKeyDone];
    [self.tfChipNo addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfCoatMarkings addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfColor addTarget:self
                     action:@selector(textFieldFinished:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfLicenseNo addTarget:self
                         action:@selector(textFieldFinished:)
               forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfPedigree addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfPrice addTarget:self
                     action:@selector(textFieldFinished:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfTagNo addTarget:self
                     action:@selector(textFieldFinished:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
    [self.selectedTf resignFirstResponder];
}

- (void)setPetData
{
    if ([self.objPetData.gender isEqualToString:@"Male"]) self.lblNeutered.text = @"Neutered";
    else self.lblNeutered.text = @"Spayed";

    if (![self.objPetData.weight isEqualToString:@"NA"]) self.tfWeight.text = self.objPetData.weight;
    if (![self.objPetData.color isEqualToString:@"NA"]) self.tfColor.text = self.objPetData.color;
    if (![self.objPetData.eyeColor isEqualToString:@"NA"]) [self.tfEyeColor setText:self.objPetData.eyeColor];
    if (![self.objPetData.coatMarkings isEqualToString:@"NA"]) self.tfCoatMarkings.text = self.objPetData.coatMarkings;
    if (![self.objPetData.price isEqualToString:@"NA"]) self.tfPrice.text = self.objPetData.price;
    if (![self.objPetData.tagNo isEqualToString:@"NA"]) self.tfTagNo.text = self.objPetData.tagNo;
    if (![self.objPetData.chipNo isEqualToString:@"NA"]) self.tfChipNo.text = self.objPetData.chipNo;
    if (![self.objPetData.licenseNo isEqualToString:@"NA"]) self.tfLicenseNo.text = self.objPetData.licenseNo;
    if (![self.objPetData.pedigree isEqualToString:@"NA"]) self.tfPedigree.text = self.objPetData.pedigree;
    //if (![self.objPetData.owned isEqualToString:@"NA"]) self.tfOw.text = owned;

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

    NSLog(@"spayed %@", self.objPetData.spayedNeutered);
}


- (void)setData
{
    self.lblName.text = self.objPetData.name;
    self.lblGender.text = self.objPetData.gender;
    self.lblBday.text = self.objPetData.birthday;
    self.lblBreed.text = self.objPetData.breed;

    [self getPetAge:self.objPetData.birthday];

    [self.medicalTableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
}

- (void) getPetAge:(NSString *)bday
{
    if ([bday isEqualToString:@"NA"])
    {
        self.lblAge.text = @"-";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:bday];

        NSString *age = [self age:dateFromString];
        self.lblAge.text = age;
    }
}

- (NSString *)age:(NSDate *)dateOfBirth {

    NSInteger years;
    NSInteger months;
    NSInteger days;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];

    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
            (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        years = [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        years = [dateComponentsNow year] - [dateComponentsBirth year];
    }

    NSLog(@"years:%d", years);

    if ([dateComponentsNow year] == [dateComponentsBirth year]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] > [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] < [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month] + 12;
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        months = 11;
    } else {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    }

    NSLog(@"months:%d", months);

    if ([dateComponentsNow year] == [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        days = [dateComponentsNow day] - [dateComponentsBirth day];
    }

    if (years == 0 && months == 0) {
        if (days == 1) {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"day", @"day")];
        } else {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"days", @"days")];
        }
    } else if (years == 0) {
        if (months == 1) {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"mo.", @"mo.")];
        } else {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"mos.", @"mos.")];
        }
    } else if ((years != 0) && (months == 0)) {
        if (years == 1) {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"yr", @"yr")];
        } else {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"yrs", @"yrs")];
        }
    } else {
        if ((years == 1) && (months == 1)) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yr &", @"yr &"), months, NSLocalizedString(@"mo.", @"mo.")];
        } else if (years == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yr &", @"yr &"), months, NSLocalizedString(@"mos.", @"mos.")];
        } else if (months == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yrs &", @"yrs &"), months, NSLocalizedString(@"mo.", @"mo.")];
        } else {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yrs &", @"yrs &"), months, NSLocalizedString(@"mos.", @"mos.")];
        }

    }

}

- (void) createMedicalMenuData
{
    self.sections = [[NSMutableArray alloc] init];
    [self.sections addObject:kMedicalTypeInsurance];
    [self.sections addObject:kMedicalTypeVaccination];
    [self.sections addObject:kMedicalTypeMedication];
    [self.sections addObject:kMedicalTypeMedCondition];
    [self.sections addObject:kMedicalTypeSurgery];
    [self.sections addObject:kMedicalTypeAllergy];
    [self.sections addObject:kMedicalTypeSpecialNeeds];
    [self.sections addObject:kMedicalTypeDiet];
    [self.sections addObject:kMedicalTypeNotes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setBtnIdentification:nil];
    [self setBtnMedical:nil];
    [self setMedicalTableView:nil];
    [self setIdentificationScrollView:nil];
    [super viewDidUnload];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSave setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSave];

    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
    [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:btnCancelItem];
}

- (void) setLabels
{
    self.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:40.0f];
    self.lblGender.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblBday.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblAge.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblBreed.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];

    self.lblGender.textColor = [UIColor purinaDarkGrey];
    self.lblBday.textColor = [UIColor purinaDarkGrey];
    self.lblAge.textColor = [UIColor purinaDarkGrey];
    self.lblBreed.textColor = [UIColor purinaDarkGrey];

    self.lblTitleGender.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleBday.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleAge.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleBreed.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];

    self.lblTitleAge.textColor = [UIColor purinaRed];
    self.lblTitleGender.textColor = [UIColor purinaRed];
    self.lblTitleBday.textColor = [UIColor purinaRed];
    self.lblTitleBreed.textColor = [UIColor purinaRed];
    self.lblName.textColor = [UIColor purinaDarkGrey];


    //Identification Form
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

    self.lblOwnedSince.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblOwnedSince.textColor = [UIColor purinaDarkGrey];

    self.lblNeutered.textColor = [UIColor purinaDarkGrey];
    self.lblNeutered.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblNo.textColor = [UIColor purinaDarkGrey];
    self.lblNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblYes.textColor = [UIColor purinaDarkGrey];
    self.lblYes.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblOwnedValue.textColor = [UIColor purinaDarkGrey];
    self.lblOwnedValue.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
}

- (void) showIdentification
{
    self.identificationScrollView.alpha = 1.0f;
    self.medicalTableView.alpha = 0.0f;
    self.btnIdentification.selected = YES;
    self.btnMedical.selected = NO;
}

- (void) showMedical
{
    self.medicalTableView.alpha = 1.0f;
    self.identificationScrollView.alpha = 0.0f;
    self.btnIdentification.selected = NO;
    self.btnMedical.selected = YES;
}

- (IBAction)onButtonTapped:(id)sender
{
      if ([sender tag] == 0)
      {
          [self showIdentification];
      }
      if ([sender tag] == 1)
      {
          [self showMedical];
      }
}

//TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sections count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    MedicalCell_iPad *cell = (MedicalCell_iPad *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalCell_iPad" owner:self options:nil];

    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.lblName.text = [self.sections objectAtIndex:[indexPath row]];
    cell.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:24.0f];
    cell.lblName.textColor = [UIColor purinaDarkGrey];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [self.sections objectAtIndex:[indexPath row]]);
    NSString *type = [self.sections objectAtIndex:[indexPath row]];

     self.addMedicalInfo = [[AddMedicalInfoViewController alloc]
            initWithNibName:@"AddMedicalInfoViewController"
                     bundle:nil];
    self.addMedicalInfo.delegate = self;
    [self.navigationController pushViewController:self.addMedicalInfo animated:YES];

    self.addMedicalInfo.objCurrentPetData = self.objPetData;
    [self.addMedicalInfo initializeWithType:type withContentType:[self setContentType:type] andWithData:nil];
    [self createMessage:type];
}

- (void)updatePetData:(PetData *)pet
{
    NSLog(@"update pet data back button hit");

    self.objPetData = pet;

}

- (NSString *)setContentType:(NSString *)type
{
    NSString *contentType;

    if ([type isEqualToString:kMedicalTypeMedCondition])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeSurgery])
    {
        contentType = kTypeDatePicker;
    }
    else if ([type isEqualToString:kMedicalTypeAllergy])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeMedication])
    {
        contentType = kTypeDosagePicker;
    }
    else if ([type isEqualToString:kMedicalTypeInsurance])
    {
        contentType = kTypeTextView;
    }
    else if ([type isEqualToString:kMedicalTypeVaccination])
    {
        contentType = kTypeDatePicker;
    }
    else if ([type isEqualToString:kMedicalTypeDiet])
    {
        contentType = kTypeTextView;
    }
    else if ([type isEqualToString:kMedicalTypeNotes])
    {
        contentType = kTypeTextView;
    }

    return contentType;
}






- (NSString *) createMessage:(NSString *)type
{
    NSString *message;

    if ([type isEqualToString:kMedicalTypeMedCondition])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Medical Condition"];
        [self.addMedicalInfo createMessage:message withRange:@"Medical Condition"];
    }
    else if ([type isEqualToString:kMedicalTypeSurgery])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Surgery"];
        [self.addMedicalInfo createMessage:message withRange:@"Surgery"];
    }
    else if ([type isEqualToString:kMedicalTypeAllergy])
    {
        message = [NSString stringWithFormat:@"Add an %@", @"Allergy"];
        [self.addMedicalInfo createMessage:message withRange:@"Allergy"];
    }
    else if ([type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Special Needs"];
        [self.addMedicalInfo createMessage:message withRange:@"Special Needs"];
    }
    else if ([type isEqualToString:kMedicalTypeMedication])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Medication"];
        [self.addMedicalInfo createMessage:message withRange:@"Medication"];
    }
    else if ([type isEqualToString:kMedicalTypeInsurance])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Insurance Info"];
        [self.addMedicalInfo createMessage:message withRange:@"Insurance Info"];
    }
    else if ([type isEqualToString:kMedicalTypeVaccination])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Vaccine"];
        [self.addMedicalInfo createMessage:message withRange:@"Vaccine"];
    }
    else if ([type isEqualToString:kMedicalTypeDiet])
    {
        message = [NSString stringWithFormat:@"Add %@ Info", @"Diet"];
        [self.addMedicalInfo createMessage:message withRange:@"Diet"];
    }
    else if ([type isEqualToString:kMedicalTypeNotes])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Notes"];
        [self.addMedicalInfo createMessage:message withRange:@"Notes"];
    }

    return message;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (IBAction)onOwnedTapped:(id)sender
{

    [self.view resignFirstResponder];

    DateOwnedPicker *addContactView = [DateOwnedPicker new];
    addContactView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 216);

    if(self.contactPopover == nil)
    {
        self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    }


    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 216);
    self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [self.contactPopover presentPopoverFromRect:self.btnOwned.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];

    NSLog(@"%@", self.selectedTf);
}

- (void)updateSelectedDate:(NSString *)date
{
    NSLog(@"date owned %@", date);
    
    self.lblOwnedValue.text = date;
}

- (IBAction)onSaveTapped:(id)sender
{
    [self savePetData];

    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)savePetData
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
    if (![self.lblOwnedValue.text isEqualToString:@""] || ![self.lblOwnedValue.text isEqualToString:self.objPetData.owned]) self.objPetData.owned = self.lblOwnedValue.text;

    [self.delegate saveIdentificationData:self.objPetData];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.selectedTf = textField;


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");

//    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
//        // back button was pressed.  We know this is true because self is no longer
//        // in the navigation stack.
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
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

- (void) onCancelTapped:(id)sender
{

    [self savePetData];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

@end
