//
//  EmergencyVetModel.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/26/12.
//
//

#import "EmergencyVetModel.h"
#import "EmergencyData.h"
#import "ContactData.h"

@implementation EmergencyVetModel

- (id) init
{
    self = [super init];

    if (self)
    {
        [self createModel];
    }

    return self;
}

- (void) createModel
{
    _dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    _dataStack.coreDataStoreType = CDSStoreTypeSQL;
}

- (ContactData *) getEmergencyVet
{
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"EmergencyVet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    //NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    EmergencyVet *emergencyVet = [[self.dataStack.managedObjectContext executeFetchRequest:request error:&error] lastObject];
    ContactData* emergencyData = [[ContactData alloc] init];
    
    emergencyData.name =  emergencyVet.name;
    emergencyData.streetAddress = emergencyVet.streetAddress;
    emergencyData.city = emergencyVet.city;
    emergencyData.email = emergencyVet.email;
    emergencyData.guid = emergencyVet.guid;
    emergencyData.phone = emergencyVet.phone;
    emergencyData.state = emergencyVet.state;
    emergencyData.latCoordinate = [emergencyVet.latitude floatValue];
    emergencyData.longCoordinate = [emergencyVet.longitude floatValue];
    emergencyData.type = emergencyVet.type;
    emergencyData.zipCode = [emergencyVet.zipCode intValue];
    
    return emergencyData;
}

- (void) saveEmergencyVet:(ContactData *)emergencyData
{
    EmergencyVet *objEmergencyVet = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([EmergencyVet class]) inManagedObjectContext:self.dataStack.managedObjectContext];

    objEmergencyVet.name =  emergencyData.name;
    objEmergencyVet.streetAddress = emergencyData.streetAddress;
    objEmergencyVet.city = emergencyData.city;
    objEmergencyVet.email = emergencyData.email;
    objEmergencyVet.guid = emergencyData.guid;
    objEmergencyVet.phone = emergencyData.phone;
    objEmergencyVet.state = emergencyData.state;
    objEmergencyVet.latitude = [NSNumber numberWithFloat:emergencyData.latCoordinate];
    objEmergencyVet.longitude = [NSNumber numberWithFloat:emergencyData.longCoordinate];
    objEmergencyVet.type = emergencyData.type;
    objEmergencyVet.zipCode = [NSString stringWithFormat:@"%i", emergencyData.zipCode];

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];
}

@end
