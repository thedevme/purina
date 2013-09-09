//
//  TipCategoryCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/9/12.
//
//

#import "TipCategoryCell.h"

@implementation TipCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
//    if (selected) 
//    {
//        _imgSelected.alpha = 1.0f;
//        _imgUnselected.alpha = 0.0f;
//    }
//    else
//    {
//        _imgSelected.alpha = 0.0f;
//        _imgUnselected.alpha = 1.0f;
//    }
}

@end
