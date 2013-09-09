//
//  POVView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//

#import "POVView.h"

@implementation POVView


- (id) initWithArray:(NSArray *)array andWidth:(int)width andHeight:(int)height
{
    self = [super init];
    
    if (self)
    {
        _numWidth = width;
        _numHeight = height;
        
        
        [self createArray:array];
        [self createControls];
        [self createFeaturedScroller];
    }
    
    return self;
}

- (void) createArray:(NSArray *)array
{
    _arrSlides = [[NSMutableArray alloc] initWithArray:array];
    [_slideTimer invalidate];

    _slideTimer = nil;
    //_slideTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(switchSlide:) userInfo:nil repeats:YES];
}

- (void) createControls
{
    _pageControls = [[DDPageControl alloc] init];
    [_pageControls addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _pageControls.frame = CGRectMake(_numWidth/2, (_numHeight-30) - 125, _numWidth, 30);
    [_pageControls setOnColor: [UIColor redColor]] ;
	[_pageControls setOffColor: [UIColor whiteColor]] ;
	[_pageControls setType: DDPageControlTypeOnFullOffFull] ;
    [_pageControls setIndicatorDiameter: 20.0f] ;
    self.pageControls.alpha = 0.0f;
}

- (void) pause
{
    [_slideTimer invalidate];
    _slideTimer = nil;
    self.alpha = 0.2f;
    _pageControls.alpha = 0.0f;
}

- (void)stop
{
    [_slideTimer invalidate];
    _slideTimer = nil;
}

- (void)resume
{
    _slideTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(switchSlide:) userInfo:nil repeats:YES];
}

- (void)createFeaturedScroller
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _numWidth, _numHeight)];
    
    [_pageControls addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < [_arrSlides count]; i++)
    {
        CGFloat yOrigin = i * _numWidth;
        UIView* featuredView = [[UIView alloc] initWithFrame:CGRectMake(yOrigin, 0, self.frame.size.width, self.frame.size.height)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_arrSlides objectAtIndex:i]]];
        imageView.frame = CGRectMake(0, 0, _numWidth, _numHeight);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFeatured:)];
        [featuredView addGestureRecognizer:tapGesture];
        [featuredView addSubview:imageView];
        featuredView.backgroundColor = [UIColor blackColor];
        featuredView.tag = i;
        
        [_scrollView addSubview:featuredView];
    }
    
    _scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * _arrSlides.count, _scrollView.frame.size.height);
    _pageControls.currentPage = 0;
    _pageControls.numberOfPages = _arrSlides.count;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControls];

    UIButton *blocker = [UIButton buttonWithType:UIButtonTypeCustom];
    blocker.frame = CGRectMake(0, 0, 1024, 500);
    //blocker.alpha = 0.0f;
    [self addSubview:blocker];
}

- (void) showFeatured:(UIGestureRecognizer *)sender
{
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_pageControlBeingUsed)
    {
        [_slideTimer invalidate];
        _slideTimer = nil;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _pageControlBeingUsed = NO;
    [_slideTimer invalidate];
    _slideTimer = nil;
    
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControlBeingUsed = NO;
    _pageControls.currentPage = _scrollView.contentOffset.x / _numWidth;
    
    _numCurrentPage = _scrollView.contentOffset.x / _numWidth;
    
    _pageControls.currentPage = _numCurrentPage;
    _slideTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(switchSlide:) userInfo:nil repeats:YES];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.scrollView.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

- (void) updatePage
{
    _numWidth += _numWidth;
    _scrollView.contentOffset = CGPointMake(_numWidth, 0);
}

- (IBAction) changePage:(id)sender
{
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControls.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    _pageControlBeingUsed = YES;
}


- (void) switchSlide:(NSTimer *)timer
{
    CGRect frame = _scrollView.frame;
    
    if (_numCurrentPage < self.pageControls.numberOfPages-1)
    {
        
        frame.origin.x = _numWidth * (_numCurrentPage + 1);
        _numCurrentPage++;
        self.pageControls.currentPage = _numCurrentPage;
        
        [_scrollView scrollRectToVisible:frame animated:YES];
    }
    else
    {
        frame.origin.x = 0;
        _numCurrentPage = 0;
        self.pageControls.currentPage = _numCurrentPage;
        [_scrollView scrollRectToVisible:frame animated:YES];
    }
}

@end
