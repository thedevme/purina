//
//  AddMedicalItemViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/30/12.
//
//

#import <UIKit/UIKit.h>

#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "OHAttributedLabel.h"
#import "OHASBasicMarkupParser.h"
#import "PetData.h"
#import "MedicalItemCell.h"
#import "UniqueID.h"
#import "PetModel.h"
#import "CreateMedialItemViewController_iPhone.h"
#import "AddMedicalItemCell.h"


@interface AddMedicalItemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,
        CreateMedItemDelegate, AddMedicalCellDelegate>




@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
//@property (nonatomic, weak) id <CreateMedItemDelegate> delegate;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *contentType;
@property(nonatomic, copy) NSString *data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) MedicalData* objMedicalData;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblMessage;


@property(nonatomic, strong) PetModel* petModel;

@property(nonatomic, strong) PetData *objCurrentPetData;

@property(nonatomic, strong) NSMutableArray *arrMedicalItems;

@property(nonatomic, strong) UIPopoverController *contactPopover;

@property(nonatomic, strong) UIBarButtonItem *btnAddNew;

@property(nonatomic) BOOL isUpdating;

//Methods
- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data;
- (void) createMessage:(NSString *)message withRange:(NSString *)range;
- (IBAction)onSaveTapped:(id)sender;


@end

