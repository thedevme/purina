//
//  MedicalViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import <UIKit/UIKit.h>
#import "DateOwnedPicker.h"

@class TPKeyboardAvoidingScrollView;
@class PetData;
@class AddMedicalInfoViewController;
@class AddMedicalItemViewController;
@class PetModel;

//@protocol MedicalViewController <NSObject>
//
////- (void)didDismissModalView;
//- (void) saveIdentificationData:(PetData *)petData;
//
//@end

@interface MedicalViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>




//@property (nonatomic, assign) id<PetInfoFormDelegate> delegate;

@property (nonatomic, retain) PetData* objPetData;
@property (strong, nonatomic) IBOutlet UITableView *medicalTableView;
@property(nonatomic, strong) NSMutableArray *sections;

@property(nonatomic, strong) AddMedicalItemViewController *addMedicalItem;
@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property(nonatomic, strong) PetModel *petModel;
@end

