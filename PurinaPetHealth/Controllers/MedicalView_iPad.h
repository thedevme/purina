//
//  MedicalView_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
//
//

#import <UIKit/UIKit.h>

@class PetData;

@protocol MedicalCategoryDelegate <NSObject>

@required
- (void) viewSelectedCategory:(NSString *)category;
@end



@interface MedicalView_iPad : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, weak) id <MedicalCategoryDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *sections;
@property(nonatomic, strong) PetData *objPetData;

- (id)initWithPetData:(PetData *)pet;

- (void)resetMedical:(PetData *)data;
@end
