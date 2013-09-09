//
//  PetTipsScrollerView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/11/12.
//
//

#import "PetTipsScrollerView.h"
#import "DDPageControl.h"
#import "PetCardTipView.h"
#import "UIColor+PetHealth.h"
#import "OHAttributedLabel.h"
#import "OHASBasicMarkupParser.h"
#import "Constants.h"
#import "TipData.h"
#import "TipData.h"
#import "PetTipsDetailViewController.h"
#import "TipCategoriesViewController.h"
#import "PetTipScrollerData.h"

#define TXT_DOG "Dog "
#define TXT_CAT "Cat "
#define TXT_TIP "Tips"

#define TABLEVIEW_HEIGHT			140
#define TABLECELL_WIDTH				180

#define LABEL_TAG					100
#define IMAGE_TAG					101


@implementation PetTipsScrollerView

- (id) initWithData:(PetTipScrollerData *)data
{
    self = [super init];

    if (self)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PetTipsScrollerView" owner:self options:nil];
        self = [nib objectAtIndex:0];

        self.objScrollerData = data;
        self.strTitle = self.objScrollerData.title;
        self.selectedIndex = self.objScrollerData.selectedPosition;
        self.numWidth = 1024;
        self.numHeight = 250;
        self.arrCatgeoryTip = [[NSMutableArray alloc] initWithArray:self.objScrollerData.categoryArray];
        self.arrCards = [[NSMutableArray alloc]init];

        [self createArray:self.objScrollerData.fullArray];
        [self createControls];
        [self createScroller];

        [self setTitle];
    }
    return self;
}






- (void) createArray:(NSArray *)array
{
    self.arrTips = [[NSMutableArray alloc] initWithArray:array];
    //NSLog(@"%@", self.arrTips);
}

- (void)createScroller
{
    self.strCategory = @"All";
    self.lblCategory.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
    self.lblCategory.textColor = [UIColor purinaDarkGrey];
    self.pageControlBeingUsed = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 1024, 250)];
    self.scrollView.delegate = self;

    //self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //
    for (int i = 0; i < [self.arrTips count]; i++)
    {
        CGFloat yOrigin = (i * 340) + 7;
        PetCardTipView* petCardTipView = [[PetCardTipView alloc] initWithData:[self.arrTips objectAtIndex:i]];
        petCardTipView.frame = CGRectMake(yOrigin, 0, 331, 199);

        if (self.objScrollerData.isSelectedPositionUSed)
        {
            if (self.selectedIndex == i) petCardTipView.isSelected = YES;
            else petCardTipView.isSelected = NO;
        }

        [petCardTipView setSelected];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTip:)];
        [petCardTipView addGestureRecognizer:tapGesture];
        petCardTipView.tag = i;
        [self.arrCards addObject:petCardTipView];
        [self.scrollView addSubview:petCardTipView];
    }

    self.scrollView.contentSize = CGSizeMake(1024 * ceil([self.arrTips count]/3), self.scrollView.frame.size.height);


    self.pageControls.currentPage = ceil(self.selectedIndex/3) + 1;


    //self.scrollView.backgroundColor = [UIColor redColor];
    [self addSubview:self.scrollView];
    
    NSLog(@"selected index %f", ceil(self.selectedIndex/3));
    [self.scrollView scrollRectToVisible:CGRectMake(1000*ceil(self.selectedIndex/3), 0, 1000, 250) animated:NO];

    self.pageControls.numberOfPages = ceil([self.arrTips count]/3) + 1;
    self.lblCategory.text = self.strCategory;
    //[self addSubview:self.pageControls];
}

- (void) createControls
{
    self.pageControls = [[DDPageControl alloc] init];
    [self.pageControls addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControls.frame = CGRectMake(self.numWidth/2, 280, self.numWidth, 30);
    [self.pageControls setOnColor: [UIColor redColor]] ;
    [self.pageControls setOffColor: [UIColor purinaLightGrey]] ;
    [self.pageControls setType: DDPageControlTypeOnFullOffFull] ;
    [self.pageControls setIndicatorDiameter: 10.0f];

    //[self addSubview:self.pageControls];
}

- (void) showTip:(UIGestureRecognizer *)sender
{
    [self reset];

    NSInteger selectedTip = [[sender view] tag];
    TipData *objTipData = [self.arrTips objectAtIndex:selectedTip];
    PetCardTipView* petCardTipView = [self.arrCards objectAtIndex:selectedTip];
    self.selectedIndex = selectedTip;
    petCardTipView.isSelected = YES;
    [petCardTipView setSelected];
    NSString *selectedCategory = [objTipData category];
    //NSLog(@"%@ %@", self.strTitle, [objTipData category]);

    //:selectedCategory andType:self.strTitle withTipData:
    [self.delegate viewTipDetails:selectedTip withCategory:selectedCategory withType:self.strTitle andTipData:objTipData];
}

- (void) reset
{
    for (int i = 0; i < [self.arrCards count]; i++)
    {
        PetCardTipView* petCardTipView = [self.arrCards objectAtIndex:i];
        petCardTipView.isSelected = NO;
        [petCardTipView setSelected];
    }
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.pageControlBeingUsed)
    {
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isDragging = FALSE;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.pageControlBeingUsed = NO;

}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControlBeingUsed = NO;
    self.pageControls.currentPage = self.scrollView.contentOffset.x / self.numWidth;
    self.numCurrentPage = self.scrollView.contentOffset.x / self.numWidth;
    self.pageControls.currentPage = self.numCurrentPage;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.isDecliring = NO;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.scrollView.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

//- (void) updatePage
//{
//    self.numWidth += self.numWidth;
//    self.scrollView.contentOffset = CGPointMake(self.numWidth, 0);
//}

- (IBAction) changePage:(id)sender
{
    CGRect frame;
    frame.origin.x = 1024 * self.pageControls.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];

    self.pageControlBeingUsed = YES;
}

- (void) reset:(NSMutableArray *)data withCategoryName:(NSString *)category
{
    NSArray *viewsToRemove = [self.scrollView subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];

    self.arrTips = data;
    [self createScroller];
    self.lblCategory.text = category;
}


- (IBAction)onLabelTapped:(id)sender
{
    [self.delegate showCategoryModal:self.strTitle];
}

- (void)setTitle
{
    if ([self.strTitle isEqualToString:@"dog"])
    {
        NSString* strDesc = [NSString stringWithFormat:@"%@%@", @ TXT_DOG, @ TXT_TIP];
        NSString* txt = strDesc;

        NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
        [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
        [attrStr setTextColor:[UIColor purinaRed]];
        [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
        [attrStr setTextColor:[UIColor purinaDarkGrey] range:[txt rangeOfString:@ TXT_TIP]];
        self.lblTitle.attributedText = attrStr;
        self.lblTitle.frame = CGRectMake(self.lblTitle.frame.origin.x, self.lblTitle.frame.origin.y + self.numYTitleOffset, 293, 42);
        //self.lblCategory.frame  = CGRectMake(self.lblCategory.frame.origin.x + 53 , self.lblCategory.frame.origin.y + self.numYCatOffset, 153, 21);
        //self.btnCategory.frame  = CGRectMake(self.btnCategory.frame.origin.x, self.btnCategory.frame.origin.y + self.numYCatOffset, 186, 21);
        //self.imgArrow.frame     = CGRectMake(self.imgArrow.frame.origin.x, self.imgArrow.frame.origin.y + self.numYCatOffset, 18, 12);
    }
    else
    {
        NSString* strDesc = [NSString stringWithFormat:@"%@%@", @ TXT_CAT, @ TXT_TIP];
        NSString* txt = strDesc;

        NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
        [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
        [attrStr setTextColor:[UIColor purinaRed]];
        [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
        [attrStr setTextColor:[UIColor purinaDarkGrey] range:[txt rangeOfString:@ TXT_TIP]];

        self.lblTitle.frame = CGRectMake(self.lblTitle.frame.origin.x, self.lblTitle.frame.origin.y + self.numYTitleOffset, 293, 42);
        //self.lblCategory.frame  = CGRectMake(self.lblCategory.frame.origin.x + 27, self.lblCategory.frame.origin.y + self.numYCatOffset, 153, 21);
        //self.btnCategory.frame  = CGRectMake(self.btnCategory.frame.origin.x, self.btnCategory.frame.origin.y + self.numYCatOffset, 186, 21);
        //self.imgArrow.frame     = CGRectMake(self.imgArrow.frame.origin.x, self.imgArrow.frame.origin.y + self.numYCatOffset, 18, 12);
        self.lblTitle.attributedText = attrStr;
    }
}
@end
