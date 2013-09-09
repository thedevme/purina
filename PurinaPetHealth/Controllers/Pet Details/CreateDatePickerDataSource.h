//
//  CreateDatePickerDataSource.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import <Foundation/Foundation.h>
#import <IBAForms/IBAFormDataSource.h>
#import "CreateDosagePickerDataSource.h"
 
@class MedicalData;

@protocol CreateDatePickerDataSourceDelegate <NSObject>

- (void) saveMedialData:(MedicalData *)data;

@end

@interface CreateDatePickerDataSource : IBAFormDataSource

@property (assign) id <CreateDatePickerDataSourceDelegate> delegate;
@property (nonatomic, retain) MedicalData *objMedicalData;

@end
