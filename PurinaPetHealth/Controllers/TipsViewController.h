//
//  TipsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/26/12.
//
//

#import <UIKit/UIKit.h>
#import "TipCell.h"
#import "TipData.h"
#import "TipViewController.h"
#import "TipViewController_iPhone5.h"
#import "TipCategoriesViewController.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "OHAttributedLabel.h"
#import "THMultiPartLabel.h"
#import "OHASBasicMarkupParser.h"

@interface TipsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TipCategoryDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray* tips;
@property (nonatomic, retain) NSMutableArray* arrCategories;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, retain) NSMutableArray* arrAllTips;
@property (nonatomic, retain) TipCategoriesViewController* categoriesView;
@property (assign) int numSection;

@property (nonatomic, retain) NSString* strSelectedCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTipsType:(NSString *)tipsType;




//objTipData = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//
//NSString* test = [self truncateString:objTipData.title toLimit:60];
//
//NSString* strText = [NSString stringWithFormat:@"%@ \n%@", test, objTipData.desc];
//NSString* txt = strText;
//NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
//
//[attrStr setFont:[UIFont fontWithName:kHelveticaNeueMed size:16]];
//[attrStr setTextColor:[UIColor purinaDarkGrey]];
//[attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByCharWrapping];
//NSString* strDesc = objTipData.desc;
//[attrStr setFont:[UIFont fontWithName:kHelveticaNeue size:12.0f] range:[txt rangeOfString:strDesc]];
//cell.lblTip.attributedText = attrStr;

@end



