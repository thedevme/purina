//
//  PetTipsDetailViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/12/12.
//
//

#import <UIKit/UIKit.h>
#import "PetTipsScrollerView.h"

@class TipData;
@class TipCategoriesViewController;
@class PetTipData;


@interface PetTipsDetailViewController : UIViewController <PetTipsScrollerDelegate, UIPopoverControllerDelegate>
{
    UIPopoverController *popover;
}


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *htmlString;
@property(nonatomic, strong) NSMutableArray *categoryArray;
@property(nonatomic, strong) NSMutableArray *tips;
@property(nonatomic, copy) NSString *selectedCategory;
@property (nonatomic, copy) NSString* type;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtCopy;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(nonatomic, strong) NSMutableArray *arrDogCategories;
@property(nonatomic, strong) NSMutableArray *arrCatCategories;
@property (nonatomic, retain) PetTipsScrollerView* petScroller;
@property (assign) NSInteger position;


@property(nonatomic, strong) TipCategoriesViewController *tipCatView;

@property(nonatomic) int numSection;

@property(nonatomic, strong) PetTipData *objPetTipData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)initialize:(PetTipData *)data;

@end
