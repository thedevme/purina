//
//  MyPetCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/26/12.
//
//

#import "MyPetCell.h"

@implementation MyPetCell
@synthesize lblPetName;
@synthesize lblBirthday;
@synthesize imgDefault;
@synthesize imgBorder;
@synthesize lblTitleBirthday;
@synthesize lblTitleBreed;

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

    // Configure the view for the selected state
}

@end
