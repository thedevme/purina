//
//  MedicalView_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "MedicalView_iPad.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "MedicalCategoryCell.h"
#import "PetData.h"

@implementation MedicalView_iPad

- (id)initWithPetData:(PetData *)pet
{
    self = [super init];
    if (self)
    {
        //NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalView_iPad" owner:self options:nil];
        //self = [nib objectAtIndex:0];
        self.objPetData = pet;

        [self createTable];
        [self initialize];
        // Initialization code
    }
    return self;
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

- (void)initialize
{
    [self createMedicalMenuData];
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

    MedicalCategoryCell *cell = (MedicalCategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalCategoryCell" owner:self options:nil];

    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.lblName.text = [self.sections objectAtIndex:[indexPath row]];
    cell.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:18.0f];
    cell.lblName.textColor = [UIColor purinaDarkGrey];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [self.sections objectAtIndex:[indexPath row]]);
    [self.delegate viewSelectedCategory:[self.sections objectAtIndex:[indexPath row]]];
}

- (void)resetMedical:(PetData *)data
{
    self.objPetData = data;


}
@end
