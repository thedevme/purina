//
//  BlogPostView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/19/12.
//
//

#import "BlogPostView.h"
#import "BlogData.h"
#import "UIImageView+JMImageCache.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "UILabel+ESAdjustableLabel.h"
#import "NSString+HTML.h"

@implementation BlogPostView

- (id)initWithBlogData:(BlogData *)data
{
    self = [super init];
    if (self)
    {
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"BlogPostView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        
        self.objBlogData = data;
        
        [self setBlogImage];
        [self setBlogData];
    }
    return self;
}

- (void)setBlogData
{
    NSString* strTitle = [self truncateString:self.objBlogData.title toLimit:60];
    NSString* strDesc = [self truncateString:self.objBlogData.desc toLimit:170];

    self.lblTitle.text = strTitle;
    self.lblDesc.text = strDesc;
    
    self.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    self.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    self.lblDesc.textColor = [UIColor purinaDarkGrey];
    self.lblTitle.textColor = [UIColor purinaDarkGrey];
    
    [self.lblTitle setFrame:CGRectMake(30, 275, 250, 100)];
    [self.lblTitle adjustLabelToMaximumSize:CGSizeMake(250, 55) minimumSize:CGSizeZero minimumFontSize:16.0f];
    [self.lblDesc adjustLabelToMaximumSize:CGSizeMake(250, 200) minimumSize:CGSizeZero minimumFontSize:12.0f];
    
    self.lblTitle.font = [UIFont fontWithName:kHelveticaNeueMed size:16.0f];
    self.lblDesc.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    
    float numYPos = self.lblTitle.frame.size.height + self.lblTitle.frame.origin.y;
    
    
    if ([strTitle length] <= 29) [self.lblDesc setFrame:CGRectMake(30, numYPos+5, 250, 50)];
    if ([strTitle length] > 30) [self.lblDesc setFrame:CGRectMake(30, numYPos+5, 250, 34)];
    
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

- (void)setBlogImage
{
    [self.img setImageWithURL:[NSURL URLWithString:[self.objBlogData img]] placeholder:[UIImage imageNamed:@"BlogCardDefault.png"]];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
