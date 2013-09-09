//
//  MedicalItemsView_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>

@class PetModel;
@class MedicalData;
@class PetData;

@protocol MedicalItemsDelegate <NSObject>
- (void) close;
@end

@interface MedicalItemsView_iPad : UIView <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *medicalItems;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) PetModel *petModel;
@property(nonatomic, strong) MedicalData *objMedicalData;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *contentType;
@property(nonatomic, copy) NSString *data;
@property(nonatomic, strong) PetData *objPetData;

@property (nonatomic, assign) id<MedicalItemsDelegate> delegate;

- (void)initializeWithPetData:(PetData *)pet withContentType:(NSString *)contentType withType:(NSString *)type andData:(NSString *)data;

@end
