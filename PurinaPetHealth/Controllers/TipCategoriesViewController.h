//
//  TipCategoriesViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/26/12.
//
//

#import <UIKit/UIKit.h>
#import "TipCategoryCell.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"

@class TipCategoriesViewController;

@protocol TipCategoryDelegate <NSObject>
- (void)addItemViewController:(TipCategoriesViewController *)controller didFinishEnteringItem:(NSString *)item andID:(int)numID;
@end

@interface TipCategoriesViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray* arrCategories;
@property (nonatomic, retain) NSString* strSelectedCategory;
@property (nonatomic, weak) id <TipCategoryDelegate> delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCategories:(NSArray *)categories withSelectedCat:(NSString *)category;

@end
