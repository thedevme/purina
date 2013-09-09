//
//  BlogViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "TipCell.h"
#import "BlogData.h"
#import "Constants.h"
#import "TSMiniWebBrowser.h"
#import "UIColor+PetHealth.h"
#import "NSString+HTML.h"

@interface BlogViewController_iPad : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray* arrBlogData;
@property (nonatomic, retain) TSMiniWebBrowser *webBrowser;

@end
