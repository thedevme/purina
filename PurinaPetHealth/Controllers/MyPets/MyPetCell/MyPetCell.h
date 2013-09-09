//
//  MyPetCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/26/12.
//
//

#import <UIKit/UIKit.h>

@interface MyPetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblPetName;
@property (weak, nonatomic) IBOutlet UILabel *lblBreed;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UIImageView *imgDefault;
@property (weak, nonatomic) IBOutlet UIImageView *imgBorder;

@property (weak, nonatomic) IBOutlet UILabel *lblTitleBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBreed;



@end
