//
//  AppointmentUpdater.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "AppointmentData.h"
#import "Appointment.h"
#import "PetModel.h"
#import "Pet.h"


@class AppointmentUpdater;

@protocol AppointmentDelegate <NSObject>
- (void)appointmentSaved;
- (void)appointmentUpdated;
@end



@interface AppointmentUpdater : NSObject


@property (nonatomic, retain) NSManagedObject* managedObjectModel;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (nonatomic, weak) id <AppointmentDelegate> delegate;

@property (nonatomic, retain) PetModel* petModel;

- (void) createAppointment:(AppointmentData *)data;
- (void) updateAppointment:(AppointmentData *)data;
- (void) deleteAppointment:(AppointmentData *)data;

- (NSArray *) getAppointments;


@end