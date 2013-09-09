//
//  TipViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "TipData.h"

@interface TipViewController_iPhone5 : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *htmlString;
@property (nonatomic, retain) NSArray* arrArticles;
@property (nonatomic, retain) TipData* objTipData;
@property (nonatomic, assign) int current;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentCount;

- (IBAction)onNextTapped:(id)sender;
- (IBAction)onPreviousTapped:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withData:(NSArray *)articles selectedTip:(int)selected;
@end
