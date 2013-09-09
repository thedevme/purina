//
//  PetTipScrollerData.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/18/12.
//
//

#import <Foundation/Foundation.h>

@interface PetTipScrollerData : NSObject

@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (nonatomic, retain) NSMutableArray *fullArray;
@property (nonatomic, retain) NSString *title;
@property (assign) int selectedPosition;
@property (assign) BOOL isSelectedPositionUSed;

@end
