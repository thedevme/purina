//
//  ApptTypeViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/5/13.
//
//

#import <UIKit/UIKit.h>

@protocol ApptTypeDelegate <NSObject>

- (void)selectedType:(NSString *)type;

@end

@interface ApptTypeViewController : UITableViewController


@property (nonatomic, retain) NSMutableArray* arrCategories;
@property (nonatomic, retain) NSString* strSelectedType;
@property (nonatomic, weak) id <ApptTypeDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSelectedCat:(NSString *)category;

@end
