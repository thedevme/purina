// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MedicalItem.h instead.

#import <CoreData/CoreData.h>


extern const struct MedicalItemAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *data;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *dateAdded;
	__unsafe_unretained NSString *display;
	__unsafe_unretained NSString *dosage;
	__unsafe_unretained NSString *guid;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *value;
} MedicalItemAttributes;

extern const struct MedicalItemRelationships {
	__unsafe_unretained NSString *pet;
} MedicalItemRelationships;

extern const struct MedicalItemFetchedProperties {
} MedicalItemFetchedProperties;

@class Pet;











@interface MedicalItemID : NSManagedObjectID {}
@end

@interface _MedicalItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MedicalItemID*)objectID;




@property (nonatomic, strong) NSString* category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* data;


//- (BOOL)validateData:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* date;


//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateAdded;


//- (BOOL)validateDateAdded:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* display;


//- (BOOL)validateDisplay:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* dosage;


//- (BOOL)validateDosage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* guid;


//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* value;


//- (BOOL)validateValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Pet* pet;

//- (BOOL)validatePet:(id*)value_ error:(NSError**)error_;





@end

@interface _MedicalItem (CoreDataGeneratedAccessors)

@end

@interface _MedicalItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSString*)primitiveData;
- (void)setPrimitiveData:(NSString*)value;




- (NSString*)primitiveDate;
- (void)setPrimitiveDate:(NSString*)value;




- (NSDate*)primitiveDateAdded;
- (void)setPrimitiveDateAdded:(NSDate*)value;




- (NSString*)primitiveDisplay;
- (void)setPrimitiveDisplay:(NSString*)value;




- (NSString*)primitiveDosage;
- (void)setPrimitiveDosage:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;





- (Pet*)primitivePet;
- (void)setPrimitivePet:(Pet*)value;


@end
