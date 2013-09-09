//
//  PetTipsDetailViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/12/12.
//
//

#import "PetTipsDetailViewController.h"
#import "TipData.h"
#import "PetTipsScrollerView.h"
#import "TipCategoriesViewController.h"
#import "PetTipData.h"
#import "PetTipScrollerData.h"
#import "UIImageView+JMImageCache.h"

@interface PetTipsDetailViewController ()

@end

@implementation PetTipsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        self.position = 0;
    }
    return self;
}

- (void)initialize:(PetTipData *)data
{
    NSLog(@"%@", data.filteredArray);
    self.categoryArray = [[NSMutableArray alloc] initWithArray:data.categoryArray];
    self.objPetTipData = data;
    self.position = data.position;
    if ([data.filteredArray count] == 0)
    {
        self.tips = [[NSMutableArray alloc] initWithArray:data.fullArray];
    }
    else self.tips = [[NSMutableArray alloc] initWithArray:data.filteredArray];
    self.selectedCategory = data.selectedCategory;
    if ([self.type isEqualToString:@"dog"]) self.arrDogCategories = [[NSMutableArray alloc] initWithArray:data.tipCategoriesArray];
    else self.arrCatCategories = [[NSMutableArray alloc] initWithArray:data.tipCategoriesArray];



    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", self.selectedCategory];
    //NSArray *selectedArray = [self.tips filteredArrayUsingPredicate:predicate];

    //self.lblTitle.text = strData.selectedCategory;
    //NSLog(@"%@", [strData html]);

    [self createScroller:self.type];
    [self createHTML];
    [self setCardImage];
    
}

- (void)setCardImage
{
    NSString *path = [NSString stringWithFormat:@"%@.png", [[self.tips objectAtIndex:self.position] html]];
    NSString* imgPath = [NSString stringWithFormat:@"http://static.clients.triadcontent.com/Purina/00_NES_42646_PetHealthUD/iPad/Images/%@", path];
    [self.img setImageWithURL:[NSURL URLWithString:imgPath] placeholder:[UIImage imageNamed:@"tipDefault.png"]];
}

- (void)createScroller:(NSString *)type
{
    PetTipScrollerData *objData = [[PetTipScrollerData alloc] init];
    objData.categoryArray = self.categoryArray;
    objData.fullArray = self.tips;
    objData.selectedPosition = self.position;
    objData.title = type;
    objData.isSelectedPositionUSed = YES;

    self.petScroller = [[PetTipsScrollerView alloc] initWithData:objData];
    self.petScroller.selectedIndex = self.position;

    self.petScroller.lblCategory.text = self.objPetTipData.selectedCategory;
    self.petScroller.delegate = self;
    self.petScroller.numYTitleOffset = 20;
    self.petScroller.numYCatOffset = 15;
    [self.petScroller setTitle];
    //self.petScroller.delegate = self;
    self.petScroller.imgArrow.alpha = 0.0f;
    self.petScroller.btnCategory.alpha = 0.0f;
    self.petScroller.frame = CGRectMake(0, 347, 1024, 326);
    [self.view addSubview:self.petScroller];
}

- (void) createHTML
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];

    self.filePath = [[NSBundle mainBundle] pathForResource:[[self.tips objectAtIndex:self.position] html] ofType:@"html"];
    self.htmlString = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];

    [(UIScrollView*)[self.webView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:YES];
    //[self.webView.scrollView setShowsVerticalScrollIndicator:YES];
    [self.webView loadHTMLString:self.htmlString baseURL:baseURL];
}

- (void)viewTipDetails:(int)pos withCategory:(NSString *)category withType:(NSString *)type andTipData:(TipData *)data
{
    self.position = pos;
    [self createHTML];
    NSString *path = [NSString stringWithFormat:@"%@.png", [[self.tips objectAtIndex:self.position] html]];
    self.img.image = [UIImage imageNamed:path];
}

- (void)showCategoryModal:(NSString *)type
{
    CGRect buttonFrame;
    buttonFrame.origin.x = 961;
    buttonFrame.origin.y = 375;
    buttonFrame.size.height = 20;
    buttonFrame.size.width = 20;

    self.tipCatView = [TipCategoriesViewController new];
    self.tipCatView.strSelectedCategory = @"All";
    if ([type isEqualToString:@"dog"]) self.tipCatView.arrCategories = self.arrDogCategories;
    else  self.tipCatView.arrCategories = self.arrCatCategories;

    NSString *firstCat = [self.tipCatView.arrCategories objectAtIndex:0];
    if (![firstCat isEqualToString:@"All"]) [self.tipCatView.arrCategories insertObject:@"All" atIndex:0];
    //self.tipCatView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.tipCatView];
    self.tipCatView.contentSizeForViewInPopover = CGSizeMake(320, 380);
    popover = [[UIPopoverController alloc] initWithContentViewController:navController ];
    //popover.popoverBackgroundViewClass
    [popover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (void)addItemViewController:(TipCategoriesViewController *)controller didFinishEnteringItem:(NSString *)item andID:(int)numID
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLblTitle:nil];
    [self setTxtCopy:nil];
    [self setImg:nil];
    [super viewDidUnload];
}
@end
