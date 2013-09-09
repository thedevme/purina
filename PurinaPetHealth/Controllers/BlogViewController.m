//
//  BlogViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/16/12.
//
//

#import "BlogViewController.h"
#import "BlogData.h"

@interface BlogViewController ()
{
    AFJSONRequestOperation* op;
}

@end

@implementation BlogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Blog";
        self.navigationItem.title = @"Blog";
        self.tabBarItem.image = [UIImage imageNamed:@"blogIcon.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
}

- (void) initialize
{
    [self initializeArrays];
    [self createData];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) initializeArrays
{
    _arrBlogData = [[NSMutableArray alloc] init];
}

- (void) createData
{
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

- (void) createBlogData:(id)data
{
    for (NSDictionary* dictionary in [[data objectForKey:@"value"] objectForKey:@"items"])
    {
        BlogData* objBlogData = [[BlogData alloc] init];

        NSString *object = [NSString stringWithUTF8String:[[dictionary objectForKey:@"description"] UTF8String]];

        //NSString *string = @"123 &1245; Ross Test 12";
        NSError *error = NULL;

        NSString *modifiedString  = [[dictionary objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];


        NSLog(@"%@", [self flattenHTML:modifiedString trimWhiteSpace:YES]);
        objBlogData.desc = [self flattenHTML:modifiedString trimWhiteSpace:YES];
        objBlogData.title = [dictionary objectForKey:@"title"];
        objBlogData.date = [dictionary objectForKey:@"pubDate"];
        objBlogData.link = [dictionary objectForKey:@"link"];
        
        [_arrBlogData addObject:objBlogData];
        
//        
//        NSLog(@"desc %@", [self stringByStrippingHTML:[dictionary objectForKey:@"description"]]);
//        NSLog(@"link %@", [dictionary objectForKey:@"link"]);
//        NSLog(@"pubDate %@", [dictionary objectForKey:@"pubDate"]);
//        NSLog(@"title %@", [dictionary objectForKey:@"title"]);
    }
    
    //NSLog(@"%@", _arrBlogData);
    [_tableView reloadData];
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

- (void) displayError
{
    //NSLog(@"There was an error");
}

- (NSString *) stringByStrippingHTML:(NSString *)string
{
    NSRange r;
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    return string;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifer";
    TipCell* cell = (TipCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TipCell" owner:self options:nil];
    BlogData* objTipData;
    
    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblTitle.numberOfLines = 0;
        cell.lblDesc.numberOfLines = 0;
    }
    
    objTipData = [_arrBlogData objectAtIndex:indexPath.row];
    //NSLog(@"%@", objTipData.desc);
    //objTipData.title
    //objTipData.desc
    NSString* strTitle = [self truncateString:objTipData.title toLimit:60];
    NSString* strDesc = [self truncateString:objTipData.desc toLimit:170];
    
    cell.lblTitle.text = strTitle;
    cell.lblDesc.text = strDesc;
    
    cell.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    cell.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    cell.lblDesc.textColor = [UIColor purinaDarkGrey];
    cell.lblTitle.textColor = [UIColor purinaDarkGrey];
    
    [cell.lblTitle setFrame:CGRectMake(20, 10, 250, 100)];
    [cell.lblDesc adjustLabelToMaximumSize:CGSizeMake(250, 200) minimumSize:CGSizeZero minimumFontSize:12.0f];
    [cell.lblTitle adjustLabelToMaximumSize:CGSizeMake(250, 55) minimumSize:CGSizeZero minimumFontSize:16.0f];
    
    cell.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    cell.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    float numYPos = cell.lblTitle.frame.size.height + cell.lblTitle.frame.origin.y;
    
    
    if ([strTitle length] <= 28) [cell.lblDesc setFrame:CGRectMake(20, numYPos+5, 250, 50)];
    if ([strTitle length] > 29) [cell.lblDesc setFrame:CGRectMake(20, numYPos+5, 250, 34)];
    
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrBlogData count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogData* item = [_arrBlogData objectAtIndex:[indexPath row]];
    
    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:item.link]];
    webBrowser.showURLStringOnActionSheetTitle = YES;
    webBrowser.showPageTitleOnTitleBar = NO;
    webBrowser.showActionButton = YES;
    webBrowser.showReloadButton = YES;
    webBrowser.mode = TSMiniWebBrowserModeNavigation;


    //NSDictionary* dict;
//    NSString* newsID = [NSString stringWithFormat:@"%i", item.numID];
//    dict = [NSDictionary dictionaryWithObjectsAndKeys:newsID, @"News ID", nil];
    //[Flurry logEvent:@"VIEW_ARTICLE_IPHONE"];

    webBrowser.barStyle = UIBarStyleBlack;

    if (webBrowser.mode == TSMiniWebBrowserModeModal)
    {
        [self presentModalViewController:webBrowser animated:YES];

    }
    else if(webBrowser.mode == TSMiniWebBrowserModeNavigation)
    {
        [self.navigationController pushViewController:webBrowser animated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
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
@end
