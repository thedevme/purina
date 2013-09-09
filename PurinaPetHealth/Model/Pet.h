#import "_Pet.h"
#import "CoreDataStack.h"

@interface Pet : _Pet {}
// Custom logic goes here.

- (NSManagedObjectID *)permID;
+ (NSArray *) getPetData;
+ (void) deletePet:(Pet *)pet;

@end
