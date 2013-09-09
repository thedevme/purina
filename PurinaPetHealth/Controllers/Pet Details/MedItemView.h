//
//  MedItemView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/24/12.
//
//

#import <Foundation/Foundation.h>

@class MedicalData;

@interface MedItemView : UIView

@property (nonatomic, retain) MedicalData* objMedicalData;

- (id)initWithData:(MedicalData *)data;

@end
