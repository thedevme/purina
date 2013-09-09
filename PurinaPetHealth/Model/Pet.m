#import "Pet.h"

@implementation Pet

// Custom logic goes here.


- (NSManagedObjectID *)permID {
    if ([[self objectID] isTemporaryID]) {
        // Save myself, returning nil if there are errors
    }
    return [self objectID];
}


+ (NSArray *) getPetData
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Pet"
                                              inManagedObjectContext:dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [dataStack.managedObjectContext executeFetchRequest:request error:&error];
    
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray* arrPetsData = [array sortedArrayUsingDescriptors:sortDescriptors];
    
    return arrPetsData;
}


+ (void) deletePet:(Pet *)pet
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    [dataStack.managedObjectContext deleteObject:pet];
}

@end
