//
//  ApptDetailsListViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import <UIKit/UIKit.h>
#import "AppointmentTypeData.h"

@class ApptDetailsListViewController;

@protocol ApptDetailsListDelegate <NSObject>
- (void)addItemViewController:(ApptDetailsListViewController *)controller didFinishEnteringItem:(AppointmentTypeData *)item;
@end

@interface ApptDetailsListViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray* arrListItems;
@property (nonatomic, weak) id <ApptDetailsListDelegate> delegate;
@property (nonatomic, retain) NSString* strSelectedItem;
@property (nonatomic, retain) NSString* strType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andListType:(NSString *)listType;
@end
