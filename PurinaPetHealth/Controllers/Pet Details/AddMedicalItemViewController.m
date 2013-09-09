//
//  AddMedicalItemViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import "AddMedicalItemViewController.h"
#import "AddMedicalItemCell.h"
#import "CreateMedialItemViewController_iPhone.h"
#import "BlockAlertView.h"

@interface AddMedicalItemViewController ()

@end

@implementation AddMedicalItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.petModel = [[PetModel alloc] init];
        self.objMedicalData = [[MedicalData alloc] init];
        self.arrMedicalItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data
{
    self.type = type;
    self.contentType = contentType;
    self.data = data;


    //self.objCurrentPetData = [self.petModel getPetByID:self.objCurrentPetData];
    //NSLog(@"init with type pet data %@", self.objCurrentPetData);
    
    [self setFonts];
    [self createContentType];
    [self createData];
    [self createNavigationButtons];
    [self.tableView reloadData];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    self.btnAddNew = [[UIBarButtonItem alloc] initWithTitle:@"Add New" style:UIButtonTypeCustom target:self action:@selector(onNewTapped:)];
    [self.btnAddNew setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:self.btnAddNew];
}

- (void)onNewTapped:(id)sender
{
    NSLog(@"update text iphone data %@  type %@  contentType %@", self.data, self.type, self.contentType);

    CreateMedialItemViewController_iPhone*createMedialItemView = [[CreateMedialItemViewController_iPhone alloc] initWithNibName:@"CreateMedialItemViewController_iPhone" bundle:nil];
    createMedialItemView.objCurrentPetData = self.objCurrentPetData;
    createMedialItemView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createMedialItemView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    self.isUpdating = NO;


    [self presentModalViewController:navController animated:YES];
    [createMedialItemView initializeWithType:self.type withContentType:self.contentType andWithData:self.data];

    NSString *message;

    if ([self.type isEqualToString:kMedicalTypeMedCondition])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Medical Condition"];
        [createMedialItemView createMessage:message withRange:@"Medical Condition"];
    }
    else if ([self.type isEqualToString:kMedicalTypeSurgery])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Surgery"];
        [createMedialItemView createMessage:message withRange:@"Surgery"];
    }
    else if ([self.type isEqualToString:kMedicalTypeAllergy])
    {
        message = [NSString stringWithFormat:@"Add an %@", @"Allergy"];
        [createMedialItemView createMessage:message withRange:@"Allergy"];
    }
    else if ([self.type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Special Needs"];
        [createMedialItemView createMessage:message withRange:@"Special Needs"];
    }
    else if ([self.type isEqualToString:kMedicalTypeMedication])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Medication"];
        [createMedialItemView createMessage:message withRange:@"Medication"];
    }
    else if ([self.type isEqualToString:kMedicalTypeInsurance])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Insurance Info"];
        [createMedialItemView createMessage:message withRange:@"Insurance Info"];
    }
    else
    {
        message = [NSString stringWithFormat:@"Add a %@", self.type];
        [createMedialItemView createMessage:message withRange:self.type];
    }


    self.contentType = self.contentType;
}

- (void)createData
{

    self.objCurrentPetData = [self.petModel getPetByID:self.objCurrentPetData];
    NSLog(@"init with type %i", self.objCurrentPetData.medicalItems.count);
    NSLog(@"init with guid %@", self.objCurrentPetData.guid);

    NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", self.type];

    NSMutableArray *medicalItems = [[NSMutableArray alloc] initWithArray:[self.objCurrentPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate]];

    NSLog(@"medical items count %i", medicalItems.count);

    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];

    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSMutableArray* arrMedicalData = [[NSMutableArray alloc] initWithArray:[medicalItems sortedArrayUsingDescriptors:sortDescriptors]];


    self.arrMedicalItems = arrMedicalData;
    
    NSLog(@"type %@", self.type);
    NSLog(@"amount %i", self.arrMedicalItems.count);
    
//    for (int i = 0; i < self.arrMedicalItems.count; i++)
//    {
//        MedicalData *objData = [self.arrMedicalItems objectAtIndex:i];
//        NSLog(@"med name: %@", [objData name]);
//        NSLog(@"dosage name: %@", [objData dosage]);
//        NSLog(@"data: %@", [objData data]);
//    }
    
    if (self.arrMedicalItems.count > 0)
    {
        self.lblMessage.alpha = 0.0f;
    }
    else
    {
        [self createErrorMessage:@"You do not have any medical items added."];
    }
    
    
    //[self.tableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
    [self.tableView reloadData];

//    NSString* txt = @"Type in your medical information.";
//    //
//    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
//    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:20]];
//    [attrStr setTextColor:[UIColor purinaDarkGrey]];
//    [attrStr setTextAlignment:kCTTextAlignmentLeft lineBreakMode:kCTLineBreakByWordWrapping];
//    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"medical"]];
//
//    //self.lblDesc.attributedText = attrStr;
    
}

- (void)updateDone
{
    NSLog(@"update done add medical item");
    [self.arrMedicalItems removeAllObjects];
    [self createData];
}

- (void)saveMedicalData:(MedicalData *)medical isUpdating:(BOOL)updating
{
    NSLog(@"save new medical data");
//    PetData *objPetData = [[PetData alloc] init];
//    MedicalData *objMedical = medical;
//    //NSString *numID = self.objCurrentPetData.guid;
//
//    objPetData = [self.petModel saveMedicalItem:objMedical withPet:self.objCurrentPetData];
//    self.objCurrentPetData = nil;
//    self.objCurrentPetData = objPetData;

    [self.arrMedicalItems removeAllObjects];
    [self createData];
    //[self.tableView reloadData];
}

- (void)updatePetData:(PetData *)pet
{

    NSLog(self.isUpdating ? @"Yes" : @"No");

    self.objCurrentPetData = nil;
    self.objCurrentPetData = pet;
    [self.arrMedicalItems removeAllObjects];
    [self createData];

//    if (!self.isUpdating)
//    {
//
//    }
//    else
//    {
//        NSLog(@"count %i", pet.medicalItems.count);
//        [self.arrMedicalItems removeAllObjects];
//        [self createData];
//    }
    NSLog(@"update info pls");
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



- (void)setFonts
{
}

- (void) createMessage:(NSString *)message withRange:(NSString *)range
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:32]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:range]];
    
    //self.lblTitle.attributedText = attrStr;
}

- (void)onSaveTapped:(id)sender
{
//    if (!self.isUpdating) self.objMedicalData.guid = [UniqueID getUUID];
//    
//    self.objMedicalData.type = self.type;
//    
//    
//    if ([self.contentType isEqualToString:kTypeDatePicker])
//    {
//        self.objMedicalData.name = self.tfName.text;
//        self.objMedicalData.date = self.selectedDate;
//    }
//    else if ([self.contentType isEqualToString:kTypeDosagePicker])
//    {
//        self.objMedicalData.name = self.tfName.text;
//        self.objMedicalData.dosage = self.tfSecondItem.text;
//    }
//    else if ([self.contentType isEqualToString:kTypeSingleItem])
//    {
//        self.objMedicalData.name = self.tfName.text;
//    }
//    else if ([self.contentType isEqualToString:kTypeTextView])
//    {
//        NSDate *today = [NSDate date];
//        self.objMedicalData.date = [NSDate formatDate:today formatType:@"MMMM dd, yyyy"];
//        self.objMedicalData.data = self.txtMedical.text;
//    }
//    
//    NSLog(@"name %@", self.tfName.text);
//    NSLog(@"data %@", self.txtMedical.text);
//    NSLog(@"second %@", self.tfSecondItem.text);
//    
//    [self saveMedicalItem];
}


- (void) saveMedicalItem
{
    
//    PetData *objPetData = [[PetData alloc] init];
//    MedicalData *objMedical = self.objMedicalData;
//    NSString *numID = self.objCurrentPetData.guid;
//    
//    
//    if (self.isUpdating)
//    {
//        [self.petModel updateMedicalItem:objMedical];
//        objPetData = [self.petModel getPetByID:self.objCurrentPetData];
//        NSLog(@"is updating");
//    }
//    else
//    {
//        NSLog(@"is not updating");
//        objPetData = [self.petModel saveMedicalItem:objMedical withPet:self.objCurrentPetData];
//    }
//    
//    
//    self.objCurrentPetData = nil;
//    self.objCurrentPetData = objPetData;
//    
//    
//    
//    [self.arrMedicalItems removeAllObjects];
//    [self createData];
//    [self clear];
//    [self.tableView reloadData];
    
    
    NSLog(@"there are %i medical items! add med item", [self.objCurrentPetData.medicalItems count]);
}


- (void)createContentType
{
    if ([self.contentType isEqualToString:kTypeDatePicker])
    {
    }
    else if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
    }
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";
    
    AddMedicalItemCell *cell = (AddMedicalItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"AddMedicalItemCell" owner:self options:nil];
    MedicalData *objMedicalData = [self.arrMedicalItems objectAtIndex:[indexPath row]];
    
    
    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    NSLog(@"create item");

    cell.delegate = self;
    //[cell initWithData:objMedicalData];
    //cell.delegate = self;
    //cell.objMedicalData = objMedicalData;
    
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

    cell.objMedicalData = objMedicalData;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{





    MedicalData *medicalData = [self.arrMedicalItems objectAtIndex:[indexPath row]];






    CreateMedialItemViewController_iPhone*createMedialItemView = [[CreateMedialItemViewController_iPhone alloc] initWithNibName:@"CreateMedialItemViewController_iPhone" bundle:nil];
    createMedialItemView.objCurrentPetData = self.objCurrentPetData;
    createMedialItemView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createMedialItemView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    [self presentModalViewController:navController animated:YES];
    createMedialItemView.isUpdating = YES;
    createMedialItemView.objMedicalData = medicalData;
    [createMedialItemView initializeWithType:self.type withContentType:self.contentType andWithData:self.data];

    NSString *message;

    if ([self.type isEqualToString:kMedicalTypeMedCondition])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Medical Condition"];
        [createMedialItemView createMessage:message withRange:@"Medical Condition"];
    }
    else if ([self.type isEqualToString:kMedicalTypeSurgery])
    {
        message = [NSString stringWithFormat:@"Add a %@", @"Surgery"];
        [createMedialItemView createMessage:message withRange:@"Surgery"];
    }
    else if ([self.type isEqualToString:kMedicalTypeAllergy])
    {
        message = [NSString stringWithFormat:@"Add an %@", @"Allergy"];
        [createMedialItemView createMessage:message withRange:@"Allergy"];
    }
    else if ([self.type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Special Needs"];
        [createMedialItemView createMessage:message withRange:@"Special Needs"];
    }
    else if ([self.type isEqualToString:kMedicalTypeMedication])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Medication"];
        [createMedialItemView createMessage:message withRange:@"Medication"];
    }
    else if ([self.type isEqualToString:kMedicalTypeInsurance])
    {
        message = [NSString stringWithFormat:@"Add %@", @"Insurance Info"];
        [createMedialItemView createMessage:message withRange:@"Insurance Info"];
    }
    else
    {
        message = [NSString stringWithFormat:@"Add a %@", self.type];
        [createMedialItemView createMessage:message withRange:self.type];
    }


    self.contentType = self.contentType;
//    
//    [self clear];
//    
//    if ([self.contentType isEqualToString:kTypeDatePicker])
//    {
//        self.tfName.text = medicalData.name;
//        self.tfSecondItem.text = medicalData.date;
//    }
//    else if ([self.contentType isEqualToString:kTypeDosagePicker])
//    {
//        self.tfName.text = medicalData.name;
//        self.tfSecondItem.text = medicalData.dosage;
//    }
//    else if ([self.contentType isEqualToString:kTypeSingleItem])
//    {
//        self.tfName.text = medicalData.name;
//    }
//    else if ([self.contentType isEqualToString:kTypeTextView])
//    {
//        self.txtMedical.text = medicalData.data;
//    }
//    
//    self.objMedicalData = medicalData;
//    self.objMedicalData.type = self.type;
//    self.isUpdating = YES;
    self.isUpdating = YES;
    
}



- (void)deleteItem:(MedicalData *)data
{

    NSString * type;

    if ([data.type isEqualToString:kMedicalTypeVaccination]) type = @"vaccination";
    if ([data.type isEqualToString:kMedicalTypeNotes]) type = @"notes";
    if ([data.type isEqualToString:kMedicalTypeDiet]) type = @"diet information";
    if ([data.type isEqualToString:kMedicalTypeAllergy]) type = @"allergy information";
    if ([data.type isEqualToString:kMedicalTypeMedCondition]) type = @"medical condition";
    if ([data.type isEqualToString:kMedicalTypeSpecialNeeds]) type = @"special needs";
    if ([data.type isEqualToString:kMedicalTypeInsurance]) type = @"insurance information";
    if ([data.type isEqualToString:kMedicalTypeMedication]) type = @"medication";
    if ([data.type isEqualToString:kMedicalTypeSurgery]) type = @"surgery information";

    NSString *message = [NSString stringWithFormat:@"Are you sure you wish to delete this %@?", type];
    NSString *title = [NSString stringWithFormat:@"Delete %@", type];

    BlockAlertView *alert = [BlockAlertView alertWithTitle:title message:message];

    [alert setCancelButtonWithTitle:@"Cancel" block:nil];

    [alert setDestructiveButtonWithTitle:@"Delete!" block:^{
        [self.arrMedicalItems removeAllObjects];
        NSLog(@"count before %i", self.objCurrentPetData.medicalItems.count);
        [self.petModel deleteMedicalItem:data];
        PetData *petData = [self.petModel updatePet:self.objCurrentPetData];

        NSLog(@"count after %i", petData.medicalItems.count);
        self.objCurrentPetData = nil;
        self.objCurrentPetData = petData;


        NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", self.type];
        NSMutableArray *medicalItems = [[NSMutableArray alloc] initWithArray:[self.objCurrentPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate]];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];

        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSMutableArray* arrMedicalData = [[NSMutableArray alloc] initWithArray:[medicalItems sortedArrayUsingDescriptors:sortDescriptors]];


        self.arrMedicalItems = arrMedicalData;
        [self.tableView reloadData];
    }];

    [alert show];
}


- (IBAction)showActionSheet:(id)sender
{

}

- (IBAction)showAlertPlusActionSheet:(id)sender
{

}


- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblMessage:nil];
    [super viewDidUnload];
}


@end
