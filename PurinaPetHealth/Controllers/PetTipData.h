//
// Created by craigclayton on 12/17/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class TipData;


@interface PetTipData : NSObject

@property (nonatomic, retain) TipData* data;
@property (assign) NSInteger position;
@property (nonatomic, retain) NSMutableArray* categoryArray;
@property (nonatomic, retain) NSMutableArray *filteredArray;
@property (nonatomic, retain) NSMutableArray *fullArray;
@property (nonatomic, retain) NSMutableArray *tipCategoriesArray;
@property (nonatomic, retain) NSString *selectedCategory;

@end