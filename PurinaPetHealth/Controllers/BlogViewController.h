//
//  BlogViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/16/12.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "TipCell.h"
#import "Constants.h"
#import "TSMiniWebBrowser.h"
#import "UIColor+PetHealth.h"
#import "NSString+HTML.h"
//#import "Flurry.h"


@interface BlogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray* arrBlogData;

@end
