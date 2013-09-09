//
//  MedicalItemCell.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "MedicalData.h"


@protocol MedicalItemCellDelegate <NSObject>

- (void) deleteItem:(MedicalData *)data;

@end

@interface MedicalItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondItem;
@property (strong, nonatomic) IBOutlet UILabel *lblDateAdded;
@property (strong, nonatomic) IBOutlet UITextView *txtData;
@property (nonatomic, strong) MedicalData *objMedicalData;
@property (weak, nonatomic) id <MedicalItemCellDelegate> delegate;

- (IBAction)onDeleteTapped:(id)sender;
- (id) initWithData:(MedicalData *)data;
@end
