//
//  HomeViewController.h
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPetViewController.h"
#import "MyPetsViewController.h"
#import "FindContactViewController.h"
#import "FindPetFunViewController.h"
#import "PetTipsViewController.h"
#import "AddPetViewController_iPhone5.h"
#import "ApptsMenuViewController.h"


@interface HomeViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel *lblTest;


- (IBAction)onAddMyPetsTapped:(id)sender;
- (IBAction)onVetTapped:(id)sender;
- (IBAction)onPetTipsTapped:(id)sender;
- (IBAction)onExerciseTapped:(id)sender;
- (IBAction)onFindPetFunTapped:(id)sender;
- (IBAction)onApptTapped:(id)sender;
- (IBAction)onBlogTapped:(id)sender;

- (IBAction)onMyPetsTapped:(id)sender;

@end
