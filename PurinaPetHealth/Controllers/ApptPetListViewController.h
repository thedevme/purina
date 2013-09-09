//
//  ApptPetListViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/5/13.
//
//

#import <UIKit/UIKit.h>
#import "TipCategoryCell.h"

@class PetModel;


@protocol ApptPetListDelegate <NSObject>

- (void)selectedApptPets:(NSMutableArray *)pets;

@end

@interface ApptPetListViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray*arrPets;
@property (nonatomic, retain) NSMutableArray *arrSelectedPets;
@property (nonatomic, retain) NSString* strSelectedCategory;
@property (nonatomic, weak) id <ApptPetListDelegate> delegate;


@property(nonatomic, strong) PetModel *petModel;

@property(nonatomic, strong) NSMutableArray *petData;

@property(nonatomic, strong) NSMutableArray *petNames;

@property(nonatomic, strong) NSMutableArray *petIds;

@property(nonatomic, strong) NSMutableArray *selectedPets;

@property(nonatomic, strong) NSMutableDictionary *selectionStates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
