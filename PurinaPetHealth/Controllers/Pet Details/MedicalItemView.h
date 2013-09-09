//
//  MedicalItemView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import <UIKit/UIKit.h>

@class MedicalData;
@class PetModel;

@protocol DualMedicalItemDelegate <NSObject>

- (void)createNewMedWithType:(NSString *)type andContentType:(NSString *)contentType;
- (void)updateTextWithType:(NSString *)type withContentType:(NSString *)contentType andData:(NSString *)data;
- (void) deleteMedicalItem;

@end

@interface MedicalItemView : UIView <UIAlertViewDelegate>



@property (nonatomic, assign) int height;
@property (nonatomic, assign) int count;
@property (nonatomic, weak) id <DualMedicalItemDelegate> delegate;



@property(nonatomic, copy) NSString *contentType;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *type;

@property(nonatomic, strong) NSMutableArray *medicalItems;
@property(nonatomic, strong) UILabel *lblData;

@property(nonatomic, strong) MedicalData *objMedicalData;

@property(nonatomic, copy) NSString *strData;

@property(nonatomic, strong) PetModel *petModel;

- (id)initWithArray:(NSArray *)data withTitle:(NSString *)title andType:(NSString *)type;
- (void) addNewItem:(MedicalData *)data;
- (void) updateNewItem:(MedicalData *)data;
- (id)initWithData:(NSString *)data withTitle:(NSString *)title andType:(NSString *)contentType;


@end
