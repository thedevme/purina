//
//  TipCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/26/12.
//
//

#import <UIKit/UIKit.h>
#import "UILabel+ESAdjustableLabel.h"

@interface TipCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end
