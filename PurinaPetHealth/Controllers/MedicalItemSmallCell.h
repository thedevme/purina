//
//  MedicalItemSmallCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>

@interface MedicalItemSmallCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondItem;
@property (strong, nonatomic) IBOutlet UILabel *lblDateAdded;
@property (strong, nonatomic) IBOutlet UITextView *txtData;


@end
