//
//  EmergencyVetModel.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/26/12.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "EmergencyVet.h"

@class ContactData;

@interface EmergencyVetModel : NSObject


@property (nonatomic, retain) CoreDataStack* dataStack;

- (ContactData *) getEmergencyVet;
- (void) saveEmergencyVet:(ContactData *)emergencyData;

@end
