//
//  TipViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/27/12.
//
//

#import "TipViewController_iPhone5.h"
#import "CMHTMLView.h"

@interface TipViewController_iPhone5 ()

@end

@implementation TipViewController_iPhone5

@synthesize webView;
@synthesize filePath;
@synthesize htmlString;
@synthesize current;
@synthesize arrArticles;
@synthesize btnNext, btnPrev;
@synthesize lblCurrentCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withData:(NSArray *)articles selectedTip:(int)selected
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrArticles = [[NSArray alloc] initWithArray:articles];
        //strCurrent = [tip html];
        NSLog(@"%i", selected);
        current = selected;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblCurrentCount.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    [self createHTML];
    [self checkCurrentPosition];
    // Do any additional setup after loading the view from its nib.
}


- (void) createHTML
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    filePath = [[NSBundle mainBundle] pathForResource:[[arrArticles objectAtIndex:current] html] ofType:@"html"];
    htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setBtnNext:nil];
    [self setBtnPrev:nil];
    [self setLblCurrentCount:nil];
    [super viewDidUnload];
}
- (IBAction)onNextTapped:(id)sender
{
    if (current != [arrArticles count] -1)
    {
        current++;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        filePath = [[NSBundle mainBundle] pathForResource:[[arrArticles objectAtIndex:current] html] ofType:@"html"];
        htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
        btnNext.alpha = 1.0f;
        btnPrev.alpha = 1.0f;
    }
    
    [self checkCurrentPosition];
    
}

- (IBAction)onPreviousTapped:(id)sender
{
    if (current != 0)
    {
        current--;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        filePath = [[NSBundle mainBundle] pathForResource:[[arrArticles objectAtIndex:current] html] ofType:@"html"];
        htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
        btnPrev.alpha = 1.0f;
        btnNext.alpha = 1.0f;
    }
    
    [self checkCurrentPosition];
}

- (void) checkCurrentPosition
{
    if (current == 0)
    {
        btnPrev.alpha = 0.5f;
        btnNext.alpha = 1.0f;
    }
    else if (current == [arrArticles count] - 1)
    {
        btnNext.alpha = 0.5f;
        btnPrev.alpha = 1.0f;
    }
    else
    {
        btnNext.alpha = 1.0f;
        btnPrev.alpha = 1.0f;
    }
    
    lblCurrentCount.text = [NSString stringWithFormat:@"%i/%i", current+1, [arrArticles count]];
}


@end
