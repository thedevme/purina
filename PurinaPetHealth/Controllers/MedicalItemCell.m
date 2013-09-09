//
//  MedicalItemCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import "MedicalItemCell.h"

@implementation MedicalItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"init with style");
    }
    return self;
}

- (id) initWithData:(MedicalData *)data
{
    self = [super init];

    if (self)
    {
        self.objMedicalData = [[MedicalData alloc] init];
        self.objMedicalData = data;
        NSLog(@"init with data %@", self.objMedicalData);
        // Custom initialization
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
