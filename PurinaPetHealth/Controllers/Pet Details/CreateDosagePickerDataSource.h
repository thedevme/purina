//
//  CreateDosagePickerDataSource.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/17/12.
//
//
 
#import <Foundation/Foundation.h>
#import <IBAForms/IBAFormDataSource.h>

@class MedicalData;

@protocol CreateDosageDataSourceDelegate <NSObject>

- (void) saveMedialDosage:(MedicalData *)data;

@end

@interface CreateDosagePickerDataSource : IBAFormDataSource

@property (nonatomic, retain) MedicalData *objMedicalData;
@property (assign) id <CreateDosageDataSourceDelegate> delegate;

@end
