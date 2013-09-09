//
//  IdentificationDataSource.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import "IBAFormDataSource.h"
#import <IBAForms/IBAFormDataSource.h>
#import "AppointmentUpdater.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "Pet.h"

@protocol IdentificationDataDelegate <NSObject>

- (void) updateIdentificationData;

@end



@interface IdentificationDataSource : IBAFormDataSource

@property (nonatomic, retain) AppointmentUpdater* appointUpdater;
@property (assign) id <IdentificationDataDelegate> delegate;

@end
