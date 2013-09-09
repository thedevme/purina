//
//  AddMedicalItemCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import <UIKit/UIKit.h>
#import "MedicalData.h"

@protocol AddMedicalCellDelegate <NSObject>

- (void) deleteItem:(MedicalData *)data;

@end

@interface AddMedicalItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondItem;
@property (strong, nonatomic) IBOutlet UILabel *lblDateAdded;
@property (strong, nonatomic) IBOutlet UITextView *txtData;
@property (weak, nonatomic) id <AddMedicalCellDelegate> delegate;
@property (nonatomic, strong) MedicalData *objMedicalData;

- (IBAction)onDeleteTapped:(id)sender;

@end
