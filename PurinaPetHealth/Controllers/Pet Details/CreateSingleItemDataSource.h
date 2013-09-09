//
//  CreateDatePickerDataSource.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import <Foundation/Foundation.h>
#import <IBAForms/IBAFormDataSource.h>
#import "CreateSingleItemDataSource.h"

@class MedicalData;

@protocol CreateSingleItemDataSourceDelegate <NSObject>

- (void) saveMedialData:(MedicalData *)data;

@end

@interface CreateSingleItemDataSource : IBAFormDataSource

@property (assign) id <CreateSingleItemDataSourceDelegate> delegate;
@property (nonatomic, retain) MedicalData *objMedicalData;

@end
