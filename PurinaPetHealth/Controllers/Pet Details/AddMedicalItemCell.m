//
//  AddMedicalItemCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import "AddMedicalItemCell.h"


@implementation AddMedicalItemCell

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

- (IBAction)onDeleteTapped:(id)sender
{
    [self.delegate deleteItem:self.objMedicalData];
    //NSLog(@"delete tapped %@", self.objMedicalData);
}

@end
