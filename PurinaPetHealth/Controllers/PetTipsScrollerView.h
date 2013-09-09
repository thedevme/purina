//
//  PetTipsScrollerView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/11/12.
//
//

#import <UIKit/UIKit.h>
#import "EasyTableView.h"
#import "ImageStore.h"

@class DDPageControl;
@class OHAttributedLabel;
@class TipData;
@class TipCategoriesViewController;
@class PetTipScrollerData;
@class PetTipsScrollerView;

@protocol PetTipsScrollerDelegate <NSObject>

- (void)viewTipDetails:(int)pos withCategory:(NSString *)category withType:(NSString *)type andTipData:(TipData *)data;
- (void) showCategoryModal:(NSString *)type;
- (void)flipsideViewControllerDidFinish:(PetTipsScrollerView *)controller;

@end


@interface PetTipsScrollerView : UIView <UIScrollViewDelegate, EasyTableViewDelegate, ImageStoreDelegate>

@property (nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic) ImageStore *imageStore;
@property (nonatomic) EasyTableView *easyTableView;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDPageControl* pageControls;
@property (nonatomic, strong) PetTipScrollerData* objScrollerData;
@property (nonatomic, strong) NSMutableArray *arrTips;
@property (nonatomic, strong) NSMutableArray *arrCards;
@property (nonatomic, strong) NSMutableArray *arrCatgeoryTip;
@property (nonatomic, strong) TipCategoriesViewController *tipCatView;

@property (nonatomic, retain) id <PetTipsScrollerDelegate> delegate;

@property (nonatomic, copy) NSString *strCategory;
@property (nonatomic, copy) NSString *strTitle;

@property (assign) int numWidth;
@property (assign) int numHeight;
@property (assign) int numCurrentPage;
@property (assign) int selectedIndex;

@property (assign) NSInteger numYTitleOffset;
@property (assign) NSInteger numYCatOffset;

@property (assign) BOOL pageControlBeingUsed;

@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblTitle;

@property(nonatomic) BOOL isDragging;

@property(nonatomic) BOOL isDecliring;

- (id) initWithData:(PetTipScrollerData *)data;





- (IBAction)onLabelTapped:(id)sender;
- (void)setTitle;
- (void) reset:(NSMutableArray *)data withCategoryName:(NSString *)category;
@end
