// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.h instead.

#import <CoreData/CoreData.h>


extern const struct ContactAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *contentType;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *guid;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *listingID;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *primary;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *streetAddress;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *zipCode;
} ContactAttributes;

extern const struct ContactRelationships {
	__unsafe_unretained NSString *pet;
} ContactRelationships;

extern const struct ContactFetchedProperties {
} ContactFetchedProperties;

@class Pet;
















@interface ContactID : NSManagedObjectID {}
@end

@interface _Contact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ContactID*)objectID;




@property (nonatomic, strong) NSString* city;


//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* contentType;


//- (BOOL)validateContentType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* guid;


//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* latitude;


@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* listingID;


@property int64_t listingIDValue;
- (int64_t)listingIDValue;
- (void)setListingIDValue:(int64_t)value_;

//- (BOOL)validateListingID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* longitude;


@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* phone;


//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* primary;


@property BOOL primaryValue;
- (BOOL)primaryValue;
- (void)setPrimaryValue:(BOOL)value_;

//- (BOOL)validatePrimary:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* state;


//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* streetAddress;


//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* zipCode;


//- (BOOL)validateZipCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* pet;

- (NSMutableSet*)petSet;





@end

@interface _Contact (CoreDataGeneratedAccessors)

- (void)addPet:(NSSet*)value_;
- (void)removePet:(NSSet*)value_;
- (void)addPetObject:(Pet*)value_;
- (void)removePetObject:(Pet*)value_;

@end

@interface _Contact (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveContentType;
- (void)setPrimitiveContentType:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;




- (NSNumber*)primitiveListingID;
- (void)setPrimitiveListingID:(NSNumber*)value;

- (int64_t)primitiveListingIDValue;
- (void)setPrimitiveListingIDValue:(int64_t)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;




- (NSNumber*)primitivePrimary;
- (void)setPrimitivePrimary:(NSNumber*)value;

- (BOOL)primitivePrimaryValue;
- (void)setPrimitivePrimaryValue:(BOOL)value_;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSString*)primitiveZipCode;
- (void)setPrimitiveZipCode:(NSString*)value;





- (NSMutableSet*)primitivePet;
- (void)setPrimitivePet:(NSMutableSet*)value;


@end
