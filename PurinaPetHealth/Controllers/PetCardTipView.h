//
//  PetCardTipView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/11/12.
//
//

#import <UIKit/UIKit.h>

@class TipData;
@class OHAttributedLabel;

@interface PetCardTipView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblDesc;
@property (nonatomic, retain) TipData* objTipData;
@property (strong, nonatomic) IBOutlet UIImageView *imgSelectedBG;
@property (assign) BOOL isSelected;

- (id)initWithData:(TipData *)data;
- (void) setSelected;

@end
