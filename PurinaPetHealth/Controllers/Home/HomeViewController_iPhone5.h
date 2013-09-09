//
//  HomeViewController_iPhone5.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/29/12.
//
//

#import <UIKit/UIKit.h>
#import "AddPetViewController.h"
#import "MyPetsViewController.h"
#import "FindContactViewController.h"
#import "FindPetFunViewController.h"
#import "PetTipsViewController.h"
#import "AddPetViewController_iPhone5.h"
#import "ViewApptsViewController.h"
#import "BlogViewController.h"


@interface HomeViewController_iPhone5 : UIViewController

- (IBAction)onAddMyPetsTapped:(id)sender;
- (IBAction)onPetCareTapped:(id)sender;
- (IBAction)onPetTipsTapped:(id)sender;
- (IBAction)onFindPetFunTapped:(id)sender;
- (IBAction)onApptTapped:(id)sender;

- (IBAction)onMyPetsTapped:(id)sender;
- (IBAction)onBlogTapped:(id)sender;

@end
