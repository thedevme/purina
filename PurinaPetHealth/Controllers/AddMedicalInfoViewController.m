//
//  AddMedicalInfoViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "AddMedicalInfoViewController.h"

#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "OHASBasicMarkupParser.h"
#import "PetData.h"
#import "UniqueID.h"
#import "BlockAlertViewLandscape.h"

@interface AddMedicalInfoViewController ()

@end

@implementation AddMedicalInfoViewController
@synthesize isUpdating = _isUpdating;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.objCurrentPetData = [[PetData alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.

        [self.delegate updatePetData:self.objCurrentPetData];
    }
    [super viewWillDisappear:animated];


}

- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data
{
    self.petModel = [[PetModel alloc] init];
    self.objMedicalData = [[MedicalData alloc] init];
    self.type = type;
    self.contentType = contentType;
    self.data = data;
    self.arrMedicalItems = [[NSMutableArray alloc] init];
    
    [self setFonts];
    [self createContentType];
    [self createData];

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy"];

    NSDate *now = [[NSDate alloc] init];

    NSString *dateString = [format stringFromDate:now];
    self.lblDate.text = dateString;


    NSLog(@"init with type %i", self.objCurrentPetData.medicalItems.count);
    NSLog(@"init with guid %@", self.objCurrentPetData.guid);
}

- (void)createData 
{
    NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", self.type];
    NSMutableArray *medicalItems = [[NSMutableArray alloc] initWithArray:[self.objCurrentPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate]];
    self.arrMedicalItems = medicalItems;

    NSLog(@"type %@", self.type);
    NSLog(@"amount %i", self.arrMedicalItems.count);

    for (int i = 0; i < self.arrMedicalItems.count; i++)
    {
        MedicalData *objData = [self.arrMedicalItems objectAtIndex:i];
        NSLog(@"med name: %@", [objData name]);
        NSLog(@"dosage name: %@", [objData dosage]);
        NSLog(@"data: %@", [objData data]);
    }
    
    if (self.arrMedicalItems.count > 0)
    {
        self.lblMessage.alpha = 0.0f;
    }
    else
    {
        [self createErrorMessage:@"You do not have any medical items added."];
    }


    [self.tableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
    
    
    NSString* txt = @"Type in your medical information.";
    //
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:20]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"medical"]];
    
    self.lblDesc.attributedText = attrStr;

}

- (void) createErrorMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:22]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"medical"]];

    self.lblMessage.alpha = 1.0f;
    self.lblMessage.attributedText = attrStr;
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
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:32]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:range]];
    
    self.lblTitle.attributedText = attrStr;
}

- (void)onSaveTapped:(id)sender
{
    if (!self.isUpdating) self.objMedicalData.guid = [UniqueID getUUID];

    self.objMedicalData.type = self.type;


    if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        self.objMedicalData.name = self.tfName.text;
        self.objMedicalData.date = self.selectedDate;
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        self.objMedicalData.name = self.tfName.text;
        self.objMedicalData.dosage = self.tfSecondItem.text;
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        self.objMedicalData.name = self.tfName.text;
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        NSDate *today = [NSDate date];
        self.objMedicalData.date = [NSDate formatDate:today formatType:@"MMMM dd, yyyy"];
        self.objMedicalData.data = self.txtMedical.text;
    }

    NSLog(@"name %@", self.tfName.text);
    NSLog(@"data %@", self.txtMedical.text);
    NSLog(@"second %@", self.tfSecondItem.text);

    [self saveMedicalItem];
}


- (void) saveMedicalItem
{

    PetData *objPetData = [[PetData alloc] init];
    MedicalData *objMedical = self.objMedicalData;
    //NSString *numID = self.objCurrentPetData.guid;


    if (self.isUpdating)
    {
        [self.petModel updateMedicalItem:objMedical];
        objPetData = [self.petModel getPetByID:self.objCurrentPetData];
        NSLog(@"is updating");
    }
    else
    {
        NSLog(@"is not updating");
        objPetData = [self.petModel saveMedicalItem:objMedical withPet:self.objCurrentPetData];
    }


    self.objCurrentPetData = nil;
    self.objCurrentPetData = objPetData;



    [self.arrMedicalItems removeAllObjects];
    [self createData];
    [self clear];
    [self.tableView reloadData];

//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Saved!"
//                                                    message:@"Medical item saved."
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil, nil];
    //[alert show];


    NSLog(@"there are %i medical items! - med info", [self.objCurrentPetData.medicalItems count]);
}

- (void)clear
{
    self.tfName.text = @"";
    self.tfSecondItem.text = @"";
    self.txtMedical.text = @"";
}

- (void)createContentType
{
    if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        self.imgDateBG.alpha = 1.0f;
        self.lblDate.alpha = 1.0f;
        self.tfSecondItem.alpha = 0.0f;
        self.lblSecondItem.alpha = 0.0f;
        
        [self hideTxtField];
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        self.lblSecondItem.text = @"Dosage";
        //[self.tfName becomeFirstResponder];
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        [self hideSecondItem];
        //[self.tfName becomeFirstResponder];
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        self.txtMedical.text = self.data;
        self.imgTxtBG.alpha = 1.0f;
        [self showTxtField];
    }
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

//TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrMedicalItems count];
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

    MedicalItemCell *cell = (MedicalItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalItemCell" owner:self options:nil];
    MedicalData *objMedicalData = [self.arrMedicalItems objectAtIndex:[indexPath row]];


    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    //[cell initWithData:objMedicalData];
    cell.delegate = self;
    cell.objMedicalData = objMedicalData;

    if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        cell.lblName.text = objMedicalData.name;
    }
    else if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        cell.lblName.text = objMedicalData.name;
        cell.lblSecondItem.text = objMedicalData.date;
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        cell.lblName.text = objMedicalData.name;
        cell.lblSecondItem.text = objMedicalData.dosage;
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        cell.txtData.text = objMedicalData.data;
        cell.lblDateAdded.text = objMedicalData.date;
    }

    cell.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:24.0f];
    cell.lblName.textColor = [UIColor purinaDarkGrey];

    cell.lblDateAdded.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    cell.lblDateAdded.textColor = [UIColor purinaDarkGrey];

    cell.lblSecondItem.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    cell.lblSecondItem.textColor = [UIColor purinaDarkGrey];

    cell.lblSecondItem.font = [UIFont fontWithName:kHelveticaNeue size:15.0f];
    cell.lblSecondItem.textColor = [UIColor purinaDarkGrey];

    cell.txtData.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    cell.txtData.textColor = [UIColor purinaDarkGrey];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalData *medicalData = [self.arrMedicalItems objectAtIndex:[indexPath row]];

    [self clear];

    if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        self.tfName.text = medicalData.name;
        self.tfSecondItem.text = medicalData.date;
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        self.tfName.text = medicalData.name;
        self.tfSecondItem.text = medicalData.dosage;
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        self.tfName.text = medicalData.name;
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        self.txtMedical.text = medicalData.data;
    }

    self.objMedicalData = medicalData;
    self.objMedicalData.type = self.type;
    self.isUpdating = YES;

}

- (void)deleteItem:(MedicalData *)data
{
    //NSArray *medicalItems;

    NSString * type;

    if ([data.type isEqualToString:kMedicalTypeVaccination]) type = @"vaccination";
    if ([data.type isEqualToString:kMedicalTypeNotes]) type = @"note";
    if ([data.type isEqualToString:kMedicalTypeDiet]) type = @"diet information";
    if ([data.type isEqualToString:kMedicalTypeAllergy]) type = @"allergy information";
    if ([data.type isEqualToString:kMedicalTypeMedCondition]) type = @"medical condition";
    if ([data.type isEqualToString:kMedicalTypeSpecialNeeds]) type = @"special needs";
    if ([data.type isEqualToString:kMedicalTypeInsurance]) type = @"insurance information";
    if ([data.type isEqualToString:kMedicalTypeMedication]) type = @"medication";
    if ([data.type isEqualToString:kMedicalTypeSurgery]) type = @"surgery information";

    NSString *message = [NSString stringWithFormat:@"Are you sure you wish to delete this %@?", type];
    NSString *title = [NSString stringWithFormat:@"Delete %@", type];

    BlockAlertViewLandscape *alert = [[BlockAlertViewLandscape alloc] init];


    if ([data.type isEqualToString:kMedicalTypeVaccination] || [data.type isEqualToString:kMedicalTypeMedication])
    {
        alert.numMessageOffset = 235;
        alert.numTitleOffset = 70;
        alert.numButtonYOffset = 100;
        alert.numHeightOffset = 100;
        alert.numButtonXOffset = 0;
    }
    else if ([data.type isEqualToString:kMedicalTypeNotes])
    {
        alert.numTitleOffset = 40;
        alert.numMessageOffset = 170;
        alert.numButtonYOffset = 30;
        alert.numButtonXOffset = 62;
        alert.numHeightOffset = 100;

    }
    else if ([data.type isEqualToString:kMedicalTypeMedCondition] || [data.type isEqualToString:kMedicalTypeSurgery] ||
            [data.type isEqualToString:kMedicalTypeAllergy])
    {
        alert.numTitleOffset = 100;
        alert.numMessageOffset = 290;
        alert.numButtonYOffset = 150;
        alert.numHeightOffset = 150;
        NSLog(@"set med condition");
    }
    else if ([data.type isEqualToString:kMedicalTypeSpecialNeeds] || [data.type isEqualToString:kMedicalTypeDiet])
    {
        alert.numTitleOffset = 90;
        alert.numMessageOffset = 270;
        alert.numButtonYOffset = 130;
        alert.numHeightOffset = 130;
        alert.numButtonXOffset = 0;
        NSLog(@"set med condition");
    }
    else
    {
        alert.numTitleOffset = 60;
        alert.numMessageOffset = 225;
        alert.numButtonYOffset = 90;
        alert.numHeightOffset = 100;
        alert.numButtonXOffset = 0;


    }


    [alert initWithTitle:title message:message];

    [alert setCancelButtonWithTitle:@"Cancel" block:nil];

    [alert setDestructiveButtonWithTitle:@"Delete" block:^{
        [self.arrMedicalItems removeAllObjects];
        NSLog(@"count before %i", self.objCurrentPetData.medicalItems.count);
        [self.petModel deleteMedicalItem:data];
        PetData *petData = [self.petModel updatePet:self.objCurrentPetData];

        NSLog(@"count after %i", petData.medicalItems.count);
        self.objCurrentPetData = nil;
        self.objCurrentPetData = petData;


        NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", self.type];
        NSMutableArray *medicalItems = [[NSMutableArray alloc] initWithArray:[self.objCurrentPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate]];
        self.arrMedicalItems = medicalItems;



        [self clear];

        NSLog(@"before reload");
        [self.tableView reloadData];
    }];


    [alert showWithOneButton];











}


- (void)updateSelectedDate:(NSString *)date
{
    NSLog(@"date owned %@", date);
    self.lblDate.text = date;
    self.selectedDate = date;
}

- (void)viewDidUnload {
    [self setBtnDate:nil];
    [self setTableView:nil];
    [self setLblDesc:nil];
    [self setLblEdit:nil];
    [self setLblMessage:nil];
    [super viewDidUnload];
}
- (IBAction)onDateTapped:(id)sender 
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
    [self.contactPopover presentPopoverFromRect:self.btnDate.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];

    NSLog(@"%@", self.selectedTf);
}
@end
