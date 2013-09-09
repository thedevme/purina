//
//  POVView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//

#import <Foundation/Foundation.h>
#import "DDPageControl.h"

@interface POVView : UIView <UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray* arrSlides;
@property (nonatomic, retain) DDPageControl* pageControls;
@property (assign) BOOL pageControlBeingUsed;
@property (assign) int numWidth;
@property (assign) int numHeight;
@property (assign) int numCurrentPage;
@property (retain, nonatomic) NSTimer* slideTimer;
@property (nonatomic, retain) UIScrollView* scrollView;

- (void) switchSlide:(NSTimer *)timer;
- (id) initWithArray:(NSArray *)array andWidth:(int)width andHeight:(int)height;
- (void) pause;
- (void)stop;
- (void)resume;

@end
