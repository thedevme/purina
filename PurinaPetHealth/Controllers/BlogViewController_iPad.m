//
//  BlogViewController_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//

#import "BlogViewController_iPad.h"
#import "BlogPostView.h"

@interface BlogViewController_iPad ()
{
    AFJSONRequestOperation* op;
}

@end

@implementation BlogViewController_iPad

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
        //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&#8220;" options:NSRegularExpressionCaseInsensitive error:&error];
        //NSString *modifiedString = [regex stringByReplacingMatchesInString:object options:0 range:NSMakeRange(0, [object length]) withTemplate:@""""];




        NSString *modifiedString  = [[dictionary objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];


        NSLog(@"%@", [self flattenHTML:modifiedString trimWhiteSpace:YES]);
        objBlogData.desc = [self flattenHTML:modifiedString trimWhiteSpace:YES];
        objBlogData.title = [dictionary objectForKey:@"title"];
        objBlogData.date = [dictionary objectForKey:@"pubDate"];
        objBlogData.link = [dictionary objectForKey:@"link"];

        NSMutableArray *arrImages = [[NSMutableArray alloc] initWithArray:[[dictionary objectForKey:@"media:content"] allObjects]];
        NSString * imgURL = [[arrImages objectAtIndex:1] valueForKey:@"url"];

        if (imgURL != NULL)
        {
            //NSLog(@"url %@", imgURL);
            objBlogData.img = imgURL;
        }
        else
        {
            objBlogData.img = @"";
        }
        
        
        [_arrBlogData addObject:objBlogData];
    }
    
    //NSLog(@"%@", _arrBlogData);
    //[_tableView reloadData];
    
    [self createGrid];
    //[self createWebView];
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

- (void) createGrid
{
    _scrollView.pagingEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    
    int numTotalGridWidth = 3;
    int numCount = 0;
    int colIndex;
    for (int i = 0; i < [self.arrBlogData count]; i++)
    {
        int numRange = 0;
        
        for (colIndex = numRange; colIndex < numTotalGridWidth; colIndex++)
        {
            if (numCount < [self.arrBlogData count])
            {
                float numXSpacing = (float) (colIndex * 331) + 9;
                float numYSpacing = (float) (i * 410) + 10;
                
                BlogPostView* dayView = [[BlogPostView alloc] initWithBlogData:[self.arrBlogData objectAtIndex:numCount]];
                dayView.tag = numCount;
                dayView.backgroundColor = [UIColor clearColor];
                UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewPost:)];
                gestureRecognizer.numberOfTapsRequired = 1;
                [dayView addGestureRecognizer:gestureRecognizer];
                dayView.frame = CGRectMake(numXSpacing, numYSpacing, 331, 410);
                //[self.days addObject:dayView];
                [self.scrollView addSubview:dayView];
                numCount++;
            }
        }
    }
    
    NSInteger numHeight = (colIndex + 1) * 420;
    
    _scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, numHeight);
}

- (void)viewPost:(UITapGestureRecognizer *)sender
{
    BlogData *objBlogData = [self.arrBlogData objectAtIndex:[[sender view]tag]];
    
    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:[objBlogData link]]];
    webBrowser.showURLStringOnActionSheetTitle = YES;
    webBrowser.showPageTitleOnTitleBar = NO;
    webBrowser.showActionButton = YES;
    webBrowser.showReloadButton = YES;
    webBrowser.mode = TSMiniWebBrowserModeModal;
    webBrowser.barStyle = UIBarStyleBlack;
    [self presentModalViewController:webBrowser animated:YES];
    //[self presentModalViewController:webBrowser animated:YES];
    //NSDictionary* dict;
    //NSString* newsID = [NSString stringWithFormat:@"%i", item.numID];
    //dict = [NSDictionary dictionaryWithObjectsAndKeys:newsID, @"News ID", nil];
    //[Flurry logEvent:@"VIEW_ARTICLE_IPHONE" withParameters:dict];
    
}


- (void) displayError
{
    NSLog(@"There was an error");
}

- (NSString *) stringByStrippingHTML:(NSString *)string
{
    NSRange r;
    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    return string;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end

