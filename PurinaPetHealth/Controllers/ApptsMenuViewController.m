//
//  ApptsMenuViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
//
//

#import "ApptsMenuViewController.h"


@class IBAFormDataSource;

@interface ApptsMenuViewController ()

@end

@implementation ApptsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDefaults];
    [self checkPhone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
     
- (void) setDefaults
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) checkPhone
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self createiPhone5Buttons];
    }
    else
    {
        [self createButtons];
    }
}

- (void) createButtons
{
    PurinaItemButton* btnCreateAppt = [[PurinaItemButton alloc] init:@"Create an Appointment"];
    [btnCreateAppt addTarget:self action:@selector(onCreateApptsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnCreateAppt.frame = CGRectMake(7, 218, 307, 51);
    [self.view addSubview:btnCreateAppt];
    
    PurinaItemButton* btnViewAppt = [[PurinaItemButton alloc] init:@"View Appointments"];
    [btnViewAppt addTarget:self action:@selector(onViewApptsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnViewAppt.frame = CGRectMake(7, 277, 307, 51);
    [self.view addSubview:btnViewAppt];
}

- (void) createiPhone5Buttons
{
    PurinaItemButton* btnCreateAppt = [[PurinaItemButton alloc] initWithLargeBtn:@"Create an Appointment"];
    [btnCreateAppt addTarget:self action:@selector(onCreateApptsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnCreateAppt.frame = CGRectMake(7, 241, 307, 65);
    [self.view addSubview:btnCreateAppt];
    
    PurinaItemButton* btnViewAppt = [[PurinaItemButton alloc] initWithLargeBtn:@"View Appointments"];
    [btnViewAppt addTarget:self action:@selector(onViewApptsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnViewAppt.frame = CGRectMake(7, 325, 307, 65);
    [self.view addSubview:btnViewAppt];
}


- (IBAction)onViewApptsTapped:(id)sender
{
    ViewApptsViewController* viewApptsView = [[ViewApptsViewController alloc] initWithNibName:@"ViewApptsViewController" bundle:nil];
    [self.navigationController pushViewController:viewApptsView animated:YES];
}

- (IBAction)onCreateApptsTapped:(id)sender
{
    CreateApptsViewController* createAppts = [[CreateApptsViewController alloc] init];
    [self.navigationController pushViewController:createAppts animated:YES];
}

@end
