//
//  ApptsMenuViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/17/12.
//
//

#import <UIKit/UIKit.h>
#import "CreateApptsViewController.h"
#import "ViewApptsViewController.h"
#import "PurinaItemButton.h"
#import "ShowcaseModel.h"
#import "SampleFormDataSource.h"
#import "IBAFormDataSource.h"


@interface ApptsMenuViewController : UIViewController

- (IBAction)onViewApptsTapped:(id)sender;
- (IBAction)onCreateApptsTapped:(id)sender;

@end
