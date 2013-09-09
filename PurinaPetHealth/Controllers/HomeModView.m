//
//  HomeModView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//

#import "HomeModView.h"
#import "AFNetworking.h"
#import "BlogData.h"
#import "NSString+HTML.h"

@implementation HomeModView


- (id)init
{
    self = [super init];
    
    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"HomeModView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        // Initialization code
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    [self setLabels];
}

- (void) setLabels
{
    _lblLiveBlog.font = [UIFont fontWithName:kHelveticaNeueCondBold size:25.0f];
    _lblLiveBlog.textColor = [UIColor purinaDarkGrey];
}


- (IBAction)onTipsTapped:(id)sender
{
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWTIPS"];
    [self.delegate updateView:3];
}

- (IBAction)onPetsTapped:(id)sender
{
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_VIEWPETS"];
    [self.delegate updateView:2];
}

@end
