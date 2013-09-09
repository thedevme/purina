//
//  CreateMedicalItemViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import <UIKit/UIKit.h>
#import "IBAFormViewController.h"
#import "CreateDosagePickerDataSource.h" 
#import "CreateDatePickerDataSource.h"
#import "CreateSingleItemDataSource.h"

@class CreateDatePickerDataSource;
@class MedicalData;
@class CreateSingleItemDataSource;

@interface CreateMedicalItemViewController : IBAFormViewController  <CreateDosageDataSourceDelegate, CreateDatePickerDataSourceDelegate, CreateSingleItemDataSourceDelegate>


@property (nonatomic, retain) CreateDosagePickerDataSource * dosageDataSource;
@property (nonatomic, retain) CreateDatePickerDataSource * datePickerDataSource;
@property (nonatomic, retain) CreateSingleItemDataSource * singleItemDataSource;
@property (nonatomic, retain) NSString *contentType;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) MedicalData *objMedicalData;
@property (nonatomic, retain) UITextView *txtMedical;

@property(nonatomic, strong) UIBarButtonItem *btnSave;
@end
