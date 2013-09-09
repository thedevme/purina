//
//  CreateMedialItemViewController_iPhone.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/24/12.
//
//

#import "CreateMedialItemViewController_iPhone.h"
#import "TDDatePickerController.h"
#import "Constants.h"
#import "MedicalData.h"
#import "PetData.h"
#import "PetModel.h"
#import "PetDetailsView_iPad.h"
#import "UniqueID.h"
#import "OHASBasicMarkupParser.h"
#import "UIColor+PetHealth.h"

@interface CreateMedialItemViewController_iPhone ()

@end

@implementation CreateMedialItemViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.objCurrentPetData = [[PetData alloc] init];
        self.objMedicalData = [[MedicalData alloc] init];
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


    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }


}

- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data
{

    self.petModel = [[PetModel alloc] init];
    self.type = type;
    self.contentType = contentType;
    self.data = data;

    [self setFonts];
    [self createContentType];
    [self setDatePicker];
    [self createNavigationButtons];


    if (self.isUpdating)
    {
        if ([self.contentType isEqualToString:kTypeDatePicker])
        {
            self.tfName.text = _objMedicalData.name;
            self.tfSecondItem.text = _objMedicalData.date;
        }
        else if ([self.contentType isEqualToString:kTypeDosagePicker])
        {
            self.tfName.text = _objMedicalData.name;
            self.tfSecondItem.text = _objMedicalData.dosage;
        }
        else if ([self.contentType isEqualToString:kTypeSingleItem])
        {
            self.tfName.text = _objMedicalData.name;
        }
        else if ([self.contentType isEqualToString:kTypeTextView])
        {
            self.txtMedical.text = _objMedicalData.data;
            NSLog(@"update text field with medical data %@", _objMedicalData.data);
        }
        NSLog(@"is updating %@", _objMedicalData);
    }
    else NSLog(@"is not updating");

    NSLog(@"current pet data %@", self.objCurrentPetData.name);
}

- (void)setFonts {
    self.lblName.textColor = [UIColor purinaDarkGrey];
    self.lblName.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblSecondItem.textColor = [UIColor purinaDarkGrey];
    self.lblSecondItem.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfSecondItem.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfSecondItem.textColor = [UIColor purinaDarkGrey];

    self.tfName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfName.textColor = [UIColor purinaDarkGrey];
}

- (void) createMessage:(NSString *)message withRange:(NSString *)range
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:range]];
    
    self.lblTitle.attributedText = attrStr;
}

- (void)createContentType {
    if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        self.datePicker.alpha = 1.0f;
        self.imgDateBG.alpha = 1.0f;
        self.lblDate.alpha = 1.0f;

        [self hideTxtField];
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        self.lblSecondItem.text = @"Dosage";
        [self.tfName becomeFirstResponder];
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        [self hideSecondItem];
        [self.tfName becomeFirstResponder];
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        self.txtMedical.text = self.data;
        self.imgTxtBG.alpha = 1.0f;
        [self showTxtField];
    }
}


- (void) setDatePicker
{
    //NSDate* today = [NSDate date];
    //self.datePicker.maximumDate = today;
    self.lblDate.text = NSLocalizedString(@"TODAY", nil);
    [self updateDate];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    self.selectedTf = textField;

    if (self.selectedTf == self.tfName) {
        [self.tfSecondItem becomeFirstResponder];
    }
    else{
        [self.selectedTf resignFirstResponder];
    }


    return YES;
}


- (void) showSecondItem
{
    self.lblSecondItem.alpha = 1.0;
    self.tfSecondItem.alpha = 1.0f;
    self.imgSecondItem.alpha = 1.0f;
}

- (void) hideSecondItem
{
    self.lblSecondItem.alpha = 0.0;
    self.tfSecondItem.alpha = 0.0f;
    self.imgSecondItem.alpha = 0.0f;
}

- (void) hideTxtField
{
    self.txtMedical.alpha = 0.0f;
}

- (void) showTxtField
{
    self.txtMedical.alpha = 1.0f;
}


- (void) updateDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //self.birthdayDate = [NSDate formatDate:self.datePicker.date formatType:@"MM-dd-yyyy"];
    
	[df setDateStyle:NSDateFormatterLongStyle];
	[df setTimeStyle:NSDateFormatterNoStyle];
    //NSLog(@"date %@", [NSDate formatDate:pickerDate.date formatType:@"MMMM dd, yyyy"]);
	//self.birthdayDisplayDate = [NSString stringWithFormat:@"%@", [df stringFromDate:self.datePicker.date]];
    
    
    NSDate* today = [NSDate date];
    
    if ([NSDate isSameDay:self.datePicker.date otherDay:today])
    {
        self.lblDate.text = NSLocalizedString(@"TODAY", nil);

        NSDate *today = [NSDate date];
        self.selectedDate = [NSDate formatDate:today formatType:@"MM/dd/yyyy"];
    }
    else
    {
        self.lblDate.text = [NSDate formatDate:self.datePicker.date formatType:@"MMMM dd, yyyy"];
        self.selectedDate = [NSDate formatDate:self.datePicker.date formatType:@"MM/dd/yyyy"];
    }
    
    
    
    if (![self.lblDate.text isEqualToString:NSLocalizedString(@"TODAY", nil)])
        self.lblDate.textColor = [UIColor blackColor];
}

- (IBAction)changeDate:(id)sender
{
    [self updateDate];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createToolbar];
}

- (void)createToolbar {
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
            [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)],
            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)],
            nil];
    [numberToolbar sizeToFit];
    self.tfName.inputAccessoryView = numberToolbar;
    self.tfSecondItem.inputAccessoryView = numberToolbar;
}

//
-(void)cancel{
    [self.tfName resignFirstResponder];
    [self.tfSecondItem resignFirstResponder];
}

-(void)done{
    [self.tfName resignFirstResponder];
    [self.tfSecondItem resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) onCancelTapped:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
    NSLog(@"cancel tapped");
}

- (void)onSaveTapped:(id)sender
{
    self.objMedicalData.type = self.type;
    NSLog(@"type %@", self.objMedicalData.type);
    self.objMedicalData.name = self.tfName.text;
    self.objMedicalData.dosage = self.tfSecondItem.text;
    self.objMedicalData.date = self.selectedDate;
    self.objMedicalData.data = self.txtMedical.text;
    if (!self.isUpdating) self.objMedicalData.guid = [UniqueID getUUID];

    [self saveMedicalItem];
}


- (void) saveMedicalItem
{
    //MedicalData *objMedical = self.objMedicalData;

    NSLog(@"type %@", self.objMedicalData.type);
    NSLog(@"name %@", self.objMedicalData.name);
    NSLog(@"guid %@", self.objMedicalData.guid);
    NSLog(@"data %@", self.objMedicalData.data);
    NSLog(@"date %@", self.objMedicalData.date);
    NSLog(@"dosage %@", self.objMedicalData.dosage);

    
    
    PetData *objPetData = [[PetData alloc] init];



    if (self.isUpdating)
    {
        [self.petModel updateMedicalItem:self.objMedicalData];
        [self.delegate updateDone];
    }
    else
    {
        objPetData = [self.petModel saveMedicalItem:self.objMedicalData withPet:self.objCurrentPetData];
        PetData *currentPet = [self.petModel getPetByID:objPetData];
        self.objCurrentPetData = nil;
        self.objCurrentPetData = currentPet;
        [self.delegate updatePetData:self.objCurrentPetData];
    }









    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
}


- (void)viewDidUnload {
    [self setTfName:nil];
    [self setDatePicker:nil];
    [self setLblSecondItem:nil];
    [self setTfSecondItem:nil];
    [self setImgSecondItem:nil];
    [self setTxtMedical:nil];
    [self setImgDateBG:nil];
    [self setLblTitle:nil];
    [self setImgTxtBG:nil];
    [self setLblName:nil];
    [self setLblName:nil];
    [super viewDidUnload];
}
@end
