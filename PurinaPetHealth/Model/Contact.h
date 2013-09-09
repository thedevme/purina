#import "_Contact.h"
#import "ContactData.h"

@interface Contact : _Contact {}
// Custom logic goes here.



+ (NSArray *) getContactData:(NSString *)type;
+ (BOOL) isContactAdded:(int)listingID;
+ (Contact *) checkContact:(ContactData *)data;
//+ (Contact *) checkContact:(ContactData *)strData byPet:(Pet *)pet;

@end
