//
//  HomeViewController.m
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "ViewApptsViewController.h"


@interface HomeViewController ()
{
    int numInt;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Home";
        self.navigationItem.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"tabIcon_home.png"];
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    _lblTest.text = @"";
    numInt = 0;
}


- (void) viewWillAppear:(BOOL)animated
{
    //NSLog(@"view will appear");
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidUnload
{
    [self setLblTest:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onAddMyPetsTapped:(id)sender 
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddPetViewController_iPhone5* addPetsViewController = [[AddPetViewController_iPhone5 alloc] initWithNibName:@"AddPetViewController_iPhone5" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPetsViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_ADDAPET"];
    }
    else
    {
        AddPetViewController* addPetsViewController = [[AddPetViewController alloc] initWithNibName:@"AddPetViewController" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPetsViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_ADDAPET"];
    }
}

- (IBAction)onVetTapped:(id)sender
{
}

- (IBAction)onBlogTapped:(id)sender
{
    [self.tabBarController setSelectedIndex:2];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWBLOG"];
}

- (IBAction)onPetTipsTapped:(id)sender
{
    PetTipsViewController* petTipsView = [[PetTipsViewController alloc] initWithNibName:@"PetTipsViewController" bundle:nil];
    [self.navigationController pushViewController:petTipsView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWPETTIPS"];
}

- (IBAction)onGroomingTapped:(id)sender 
{
}

- (IBAction)onExerciseTapped:(id)sender 
{
    FindContactViewController* myDogParkView = [[FindContactViewController alloc] initWithNibName:@"FindContactViewController" bundle:nil withType:kDogPark showAdd:NO];
    [self.navigationController pushViewController:myDogParkView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWFINDPETFUN"];
}

- (IBAction)onFindPetFunTapped:(id)sender
{
    FindPetFunViewController* findPetFunView = [[FindPetFunViewController alloc] initWithNibName:@"FindPetFunViewController" bundle:nil];
    [self.navigationController pushViewController:findPetFunView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWFINDPETFUN"];
}

- (IBAction)onApptTapped:(id)sender
{
    ViewApptsViewController* viewApptsViewController = [[ViewApptsViewController alloc] initWithNibName:@"ViewApptsViewController" bundle:nil];
    [self.navigationController pushViewController:viewApptsViewController animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWAPPTS"];
}

- (IBAction)onMyPetsTapped:(id)sender
{
    [self.tabBarController setSelectedIndex:1];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWMYPETS"];
}

@end
