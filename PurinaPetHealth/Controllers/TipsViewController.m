//
//  TipsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/26/12.
//
//

#import "TipsViewController.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

@synthesize tips;
@synthesize tableView;
@synthesize type;
@synthesize arrCategories;
@synthesize arrAllTips;
@synthesize dataArray;
@synthesize categoriesView;
@synthesize strSelectedCategory;
@synthesize numSection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTipsType:(NSString *)tipsType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
        type = tipsType;
        strSelectedCategory = @"All";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
    [self createTipData];
    [self addNavButton];


    // Do any additional setup after loading the view from its nib.
}




- (void) createTipData
{
    tips = [[NSMutableArray alloc] init];
    arrCategories = [[NSMutableArray alloc] init];
    dataArray = [[NSMutableArray alloc] init];
    arrAllTips = [[NSMutableArray alloc] init];
    
    [self setTipData];
}

- (void) addNavButton
{
    UIImage *faceImage = [UIImage imageNamed:@"listIcon@2x.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, 30, 30 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(onCategoriesTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    [self.navigationItem setRightBarButtonItem:faceBtn];
}

- (void) setTipData
{
    if ([type isEqualToString:@"dog"])
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dog-tips" ofType:@"json"];
        NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        
        for (NSDictionary* petTips in [[json objectForKey:@"articles"] objectForKey:@"article"])
        {
            TipData* objTip = [[TipData alloc] init];
            objTip.title = [petTips valueForKey:@"title"];
            objTip.desc = [petTips valueForKey:@"desc"];
            objTip.category = [petTips valueForKey:@"category"];
            objTip.subCategory = [petTips valueForKey:@"sub_category"];
            objTip.species = [petTips valueForKey:@"species"];
            objTip.html = [petTips valueForKey:@"copy"];
            
            [tips addObject:objTip];
        }
        
        arrCategories = [[NSMutableArray alloc] initWithArray:[[NSSet setWithArray:[tips valueForKey:@"subCategory"]] allObjects]];
        
        for ( int j = 0; j < [arrCategories count]; j++)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subCategory == %@", [arrCategories objectAtIndex:j]];
            NSArray *filteredArray = [tips filteredArrayUsingPredicate:predicate];
            
            [dataArray addObject:filteredArray];
            [arrAllTips addObject:filteredArray];
        }
    }
    
    if ([type isEqualToString:@"cat"])
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat-tips" ofType:@"json"];
        NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        for (NSDictionary* petTips in [[json objectForKey:@"articles"] objectForKey:@"article"])
        {
            TipData* objTip = [[TipData alloc] init];
            objTip.title = [petTips valueForKey:@"title"];
            objTip.desc = [petTips valueForKey:@"desc"];
            objTip.category = [petTips valueForKey:@"category"];
            objTip.subCategory = [petTips valueForKey:@"sub_category"];
            objTip.species = [petTips valueForKey:@"species"];
            objTip.html = [petTips valueForKey:@"copy"];
            
            [tips addObject:objTip];
        }
        
        arrCategories = [[NSMutableArray alloc] initWithArray:[[NSSet setWithArray:[tips valueForKey:@"subCategory"]] allObjects]];
        
        for ( int j = 0; j < [arrCategories count]; j++)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subCategory == %@", [arrCategories objectAtIndex:j]];
            NSArray *filteredArray = [tips filteredArrayUsingPredicate:predicate];
            
            [dataArray addObject:filteredArray];
            [arrAllTips addObject:filteredArray];
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void) createNavigationButtons
{
    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonSystemItemDone target:self action:@selector(onAddTapped:)];
    btnDoneItem.tintColor = [UIColor colorWithRed:145.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = btnDoneItem;
}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savePet:) name:@"savePet" object:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"strSelectedCatCategory %@", strSelectedCategory);
    
    if ([strSelectedCategory isEqualToString:@"All"]) return [dataArray count];
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"num of row sections %i", [dataArray count]);
    if ([strSelectedCategory isEqualToString:@"All"]) return [[dataArray objectAtIndex:section] count];
    else return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame: CGRectMake(20.0, 20.0, 320.0, 50.0f)];
    headerView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"tipsSectionBG" ofType: @"png"]]];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 285, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textAlignment = UITextAlignmentCenter;
    lblTitle.textColor = [UIColor purinaDarkGrey];
    lblTitle.font = [UIFont fontWithName:kHelveticaNeueBold size:20.0f];
    if ([strSelectedCategory isEqualToString:@"All"]) lblTitle.text = [arrCategories objectAtIndex:section];
    else lblTitle.text = [arrCategories objectAtIndex:numSection-1];
    
    [headerView addSubview:lblTitle];
    
    //[arrDivisions objectAtIndex:section];
    
    return headerView;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifer";
    TipCell* cell = (TipCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TipCell" owner:self options:nil];
    TipData* objTipData;
    
    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblTitle.numberOfLines = 0;
        cell.lblDesc.numberOfLines = 0;
    }
    
    if ([strSelectedCategory isEqualToString:@"All"])
    {
        objTipData = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else
    {
        objTipData = [dataArray objectAtIndex:indexPath.row];
    }
    
    
    NSString* strTitle = [self truncateString:objTipData.title toLimit:60];
    
    cell.lblTitle.text = strTitle;
    cell.lblDesc.text = objTipData.desc;
    
    cell.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    cell.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    cell.lblDesc.textColor = [UIColor purinaDarkGrey];
    cell.lblTitle.textColor = [UIColor purinaDarkGrey];
    
    [cell.lblTitle setFrame:CGRectMake(20, 10, 250, 100)];
    [cell.lblDesc adjustLabelToMaximumSize:CGSizeMake(250, 100) minimumSize:CGSizeZero minimumFontSize:12.0f];
    [cell.lblTitle adjustLabelToMaximumSize:CGSizeMake(250, 55) minimumSize:CGSizeZero minimumFontSize:16.0f];
    
    cell.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    cell.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    float numYPos = cell.lblTitle.frame.size.height + cell.lblTitle.frame.origin.y;
    
    
    if ([strTitle length] <= 28) [cell.lblDesc setFrame:CGRectMake(20, numYPos+5, 250, 44)];
    if ([strTitle length] > 29) [cell.lblDesc setFrame:CGRectMake(20, numYPos+5, 250, 34)];
    
    NSLog(@"%@", objTipData);

//    if ([dataArray objectAtIndex:indexPath.section])
    //NSLog(@"%i", [dataArray count]);
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 115;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        NSArray* arrTips;
        
        if ([strSelectedCategory isEqualToString:@"All"])
        {
            arrTips = [dataArray objectAtIndex:indexPath.section];
            
        }
        else
        {
            arrTips = dataArray;
            NSLog(@"%@", dataArray);
        }
        
        TipViewController_iPhone5* tipViewController = [[TipViewController_iPhone5 alloc] initWithNibName:@"TipViewController_iPhone5" bundle:nil withData:arrTips selectedTip:indexPath.row];
        [self.navigationController pushViewController:tipViewController animated:YES];
    }
    else
    {
        NSArray* arrTips;
        
        if ([strSelectedCategory isEqualToString:@"All"])
        {
            arrTips = [dataArray objectAtIndex:indexPath.section];
        }
        else
        {
            arrTips = dataArray;
        }
        
        TipViewController* tipViewController = [[TipViewController alloc] initWithNibName:@"TipViewController" bundle:nil withData:arrTips selectedTip:indexPath.row];

        [self.navigationController pushViewController:tipViewController animated:YES];
    }
}

- (NSString *) truncateString:(NSString *)$string toLimit:(int)$limit {
    if ([$string length] > $limit) {
        $string = [$string substringToIndex:$limit];
        int index = [$string length];
        for (int i=0; i<[$string length]; ++i) {
            char charValue = [$string characterAtIndex:i];
            NSString * value = [NSString stringWithFormat:@"%c", charValue];
            if ([value isEqualToString:@" "]) {
                index = i;
            }
        }
        $string = [$string substringToIndex:index];
        $string = [NSString stringWithFormat:@"%@...", $string];
    }
    return $string;
}

- (void) onCategoriesTapped:(id) sender
{
    NSLog(@"selected category %@", strSelectedCategory);
     categoriesView = [[TipCategoriesViewController alloc] initWithNibName:@"TipCategoriesViewController" bundle:nil andCategories:arrCategories withSelectedCat:strSelectedCategory];
    categoriesView.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:categoriesView];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navController animated:YES];
}

- (void) addItemViewController:(TipCategoriesViewController *)controller didFinishEnteringItem:(NSString *)item andID:(int)numID
{
    numSection = numID;
    strSelectedCategory = item;
    
    dataArray = arrAllTips;
    
    if (![strSelectedCategory isEqualToString:@"All"])
    {
        dataArray = [dataArray objectAtIndex:numSection-1];
    }
    
    //[arrPets setArray:filteredArray];
    [self.tableView reloadData];
    [tableView setContentOffset:CGPointZero animated:YES];
}


@end
