//
//  PetCardTipView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/11/12.
//
//

#import "PetCardTipView.h"
#import "TipData.h"
#import "OHAttributedLabel.h"
#import "OHASBasicMarkupParser.h"
#import "Constants.h"
#import "UIImageView+JMImageCache.h"
#import "UIColor+PetHealth.h"

@implementation PetCardTipView

- (id)initWithData:(TipData *)data
{
    self = [super init];
    if (self)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PetCardTipView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.objTipData = data;

        [self setLabel];
        //NSLog(@"create pet card tip view");
        // Initialization code
        
        //http://static.clients.triadcontent.com/Purina/00_NES_42646_PetHealthUD/iPad/Images/

        
        //self.img.image = ;
        [self setCardImage];
    }
    return self;
}

- (void)setCardImage
{
    NSString *path = [NSString stringWithFormat:@"%@.png", [self.objTipData html]];
    NSString* imgPath = [NSString stringWithFormat:@"http://static.clients.triadcontent.com/Purina/00_NES_42646_PetHealthUD/iPad/Images/%@", path];
    [self.img setImageWithURL:[NSURL URLWithString:imgPath] placeholder:[UIImage imageNamed:@"tipDefault.png"]];
    
    NSLog(@"%@", path);
}

- (void)setLabel
{
    NSString* strTitleShort = [self truncateString:self.objTipData.title toLimit:60];
    NSString* strDescShort = [self truncateString:self.objTipData.desc toLimit:170];

    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", strTitleShort];
    NSString* strTypeDesc = [NSString stringWithFormat:@"%@", strDescShort];
    NSString* strDesc = [NSString stringWithFormat:@"%@\n%@", strTypeTitle, strTypeDesc];
    NSString* txt = strDesc;

    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:16]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeue size:12.0f] range:[txt rangeOfString:strTypeDesc]];

    self.lblDesc.attributedText = attrStr;
}

- (void) setSelected
{
    if (self.isSelected) self.imgSelectedBG.alpha = 1.0f;
    else self.imgSelectedBG.alpha = 0.0f;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
