//
//  MyPetsViewController.h
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "MyPetCell.h"
#import "Pet.h"
#import "Flurry.h"
#import "AddPetViewController.h"
#import "AddPetViewController_iPhone5.h"
#import "PetDetailsViewController_iPhone5.h"

@class PetModel;


@interface MyPetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PetDetailsDelegate, PetDetailsDelegate_iPhone5, AddPetDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, retain) NSMutableArray* pets;
@property (nonatomic, retain) PetModel *petModel;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblMessage;

- (IBAction)onAddTapped:(id)sender;
@end
