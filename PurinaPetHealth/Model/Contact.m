
#import "Contact.h"
#import "CoreDataStack.h"

@implementation Contact
// Custom logic goes here.


+ (NSArray *) getContactData:(NSString *)type
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                              inManagedObjectContext:dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [dataStack.managedObjectContext executeFetchRequest:request error:&error];
    
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == %@", type];
    NSArray *arrContacts = [array filteredArrayUsingPredicate:typePredicate];
    
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSMutableArray* arrContactsData = [[NSMutableArray alloc] initWithArray:[arrContacts sortedArrayUsingDescriptors:sortDescriptors]];
    NSMutableArray *contact = [[NSMutableArray alloc] init];

    //Contacts
    for (int j = 0; j < [arrContactsData count]; j++)
    {
        ContactData* objContactData = [[ContactData alloc] init];
        Contact *objContact = [arrContactsData objectAtIndex:j];
        objContactData.name = [objContact name];
        objContactData.city = [objContact city];
        objContactData.contentType = [objContact contentType];
        objContactData.type = [objContact type];
        objContactData.email = [objContact email];
        objContactData.guid = [objContact guid];
        objContactData.longCoordinate = [[objContact longitude] floatValue];
        objContactData.latCoordinate = [[objContact latitude] floatValue];
        objContactData.phone = [objContact phone];
        objContactData.listingID = [objContact listingID];
        objContactData.state = [objContact state];
        objContactData.streetAddress = [objContact streetAddress];
        objContactData.zipCode = [[objContact zipCode] intValue];
        //NSLog(@"create contact %i", j+1);

        [contact addObject:objContactData];
    }
    
    //NSLog(@"there are %i number of contacts saved", [arrContacts count]);
    
    return contact;
}

+ (Contact *) checkContact:(ContactData *)data
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                              inManagedObjectContext:dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"name == %@", [data name]];
    NSArray *arrContacts = [array filteredArrayUsingPredicate:typePredicate];
    Contact* objContact = [arrContacts lastObject];
    
    return objContact;
}



+ (BOOL) isContactAdded:(int)listingID
{
    CoreDataStack* dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    dataStack.coreDataStoreType = CDSStoreTypeSQL;
    //NSLog(@"listing ID: %i", listingID);
    
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Contact"
                                              inManagedObjectContext:dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [dataStack.managedObjectContext executeFetchRequest:request error:&error];
    
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"listingID == %i", listingID];
    NSArray *arrContacts = [array filteredArrayUsingPredicate:typePredicate];
    
    if ([arrContacts count] > 0) return TRUE;
    
    return FALSE;
}




@end
