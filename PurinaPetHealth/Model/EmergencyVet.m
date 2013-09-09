#import "EmergencyVet.h"
#import "CoreDataStack.h"

@implementation EmergencyVet

// Custom logic goes here.



+ (NSArray *) getEmergencyData:(NSString *)type
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;

    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"EmergencyVet"
   inManagedObjectContext:dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [dataStack.managedObjectContext executeFetchRequest:request error:&error];

    return array;
}

@end
