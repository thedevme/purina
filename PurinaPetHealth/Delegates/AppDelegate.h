//
//  AppDelegate.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "HomeViewController_iPhone5.h"
#import "MyPetsViewController.h"
#import "SettingsViewController.h"
#import "EmergencyViewController.h"
#import "BlogViewController.h"

//iPad
#import "HomeViewController_iPad.h"
#import "MyPetsViewController_iPad.h"
#import "PetTipsViewController_iPad.h"
#import "FindPetCareViewController_iPad.h"
#import "AppointmentsViewController_iPad.h"
#import "EmergencyViewController_iPad.h"
#import "Flurry.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UITabBarDelegate> {
    UIPopoverController *popover;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property(nonatomic, strong) CoreLocationController *clController;

@end
