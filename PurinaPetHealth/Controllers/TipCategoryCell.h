//
//  TipCategoryCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/9/12.
//
//

#import <UIKit/UIKit.h>

@interface TipCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *imgUnselected;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;
@property (assign) BOOL isSelected;

@end
