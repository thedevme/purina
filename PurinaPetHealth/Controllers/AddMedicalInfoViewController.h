//
//  AddMedicalInfoViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "NSDate+Helper.h"
#import "OHAttributedLabel.h"
#import "PetModel.h"
#import "MedicalData.h"
#import "DateOwnedPicker.h"
#import "MedicalItemCell.h"


@protocol AddMedicalInfoDelegate <NSObject>

- (void)updatePetData:(PetData *)pet;

@end


@interface AddMedicalInfoViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource,
        UITableViewDelegate, DateOwnedPickerDelegate, MedicalItemCellDelegate>

@property (nonatomic, weak) id <AddMedicalInfoDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
//@property (nonatomic, weak) id <CreateMedItemDelegate> delegate;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *contentType;
@property(nonatomic, copy) NSString *data;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondItem;
@property (strong, nonatomic) IBOutlet UITextField *tfSecondItem;
@property (strong, nonatomic) IBOutlet UIImageView *imgSecondItem;
@property (strong, nonatomic) IBOutlet UITextView *txtMedical;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblTitle;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblDesc;
@property (strong, nonatomic) IBOutlet UIImageView *imgTxtBG;

@property (strong, nonatomic) IBOutlet UILabel *lblEdit;
@property (nonatomic, retain) MedicalData* objMedicalData;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet OHAttributedLabel *lblMessage;

@property (strong, nonatomic) IBOutlet UIImageView *imgDateBG;

@property(nonatomic, strong) PetModel* petModel;

@property(nonatomic, strong) PetData *objCurrentPetData;

@property(nonatomic, copy) NSString *selectedDate;

@property(nonatomic, strong) UITextField *selectedTf;

@property(nonatomic, strong) NSMutableArray *arrMedicalItems;
@property (strong, nonatomic) IBOutlet UIButton *btnDate;

@property(nonatomic, strong) UIPopoverController *contactPopover;

@property(nonatomic) BOOL isUpdating;

//Methods
- (void)initializeWithType:(NSString *)type withContentType:(NSString *)contentType andWithData:(NSString *)data;
- (void) createMessage:(NSString *)message withRange:(NSString *)range;
- (IBAction)onSaveTapped:(id)sender;
- (IBAction)onDateTapped:(id)sender;

@end
