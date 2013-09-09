//
//  IdentificationViewController_iPhone5.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import "IdentificationViewController_iPhone5.h"

@interface IdentificationViewController_iPhone5 ()

@end

@implementation IdentificationViewController_iPhone5

- (void) loadView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 400)];
    
    UITableView *formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 400) style:UITableViewStyleGrouped];
    UIImageView* background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-586h@2x.png"]];
    [view addSubview:background];
    formTableView.backgroundView = nil;
    
    UIImageView* formHeaderBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"petHeaderBG.png"]];
    formHeaderBG.frame = CGRectMake(0, 0, 320, 60);
    
    [self setTableView:formTableView];
    [view addSubview:formHeaderBG];
    
    UILabel* lblPetName = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 300, 30)];
    lblPetName.font = [UIFont fontWithName:kHelveticaNeueBold size:20.0f];
    lblPetName.textColor = [UIColor purinaDarkGrey];
    lblPetName.textAlignment = UITextAlignmentCenter;
    lblPetName.backgroundColor = [UIColor clearColor];
    //lblPetName.text = self.;
    
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 300, 30)];
    lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:20.0f];
    lblTitle.textColor = [UIColor purinaRed];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = NSLocalizedString(@"Identification", nil);
    
    
    [view addSubview:lblTitle];
    [view addSubview:formTableView];
    [self setView:view];
    [self createNavigationButtons];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    UIBarButtonItem *btnSaveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIButtonTypeCustom target:self action:@selector(onSaveTapped:)];
    [btnSaveItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnSaveItem];
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
//    AppointmentUpdater* appointmentUpdater = [[AppointmentUpdater alloc] init];
//
//    if (_objAppointmentData.title != NULL || _objAppointmentData.type  != NULL)
//    {
//        [appointmentUpdater createAppointment:_objAppointmentData];
//        //[_delegate appointmentSaved];
//
//        [self.parentViewController dismissViewControllerAnimated:YES completion:^{
//            //NSLog(@"cancel tapped complete");
//        }];
//    }





}

- (void) updateIdentificationData
{
}

- (void)viewDidLoad
{
    NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
    _dataSource = [[IdentificationDataSource alloc] initWithModel:aDictionary];
    _dataSource.delegate = self;
    [self setFormDataSource:_dataSource];
    _objAppointmentData = [[AppointmentData alloc] init];
    
    [super viewDidLoad];
}

- (void) willDisplayCell:(IBAFormFieldCell *)cell forFormField:(IBAFormField *)formField atIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    NSInteger sectionRows = [tableView_ numberOfRowsInSection:[indexPath section]];
    NSInteger row = [indexPath row];
    
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
