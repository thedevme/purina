//
//  MedicalViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import "MedicalViewController.h"
#import "Constants.h"
#import "CreateApptsViewController.h" 
#import "MedicalData.h"
#import "PetData.h"
#import "PetModel.h"
#import "UIColor+PetHealth.h"
#import "MedicalCellItem_iPhone.h"
#import "AddMedicalItemViewController.h"

#define HEIGHT 75


@interface MedicalViewController ()

@end

@implementation MedicalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Medical";
        self.objPetData = [[PetData alloc] init];
        self.petModel = [[PetModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");
    //self.objPetData = [self.petModel getPetByID:self.objPetData];

}

- (void)initialize
{
    [self createMedicalMenuData];
    [self setData];
    //[self createNavigationButtons];
    
    
    
    
    self.lblPetName.text = self.objPetData.name;
    self.lblPetName.font = [UIFont fontWithName:kHelveticaNeueBold size:20.0f];
    self.lblPetName.textColor = [UIColor purinaDarkGrey];
    self.lblPetName.textAlignment = UITextAlignmentCenter;
    NSLog(@"medical view controller pet data %@", self.objPetData);
}




- (void)setData
{
    [self.medicalTableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
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
    [self setMedicalTableView:nil];
    [self setLblPetName:nil];
    [super viewDidUnload];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSave setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSave];
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";
    
    MedicalCellItem_iPhone *cell = (MedicalCellItem_iPhone *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MedicalCellItem_iPhone" owner:self options:nil];
    
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
    NSString *type = [self.sections objectAtIndex:[indexPath row]];
    
    self.addMedicalItem = [[AddMedicalItemViewController alloc]
                           initWithNibName:@"AddMedicalItemViewController"
                           bundle:nil];
    [self.navigationController pushViewController:self.addMedicalItem animated:YES];

    self.addMedicalItem.objCurrentPetData = self.objPetData;
    [self.addMedicalItem initializeWithType:type withContentType:[self setContentType:type] andWithData:nil];
    //[self createMessage:type];
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
    
//    if ([type isEqualToString:kMedicalTypeMedCondition])
//    {
//        message = [NSString stringWithFormat:@"Add a %@", @"Medical Condition"];
//        [self.addMedicalInfo createMessage:message withRange:@"Medical Condition"];
//    }
//    else if ([type isEqualToString:kMedicalTypeSurgery])
//    {
//        message = [NSString stringWithFormat:@"Add a %@", @"Surgery"];
//        [self.addMedicalInfo createMessage:message withRange:@"Surgery"];
//    }
//    else if ([type isEqualToString:kMedicalTypeAllergy])
//    {
//        message = [NSString stringWithFormat:@"Add an %@", @"Allergy"];
//        [self.addMedicalInfo createMessage:message withRange:@"Allergy"];
//    }
//    else if ([type isEqualToString:kMedicalTypeSpecialNeeds])
//    {
//        message = [NSString stringWithFormat:@"Add %@", @"Special Needs"];
//        [self.addMedicalInfo createMessage:message withRange:@"Special Needs"];
//    }
//    else if ([type isEqualToString:kMedicalTypeMedication])
//    {
//        message = [NSString stringWithFormat:@"Add %@", @"Medication"];
//        [self.addMedicalInfo createMessage:message withRange:@"Medication"];
//    }
//    else if ([type isEqualToString:kMedicalTypeInsurance])
//    {
//        message = [NSString stringWithFormat:@"Add %@", @"Insurance Info"];
//        [self.addMedicalInfo createMessage:message withRange:@"Insurance Info"];
//    }
//    else if ([type isEqualToString:kMedicalTypeVaccination])
//    {
//        message = [NSString stringWithFormat:@"Add a %@", @"Vaccine"];
//        [self.addMedicalInfo createMessage:message withRange:@"Vaccine"];
//    }
//    else if ([type isEqualToString:kMedicalTypeDiet])
//    {
//        message = [NSString stringWithFormat:@"Add %@ Info", @"Diet"];
//        [self.addMedicalInfo createMessage:message withRange:@"Diet"];
//    }
//    else if ([type isEqualToString:kMedicalTypeNotes])
//    {
//        message = [NSString stringWithFormat:@"Add %@", @"Notes"];
//        [self.addMedicalInfo createMessage:message withRange:@"Notes"];
//    }
    
    return message;
}

@end
