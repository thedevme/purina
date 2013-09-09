//
//  MedicalItemsView_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "MedicalItemsView_iPad.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "PetData.h"
#import "MedicalData.h"
#import "MedicalItemSmallCell.h"
#import "PetModel.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"

@implementation MedicalItemsView_iPad

- (id)init
{
    self = [super init];
    if (self)
    {
        [self createTable];

        self.medicalItems = [[NSMutableArray alloc] init];
        self.petModel = [[PetModel alloc] init];
        self.objMedicalData = [[MedicalData alloc] init];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(onCloseTapped:)
         forControlEvents:UIControlEventTouchDown];
        [button setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(5, -10, 51.0, 31.0);
        [self addSubview:button];
    }
    return self;
}

- (void)onCloseTapped:(id)sender
{
    [self.delegate close];
}

- (void)createTable
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 360, 370)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
}

- (void)initializeWithPetData:(PetData *)pet withContentType:(NSString *)contentType withType:(NSString *)type andData:(NSString *)data
{
    self.objPetData = pet;


    self.type = type;
    self.data = data;
    self.contentType = contentType;

    //[self createMedicalMenuData];
    [self createData];
    [self.tableView reloadData];
}


- (void)createData
{
    NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", self.type];
    NSArray *arrMedicalItems = [self.objPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate];

    //if (self.medicalItems.count > 0) [self.medicalItems removeAllObjects];
    self.medicalItems.array = arrMedicalItems;

    NSLog(@"create data count %i", self.medicalItems.count);
    for (int i = 0; i < self.medicalItems.count; i++)
    {
        MedicalData *objData = [self.medicalItems objectAtIndex:i];
        NSLog(@"med name: %@", [objData name]);
        NSLog(@"dosage name: %@", [objData dosage]);
        NSLog(@"data: %@", [objData data]);
    }

    if (self.medicalItems.count > 0)
    {
        //self.lblMessage.alpha = 0.0f;
    }
    else
    {
        //[self createErrorMessage:@"You do not have any medical items added."];
    }


    [self.tableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
}




//TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"amount %i", [self.medicalItems count]);
    return [self.medicalItems count];
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

    MedicalItemSmallCell *cell = (MedicalItemSmallCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalItemSmallCell" owner:self options:nil];
    MedicalData *objMedicalData = [self.medicalItems objectAtIndex:[indexPath row]];
    NSLog(@"create");
    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

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
        NSLog(@"%@", objMedicalData.dosage);
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

@end
