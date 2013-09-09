//
//  PetScrollerView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import "PetScrollerView.h"
#import "Constants.h"

@implementation PetScrollerView

- (id) initWithArray:(NSArray *)data
{
    self = [super init];
    
    if (self)
    {
        _numWidth = 510;
        _numHeight = 590;
        //NSLog(@"strData %@", strData);
        self.arrCards = [[NSMutableArray alloc] init];
        [self createArray:data];
        [self createScroller];


        self.contactDelegate = self;
    }
    
    return self;
}

- (void) createArray:(NSArray *)array
{
    if (_arrPets.count > 0) [_arrPets removeAllObjects];
    _arrPets = [[NSMutableArray alloc] initWithArray:array];

}


- (void)createScroller
{
    NSLog(@"create scroller for cards ");
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(45, 0, _numWidth, _numHeight)];
    _pageControlBeingUsed = NO;
    
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.clipsToBounds = NO;
    int numHeight;

    if ([self.arrPets count] > 0)
    {
        for (int i = 0; i < [_arrPets count]; i++)
        {
            NSLog(@"%@", [_arrPets objectAtIndex:i]);
            PetData *objData = [_arrPets objectAtIndex:i];
            PetCardView* cardView = [[PetCardView alloc] initWithPetData:objData];
            cardView.delegate = self;
            cardView.frame = CGRectMake(i * _numWidth, 0, _numWidth, _numHeight);
            [_scrollView addSubview:cardView];
            if (i == 0) numHeight = cardView.frame.size.height;
            [self.arrCards addObject:cardView];
        }

        self.scrollView.contentSize = CGSizeMake(_numWidth * [_arrPets count], numHeight);
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowPet object:[self.arrPets objectAtIndex:0]];
    }

    [self addSubview:_scrollView];
}

- (void)addContactData:(ContactData *)contact
{
    NSLog(@"add contact data - pet scroller");
}

- (void)deletePet:(PetData *)pet
{
    [self.delegate deletePetData:pet];
}

- (void)editPet:(PetData *)pet
{
    [self.delegate editPetData:pet];
}

- (void)editPet:(PetData *)pet withContactData:(ContactData *)contact
{
    [self.delegate editPetData:pet withContactData:contact];
}

- (void) updateScrollerWithDeletedPet:(PetData *)data
{
    [self.arrPets removeObject:data];
    [self reset];
    [self createScroller];
}

- (void)updatePetInfo:(NSArray *)pets
{
    //if (self.arrPets.count > 0) [self.arrPets removeAllObjects];
//    self.arrPets = pets;
//
//    [self reset];
//    [self createScroller];
    NSLog(@"loop %i", [pets count]);
    NSLog(@"cards %i", [self.arrCards count]);

    for (int i = 0; i < [pets count]; i++)
    {
        NSLog(@"loop %@", [pets objectAtIndex:i]);
        PetCardView *card = (PetCardView *)[self.arrCards objectAtIndex:i];
        [card updateCard:[pets objectAtIndex:i]];
    }
}

- (void)resetScroller:(NSArray *)pets
{
    if (self.arrPets.count > 0)
    {
        [self.arrPets removeAllObjects];
    }

    self.arrPets.array = pets;

    [self reset];
    [self createScroller];
}

- (void) updateScroller:(NSArray *)pets
{
    //NSLog(@"update scroller %@", array);
    //[self.arrPets insertObject:data atIndex:0];
    if (self.arrPets.count > 0)
    {
        [self.arrPets removeAllObjects];
    }

    self.arrPets.array = pets;

    [self reset];
    [self createScroller];
}

- (void) reset
{
    for (UIView *i in self.scrollView.subviews)
        [i removeFromSuperview];
}

- (void)showPet:(PetData *)pet
{
    [self.delegate showPet:pet];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_pageControlBeingUsed)
    {
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _pageControlBeingUsed = NO;
    
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControlBeingUsed = NO;
    _numCurrentPage = _scrollView.contentOffset.x / _numWidth;

    NSLog(@"num currnet page name %@", [[self.arrPets objectAtIndex:self.numCurrentPage] name]);


    [self showPet:[self.arrPets objectAtIndex:self.numCurrentPage]];
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
    frame.origin.x = self.scrollView.frame.size.width * _numCurrentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    _pageControlBeingUsed = YES;
}


@end
