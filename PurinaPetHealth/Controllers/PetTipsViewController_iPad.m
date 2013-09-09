//
//  PetTipsViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//

#import "PetTipsViewController_iPad.h"
#import "PetTipsScrollerView.h"
#import "TipData.h"
#import "PetTipsDetailViewController.h"
#import "TipCategoriesViewController.h"
#import "PetTipData.h"
#import "PetTipScrollerData.h"

@interface PetTipsViewController_iPad ()

@end

@implementation PetTipsViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Pet Tips";
        self.navigationItem.title = @"Pet Tips";
        self.tabBarItem.image = [UIImage imageNamed:@"iconPetTips.png"];
        [self.navigationController setNavigationBarHidden:YES];
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading thepetview from its nib.
}

- (void)initialize
{
    [self createArrays];

    [self createTipData:@"dog"];
    [self createTipData:@"cat"];
    self.strSelectedCatCategory = @"All";
    self.strSelectedDogCategory = @"All";


}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) createArrays
{
    self.dogTips = [[NSMutableArray alloc] init];
    self.arrDogCategories = [[NSMutableArray alloc] init];
    self.dataDogArray = [[NSMutableArray alloc] init];
    self.arrAllDogTips = [[NSMutableArray alloc] init];

    self.catTips = [[NSMutableArray alloc] init];
    self.arrCatCategories = [[NSMutableArray alloc] init];
    self.dataCatArray = [[NSMutableArray alloc] init];
    self.arrAllCatTips = [[NSMutableArray alloc] init];
}

- (void) createTipData:(NSString *)type
{
    NSString *filePath;

    if ([type isEqualToString:@"dog"]) filePath = [[NSBundle mainBundle] pathForResource:@"dog-tips" ofType:@"json"];
    else filePath = [[NSBundle mainBundle] pathForResource:@"cat-tips" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];


    if ([type isEqualToString:@"dog"])
    {
        for (NSDictionary* petTips in [[json objectForKey:@"articles"] objectForKey:@"article"])
        {
            TipData* objTip = [[TipData alloc] init];
            objTip.title = [petTips valueForKey:@"title"];
            objTip.desc = [petTips valueForKey:@"desc"];
            objTip.category = [petTips valueForKey:@"category"];
            objTip.subCategory = [petTips valueForKey:@"sub_category"];
            objTip.species = [petTips valueForKey:@"species"];
            objTip.html = [petTips valueForKey:@"copy"];
            [self.dogTips addObject:objTip];
        }
        
        self.arrDogCategories = [[NSMutableArray alloc] initWithArray:[[NSSet setWithArray:[self.dogTips valueForKey:@"subCategory"]] allObjects]];
        
        for ( int j = 0; j < [self.arrDogCategories count]; j++)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subCategory == %@", [self.arrDogCategories objectAtIndex:j]];
            NSArray *filteredArray = [self.dogTips filteredArrayUsingPredicate:predicate];

            [self.arrAllDogTips addObject:filteredArray];
        }

        [self createDogScroller];
    }
    else
    {
        for (NSDictionary* petTips in [[json objectForKey:@"articles"] objectForKey:@"article"])
        {
            TipData* objTip = [[TipData alloc] init];
            objTip.title = [petTips valueForKey:@"title"];
            objTip.desc = [petTips valueForKey:@"desc"];
            objTip.category = [petTips valueForKey:@"category"];
            objTip.subCategory = [petTips valueForKey:@"sub_category"];
            objTip.species = [petTips valueForKey:@"species"];
            objTip.html = [petTips valueForKey:@"copy"];
            [self.catTips addObject:objTip];
        }

        self.arrCatCategories = [[NSMutableArray alloc] initWithArray:[[NSSet setWithArray:[self.catTips valueForKey:@"subCategory"]] allObjects]];

        for ( int j = 0; j < [self.arrCatCategories count]; j++)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subCategory == %@", [self.arrCatCategories objectAtIndex:j]];
            NSArray *filteredArray = [self.catTips filteredArrayUsingPredicate:predicate];

            //[self.dataCatArray addObject:filteredArray];
            [self.arrAllCatTips addObject:filteredArray];
        }

        [self createCatScroller];
    }
}

- (void)viewTipDetails:(int)pos withCategory:(NSString *)category withType:(NSString *)type andTipData:(TipData *)data
{
    NSLog(@"view tip details cat: %@", self.strSelectedCatCategory);


    PetTipsDetailViewController* petTipsDetailViewController = [[PetTipsDetailViewController alloc] initWithNibName:@"PetTipsDetailViewController" bundle:nil];
    petTipsDetailViewController.type = type;


    if ([type isEqualToString:@"dog"])
    {
        PetTipData *objData = [[PetTipData alloc] init];
        objData.data = data;
        objData.position = pos;
        objData.categoryArray = self.arrAllDogTips;
        objData.fullArray = self.dogTips;
        objData.filteredArray = self.dataDogArray;
        objData.selectedCategory = self.strSelectedCatCategory;
        objData.tipCategoriesArray = self.arrDogCategories;
        [petTipsDetailViewController initialize:objData];
    }
    else
    {
        PetTipData *objData = [[PetTipData alloc] init];
        objData.data = data;
        objData.position = pos;
        objData.categoryArray = self.arrAllCatTips;
        objData.fullArray = self.catTips;
        objData.filteredArray = self.dataCatArray;
        objData.selectedCategory = self.strSelectedCatCategory;
        objData.tipCategoriesArray = self.arrCatCategories;
        [petTipsDetailViewController initialize:objData];
    }

    [self.navigationController pushViewController:petTipsDetailViewController animated:YES];
}

- (void)showCategoryModal:(NSString *)type
{
    CGRect buttonFrame;

    if ([type isEqualToString:@"dog"])
    {
        buttonFrame.origin.x = 961;
        buttonFrame.origin.y = 45;
        buttonFrame.size.height = 20;
        buttonFrame.size.width = 20;
    }
    else
    {
        buttonFrame.origin.x = 961;
        buttonFrame.origin.y = 375;
        buttonFrame.size.height = 20;
        buttonFrame.size.width = 20;
    }

    self.type = type;

    self.tipCatView = [TipCategoriesViewController new];
    self.tipCatView.delegate = self;
    self.tipCatView.strSelectedCategory = @"All";
    if ([type isEqualToString:@"dog"])
    {
        self.tipCatView.strSelectedCategory = self.strSelectedDogCategory;
        self.tipCatView.arrCategories = self.arrDogCategories;
    }
    else
    {
        self.tipCatView.strSelectedCategory = self.strSelectedCatCategory;
        self.tipCatView.arrCategories = self.arrCatCategories;
    }

    NSString *firstCat = [self.tipCatView.arrCategories objectAtIndex:0];
    if (![firstCat isEqualToString:@"All"]) [self.tipCatView.arrCategories insertObject:@"All" atIndex:0];
    //self.tipCatView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.tipCatView];
    self.tipCatView.contentSizeForViewInPopover = CGSizeMake(320, 300);
    popover = [[UIPopoverController alloc] initWithContentViewController:navController ];
    //popover.popoverBackgroundViewClass
    [popover presentPopoverFromRect:buttonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)createCatScroller
{
    PetTipScrollerData *objData = [[PetTipScrollerData alloc] init];
    objData.categoryArray = self.arrAllCatTips;
    objData.fullArray = self.catTips;
    objData.title = NSLocalizedString(@"cat", nil);
    objData.isSelectedPositionUSed = NO;


    self.catScroller = [[PetTipsScrollerView alloc] initWithData:objData];
    self.catScroller.delegate = self;
    [self.catScroller setTitle];
    self.catScroller.frame = CGRectMake(0, 337, 1024, 326);
    [self.view addSubview:self.catScroller];
}

- (void)createDogScroller
{
    PetTipScrollerData *objData = [[PetTipScrollerData alloc] init];
    objData.categoryArray = self.arrAllDogTips;
    objData.fullArray = self.dogTips;
    objData.title = NSLocalizedString(@"dog", nil);
    objData.isSelectedPositionUSed = NO;

    self.dogScroller = [[PetTipsScrollerView alloc] initWithData:objData];
    self.dogScroller.delegate = self;
    self.dogScroller.frame = CGRectMake(0, 7, 1024, 326);
    [self.view addSubview:self.dogScroller];
}

- (void)addItemViewController:(TipCategoriesViewController *)controller didFinishEnteringItem:(NSString *)item andID:(int)numID
{
    self.numSection = numID;

    if ([self.type isEqualToString:@"dog"])
    {
        self.strSelectedDogCategory = item;
        self.dataArray = self.arrAllDogTips;
    }
    else
    {
        self.strSelectedCatCategory = item;
        self.dataArray = self.arrAllCatTips;
    }

    if ([self.type isEqualToString:@"dog"])
    {
        if (![self.strSelectedDogCategory isEqualToString:@"All"])
        {
            self.dataArray = [self.dataArray objectAtIndex:self.numSection-1];
            self.dataDogArray = self.dataArray;
            [self.dogScroller reset:self.dataArray withCategoryName:self.strSelectedDogCategory];
        }
        else  [self.dogScroller reset:self.dogTips withCategoryName:self.strSelectedDogCategory];
    }
    else
    {
        if (![self.strSelectedCatCategory isEqualToString:@"All"])
        {
            self.dataArray = [self.dataArray objectAtIndex:self.numSection-1];
            self.dataCatArray = self.dataArray;
            [self.catScroller reset:self.dataArray withCategoryName:self.strSelectedCatCategory];
        }
        else
        {
            [self.catScroller reset:self.catTips withCategoryName:self.strSelectedCatCategory];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
