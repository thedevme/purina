//
//  CreateMedicalItemViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import "CreateMedicalItemViewController.h"
#import "CreateDatePickerDataSource.h"
#import "Constants.h"
#import "AppointmentData.h"
#import "CreateDosagePickerDataSource.h"
#import "MedicalData.h"
#import "CreateSingleItemDataSource.h"

@interface CreateMedicalItemViewController ()

@end

@implementation CreateMedicalItemViewController

- (void) loadView
{
    self.objMedicalData = [[MedicalData alloc] init];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 400)];

    UITableView *formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 400) style:UITableViewStyleGrouped];
    UIImageView* background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-586h.png"]];
    [view addSubview:background];
    formTableView.backgroundView = nil;



    UIImageView* formHeaderBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"petHeaderBG.png"]];
    formHeaderBG.frame = CGRectMake(0, 0, 320, 60);
    [self setTableView:formTableView];
    [view addSubview:formHeaderBG];
    [view addSubview:formTableView];
    [self setView:view];
    [self createNavigationButtons];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    self.btnSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [self.btnSave setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:self.btnSave];
}



- (void) onCancelTapped:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
    //NSLog(@"cancel tapped");
}

- (void)onSaveTapped:(id)sender
{
    NSLog(@"content type - view did load %@", self.contentType);
    NSLog(@"type - view did load %@", self.type);


    if ([self.type isEqualToString:kMedicalTypeMedication])
    {
       if(self.objMedicalData.dosage.length != 0 && self.objMedicalData.name.length != 0)
       {
           //NSLog(@"save medication");
           [[NSNotificationCenter defaultCenter] postNotificationName:kSaveMedicalItem object:self.objMedicalData];
       }
    }

    if ([self.type isEqualToString:kMedicalTypeSurgery] || [self.type isEqualToString:kMedicalTypeVaccination])
    {
        if(self.objMedicalData.date.length != 0 && self.objMedicalData.name.length != 0)
        {
            NSLog(@"save date item");
            [[NSNotificationCenter defaultCenter] postNotificationName:kSaveMedicalItem object:self.objMedicalData];
        }
    }

    if ([self.type isEqualToString:kMedicalTypeAllergy] || [self.type isEqualToString:kMedicalTypeMedCondition] || [self.type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        if(self.objMedicalData.name.length != 0)
        {
            //NSLog(@"save medication");
            [[NSNotificationCenter defaultCenter] postNotificationName:kSaveMedicalItem object:self.objMedicalData];
        }
    }

    if ([self.type isEqualToString:kMedicalTypeDiet] || [self.type isEqualToString:kMedicalTypeNotes] || [self.type isEqualToString:kMedicalTypeInsurance])
    {
        if (self.txtMedical.text.length != 0)
        {
            NSLog(@"txt %@", self.txtMedical.text);
            self.objMedicalData.type = self.type;
            NSLog(@"type %@ - objMedtype %@", self.type, self.objMedicalData.type);

            self.objMedicalData.data = self.txtMedical.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSaveMedicalItem object:self.objMedicalData];
        }
    }
}


- (void)saveMedialDosage:(MedicalData *)data
{
    self.objMedicalData = data;
    self.objMedicalData.type = self.type;
}

- (void)saveMedialData:(MedicalData *)data
{
    self.objMedicalData = data;
    self.objMedicalData.type = self.type;
}

- (void) updateApptDetails:(AppointmentData *)data
{
    //_objAppointmentData = strData;
}

- (void)viewDidLoad
{
    NSLog(@"content type - view did load %@", self.contentType);
    NSLog(@"type - view did load %@", self.type);

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) [self checkTypePhone];
    else  [self checkTypePad];

    [super viewDidLoad];
}

- (void) checkTypePhone
{
    if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.dosageDataSource = [[CreateDosagePickerDataSource alloc] initWithModel:aDictionary];
        self.dosageDataSource.delegate = self;
        [self setFormDataSource:self.dosageDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.datePickerDataSource = [[CreateDatePickerDataSource alloc] initWithModel:aDictionary];
        self.datePickerDataSource.delegate = self;


        [self setFormDataSource:self.datePickerDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.singleItemDataSource = [[CreateSingleItemDataSource alloc] initWithModel:aDictionary];
        self.singleItemDataSource.delegate = self;


        [self setFormDataSource:self.singleItemDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        //NSLog(@"textview");


        self.txtMedical = [[UITextView alloc] init];
        self.txtMedical.frame = CGRectMake(0, 0, 320, 250);
        self.txtMedical.text = self.data;
        [self.view addSubview:self.txtMedical];


    }
}

- (void)checkTypePad
{
    if ([self.contentType isEqualToString:kTypeDosagePicker])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.dosageDataSource = [[CreateDosagePickerDataSource alloc] initWithModel:aDictionary];
        self.dosageDataSource.delegate = self;
        [self setFormDataSource:self.dosageDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeDatePicker])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.datePickerDataSource = [[CreateDatePickerDataSource alloc] initWithModel:aDictionary];
        self.datePickerDataSource.delegate = self;


        [self setFormDataSource:self.datePickerDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeSingleItem])
    {
        NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
        self.singleItemDataSource = [[CreateSingleItemDataSource alloc] initWithModel:aDictionary];
        self.singleItemDataSource.delegate = self;


        [self setFormDataSource:self.singleItemDataSource];
    }
    else if ([self.contentType isEqualToString:kTypeTextView])
    {
        //NSLog(@"textview");


        self.txtMedical = [[UITextView alloc] init];
        self.txtMedical.frame = CGRectMake(0, 0, 320, 250);
        self.txtMedical.text = self.data;
        [self.view addSubview:self.txtMedical];


    }

}

- (void) willDisplayCell:(IBAFormFieldCell *)cell forFormField:(IBAFormField *)formField atIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    NSInteger sectionRows = [tableView_ numberOfRowsInSection:[indexPath section]];
    NSInteger row = [indexPath row];

    //NSLog(@"form field %@", formField);

    if (row == 0 && row == sectionRows - 1)
    {
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnSingleListItem.png"]];
        [cell setBackgroundView:background];
    }
    else if (row == 0)
    {
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellTop.png"]];
        [cell setBackgroundView:background];
    }
    else if (row == sectionRows - 1)
    {
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBottom.png"]];
        [cell setBackgroundView:background];
    }
    else
    {
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellMiddle.png"]];
        [cell setBackgroundView:background];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
