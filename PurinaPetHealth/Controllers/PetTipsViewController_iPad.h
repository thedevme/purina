//
//  PetTipsViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//

#import <UIKit/UIKit.h>
#import "PetTipsScrollerView.h"
#import "TipCategoriesViewController.h"

@class TipCategoriesViewController;
@class PetTipData;

@interface PetTipsViewController_iPad : UIViewController <UITableViewDataSource, UIPopoverControllerDelegate, UITableViewDelegate, PetTipsScrollerDelegate, TipCategoryDelegate>
{
    UIPopoverController *popover;
}

@property (nonatomic, retain) NSMutableArray* tips;
@property (nonatomic, retain) NSMutableArray* arrCategories;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, retain) NSMutableArray* arrAllTips;

@property(nonatomic, strong) NSMutableArray *dogTips;
@property(nonatomic, strong) NSMutableArray *catTips;
@property(nonatomic, strong) NSMutableArray *arrAllDogTips;
@property(nonatomic, strong) NSMutableArray *arrAllCatTips;
@property(nonatomic, strong) NSMutableArray *dataCatArray;
@property(nonatomic, strong) NSMutableArray *dataDogArray;
@property(nonatomic, strong) NSMutableArray *arrDogCategories;
@property(nonatomic, strong) NSMutableArray *arrCatCategories;
@property(nonatomic, strong) TipCategoriesViewController *tipCatView;
@property (nonatomic, retain) PetTipsScrollerView* catScroller;
@property (nonatomic, retain) PetTipsScrollerView* dogScroller;


@property (nonatomic, retain) NSString*strSelectedCatCategory;
@property (assign) int numSection;

@property(nonatomic, strong) PetTipData *objData;
@property(nonatomic, copy) NSString *strSelectedDogCategory;
@end
