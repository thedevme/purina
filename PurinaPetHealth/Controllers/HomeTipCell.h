//
//  HomeTipCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//

#import <UIKit/UIKit.h>


@interface HomeTipCell : UITableViewCell

@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblDesc;


//@property(nonatomic, strong) UILabel *lblTest;

@property(nonatomic) BOOL isAddVisible;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
