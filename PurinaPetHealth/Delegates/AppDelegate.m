//
//  AppDelegate.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PopOverViewController.h"
#import "BlogViewController_iPad.h"
//#import "TestFlight.h"
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

@synthesize tabBarController = _tabBarController;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self createCoreLocation];
    
    
//        NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames = [[NSArray alloc] initWithArray:
//                     [UIFont fontNamesForFamilyName:
//                      [familyNames objectAtIndex:indFamily]]];
//        for (indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
//        }
//
//    }

    
    
    [Flurry startSession:@"6MMJRP54PRDCJGR7PMNJ"];
    [Crashlytics startWithAPIKey:@"1442a328abedee9622e8ce125e20e92d399f1b08"];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self createNav];
    }
    else
    {
        [self createiPadBackground];
        [self createiPadNav];
    }
    
    //[TestFlight takeOff:@"Ie3757edfdbb12ae0bc48c4b3a136e118_MTQ3Mjk3MjAxMi0xMC0yNCAxMjo1NTozMy4xNTkwNTE"];
    
    return YES;
}


- (void) createCoreLocation
{
    self.clController = [[CoreLocationController alloc] init];
    self.clController.delegate = self;
    [self.clController.locationManager startUpdatingLocation];
}

- (void) createiPhoneBackground
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-586h@2x.png"]];
    backgroundImage.frame = CGRectMake(0, 0, 320, 568);
    
    [self.window addSubview:backgroundImage];
    
}

- (void) createiPadBackground
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipadBackground.png"]];
    backgroundImage.frame = CGRectMake(0, 0, 1024, 655);
    
    [self.window addSubview:backgroundImage];
}

- (void) createNav
{
    
    [self createiPhoneBackground];
    
    UINavigationController *homeNavigationController;
    UIViewController* homeViewController;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        homeViewController = [[HomeViewController_iPhone5 alloc] initWithNibName:@"HomeViewController_iPhone5" bundle:nil];
        homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    }
    else
    {
        homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    }
    
    [homeNavigationController setNavigationBarHidden:YES];
    
    UIViewController* blogViewController         = [[BlogViewController alloc] initWithNibName:@"BlogViewController" bundle:nil];
    UIViewController* emergencyViewController    = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController" bundle:nil];
    UIViewController* myPetsViewController       = [[MyPetsViewController alloc] initWithNibName:@"MyPetsViewController" bundle:nil];
    
    UINavigationController *blogNavigationController = [[UINavigationController alloc] initWithRootViewController:blogViewController];
    blogNavigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    UINavigationController *emergencyNavigationController = [[UINavigationController alloc] initWithRootViewController:emergencyViewController];
    emergencyNavigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    UINavigationController *myPetsNavigationController = [[UINavigationController alloc] initWithRootViewController:myPetsViewController];
    myPetsNavigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    UIImage *backButtonHomeImage = [[UIImage imageNamed:@"btnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHomeImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNavigationController, myPetsNavigationController, blogNavigationController, emergencyNavigationController, nil];
    self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;
    
    [[[self tabBarController] tabBar] setBackgroundImage:[UIImage imageNamed:@"tab-background"]];
    [[[self tabBarController] tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"tab-selected-background"]];
    
    [self.window makeKeyAndVisible];
}

- (void) createiPadNav
{
    UIViewController* homeViewController    = [[HomeViewController_iPad alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
    UIViewController* myPetsViewController  = [[MyPetsViewController_iPad alloc] initWithNibName:@"MyPetsViewController_iPad" bundle:nil];
    UIViewController* petTipsViewController = [[PetTipsViewController_iPad alloc] initWithNibName:@"PetTipsViewController_iPad" bundle:nil];
    UIViewController* findPetCare           = [[FindPetCareViewController_iPad alloc] initWithNibName:@"FindPetCareViewController_iPad" bundle:nil];
    UIViewController* blogViewController    = [[BlogViewController_iPad alloc] initWithNibName:@"BlogViewController_iPad" bundle:nil];
    UIViewController* appointmentsViewController    = [[AppointmentsViewController_iPad alloc] initWithNibName:@"AppointmentsViewController_iPad" bundle:nil];
    
    UIViewController* emergencyViewController    = [[EmergencyViewController_iPad alloc] initWithNibName:@"EmergencyViewController_iPad" bundle:nil];

    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [homeNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    [homeNavigationController setNavigationBarHidden:YES];
    
    UINavigationController *blogNavigationController = [[UINavigationController alloc] initWithRootViewController:blogViewController];
    [blogNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *findNavigationController = [[UINavigationController alloc] initWithRootViewController:findPetCare];
    [findNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];

    UINavigationController *myPetsNavigationController = [[UINavigationController alloc] initWithRootViewController:myPetsViewController];
    [myPetsNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *apptNavigationController = [[UINavigationController alloc] initWithRootViewController:appointmentsViewController];
    [apptNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *petTipsNavigationController = [[UINavigationController alloc] initWithRootViewController:petTipsViewController];
    [petTipsNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    UINavigationController *emergencyNavigationController = [[UINavigationController alloc] initWithRootViewController:emergencyViewController];
    [emergencyNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNavigationController, apptNavigationController, myPetsNavigationController, petTipsNavigationController, findNavigationController, blogNavigationController, emergencyNavigationController, nil];
    self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarBG.png"] forBarMetrics:UIBarMetricsDefault];
    UIImage *backButtonHomeImage = [[UIImage imageNamed:@"btnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHomeImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.window makeKeyAndVisible];
}



//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSInteger index = [[self tabBarController] selectedIndex];
//    
//    NSLog(@"%@", viewController);
//    
//    
//    if (index == 3)
//    {
//        CGRect buttonFrame;
//        buttonFrame.origin.x = 525;
//        buttonFrame.origin.y = 1;
//        buttonFrame.size.height = 320;
//        buttonFrame.size.width = 460;
//        EmergencyViewController *popoverView = [EmergencyViewController new];
//        popoverView.contentSizeForViewInPopover = CGSizeMake(320, 460);
//        popover = [[UIPopoverController alloc]initWithContentViewController:popoverView];
//        
//        [popover presentPopoverFromRect:buttonFrame inView:self.tabBarController.tabBar permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user strData, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save strData if appropriate. See also applicationDidEnterBackground:.
}


@end
