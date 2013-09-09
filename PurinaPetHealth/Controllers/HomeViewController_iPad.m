//
//  HomeViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//

#define WIDTH_OF_SCROLL_PAGE 1024
#define HEIGHT_OF_SCROLL_PAGE 476
#define WIDTH_OF_IMAGE 1024
#define HEIGHT_OF_IMAGE 476
#define LEFT_EDGE_OFSET 0

#import "HomeViewController_iPad.h"
#import "AFNetworking.h"
#import "NSString+HTML.h"
#import "BlogData.h"
#import "UILabel+ESAdjustableLabel.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"
#import "Contact.h"
#import "PetModel.h"
#import "TSMiniWebBrowser.h"
#import "OHAttributedLabel.h"

@interface HomeViewController_iPad ()
{
    AFJSONRequestOperation* op;
}

@end

@implementation HomeViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Home";
        self.navigationItem.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"tabIcon_home.png"];
        [self.navigationController setNavigationBarHidden:YES];

        [self initializeArrays];
    }
    
    return self;
}

- (void) initialize
{
    [self createFeaturedScroller];
    [self createModView];
//
    [self createLogo];
//
    [self createData];
}

- (void) createFeaturedScroller
{
    _arrSlides = [[NSArray alloc] initWithObjects:@"homeLifestyle1.png", @"homeLifestyle2.png", @"homeLifestyle3.png", nil];
    
    _povView = [[POVView alloc] initWithArray:_arrSlides andWidth:1024 andHeight:575];
    _povView.frame = CGRectMake(0, 0, 1024, 575);

    self.objPetModel = [[PetModel alloc] init];
    NSArray * arrPets = [[NSArray alloc] initWithArray:[self.objPetModel getPetData]];
    _povView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_povView];

    if ([arrPets count] == 0)
    {
        [_povView pause];
        [_povView stop];

        UIButton *btnAddAPet = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAddAPet.frame = CGRectMake(225, 225, 583, 115);
        [btnAddAPet setImage:[UIImage imageNamed:@"homeAddPetBtn.png"] forState:UIControlStateNormal];
        [btnAddAPet addTarget:self
                       action:@selector(onAddMyPetsTapped:)
             forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnAddAPet];
    }



}

- (void)onAddMyPetsTapped:(id)sender
{
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWPETS"];
    [self.tabBarController setSelectedIndex:2];
}

- (void) createModView
{
    _homeModView = [[HomeModView alloc] init];
    _homeModView.delegate = self;
    _homeModView.frame = CGRectMake(0, (self.view.frame.size.height - 248) - 48, 1024, 248);
    [self.view addSubview:_homeModView];
}

- (void) createLogo
{
    UIImageView* imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeLogo_iPad.png"]];
    imgLogo.frame = CGRectMake((self.view.frame.size.width/2) - 105, 0, 211, 136);
    [self.view addSubview:imgLogo];
}

- (void) createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(315, 510, 401, 165) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}




- (void) initializeArrays
{
    _arrBlogData = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void) createData
{
    self.lblMessage = [[OHAttributedLabel alloc] init];
    //self.lblMessage.attributedText = @"Error";
    self.lblMessage.backgroundColor = [UIColor clearColor];
    self.lblMessage.frame = CGRectMake(315, 550, 401, 165);
    self.lblMessage.alpha = 0.0f;
    [self.view addSubview:self.lblMessage];

    NSString* strFeedURL = [NSString stringWithFormat:NSLocalizedString(@"http://pipes.yahoo.com/pipes/pipe.run?_id=2255df3832bbbc40c3b3775c2aa80948&_render=json",)];
    NSURL* url = [NSURL URLWithString:strFeedURL];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];

    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:req
                                                         success:^(NSURLRequest* request, NSHTTPURLResponse* response, id JSON) {
                                                             [self createBlogData:JSON];

                                                         }
                                                         failure:^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error, id JSON) {
                                                             [self displayError];

                                                         }];
    [op start];
}

- (void) viewWillAppear:(BOOL)animated
{
    //NSLog(@"view will appear");
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    if ([[self.objPetModel getPetData] count] == 0)
    {
        [self.povView stop];
    }
    else
    {
        [self.povView resume];
    }
}

- (void) displayError
{
    NSLog(@"There was an error");
    [self createMessage:@"Sorry it appears that you\n do not have internet at this time."];
}

- (void) createBlogData:(id)data
{
    for (NSDictionary* dictionary in [[data objectForKey:@"value"] objectForKey:@"items"])
    {


        NSString *modifiedString  = [[dictionary objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];


        NSLog(@"%@", [self flattenHTML:modifiedString trimWhiteSpace:YES]);


        //NSMutableArray *arrImages = [[NSMutableArray alloc] initWithArray:[[dictionary objectForKey:@"media:content"] allObjects]];

        BlogData* objBlogData = [[BlogData alloc] init];
        objBlogData.desc = [self flattenHTML:modifiedString trimWhiteSpace:YES];
        objBlogData.title = [dictionary objectForKey:@"title"];
        objBlogData.date = [dictionary objectForKey:@"pubDate"];
        objBlogData.link = [dictionary objectForKey:@"link"];
        [_arrBlogData addObject:objBlogData];
    }

    [self createTableView];
    [_tableView reloadData];
    if (self.arrBlogData.count == 0)
    {
        [self displayError];
    }



    if (self.arrBlogData.count > 0)
    {

    }
    else
    {
        [self displayError];
    }
    NSLog(@"%@", self.arrBlogData);
}

- (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {

    NSScanner *theScanner;
    NSString *text = nil;

    theScanner = [NSScanner scannerWithString:html];

    while ([theScanner isAtEnd] == NO) {

        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;

        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];

    } // while //

    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdenifier = @"CellTableIdentifier";

    HomeTipCell* cell = (HomeTipCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdenifier];
    BlogData *objBlogData;
    if (self.arrBlogData.count > 0) objBlogData = [_arrBlogData objectAtIndex:[indexPath row]];

    if (cell == nil)
    {
        cell = [[HomeTipCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:CellIdenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        cell.lblTitle.numberOfLines = 0;
        cell.lblDesc.numberOfLines = 0;
    }

    NSString* strTitle = [self truncateString:objBlogData.title toLimit:30];
    NSString* strDesc = [self truncateString:objBlogData.desc toLimit:150];

    cell.lblTitle.text =  strTitle;
    cell.lblDesc.text = strDesc;

    [cell.lblTitle setFrame:CGRectMake(0, 5, 360, 100)];
    [cell.lblDesc adjustLabelToMaximumSize:CGSizeMake(360, 200) minimumSize:CGSizeZero minimumFontSize:12.0f];
    [cell.lblTitle adjustLabelToMaximumSize:CGSizeMake(360, 55) minimumSize:CGSizeZero minimumFontSize:16.0f];

    float numYPos = cell.lblTitle.frame.size.height + (cell.lblTitle.frame.origin.y - 2);


    if ([strTitle length] <= 28) [cell.lblDesc setFrame:CGRectMake(0, numYPos, 360, 50)];
    if ([strTitle length] > 29) [cell.lblDesc setFrame:CGRectMake(0, numYPos, 360, 34)];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select row");

    BlogData* item = [_arrBlogData objectAtIndex:[indexPath row]];

    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:item.link]];
    webBrowser.showURLStringOnActionSheetTitle = YES;
    webBrowser.showPageTitleOnTitleBar = NO;
    webBrowser.showActionButton = YES;
    webBrowser.showReloadButton = YES;
    webBrowser.mode = TSMiniWebBrowserModeNavigation;

    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWBLOG"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    webBrowser.barStyle = UIBarStyleBlack;

    if (webBrowser.mode == TSMiniWebBrowserModeModal)
    {
        [self presentModalViewController:webBrowser animated:YES];

    }
    else if(webBrowser.mode == TSMiniWebBrowserModeNavigation)
    {
        NSLog(@"nav mode %@", self.navigationController);

        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController pushViewController:webBrowser animated:YES];
    }
}

- (NSString *) truncateString:(NSString *)$string toLimit:(int)$limit
{
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


- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:22]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"internet"]];

    self.lblMessage.alpha = 1.0f;
    self.lblMessage.attributedText = attrStr;
}

- (void) updateView:(NSInteger)tab
{
    [self.tabBarController setSelectedIndex:tab];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view from its nib.
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

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
    [self.povView stop];
}


- (void)viewDidUnload
{
    NSLog(@"view did upload");
    [super viewDidUnload];
}
@end
