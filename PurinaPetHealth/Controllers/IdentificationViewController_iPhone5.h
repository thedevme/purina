//
//  IdentificationViewController_iPhone5.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import <UIKit/UIKit.h>
#import <IBAForms/IBAForms.h>
#import "NSDate+Helper.h"
#import "PetListViewController.h"
#import "Pet.h"
#import "MyPetCell.h"
#import "DateOwnedPicker.h"
#import "ApptNotesViewController.h"
#import "ApptDetailsListViewController.h"
#import "AppointmentTypeData.h"
#import "AppointmentData.h"
#import "AppointmentUpdater.h"
#import "IdentificationDataSource.h"

@interface IdentificationViewController_iPhone5 : IBAFormViewController <IdentificationDataDelegate>


@property (nonatomic, retain) IdentificationDataSource* dataSource;
@property (nonatomic, retain) AppointmentData* objAppointmentData;

@end
