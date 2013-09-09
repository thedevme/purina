// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pet.h instead.

#import <CoreData/CoreData.h>


extern const struct PetAttributes {
	__unsafe_unretained NSString *birthday;
	__unsafe_unretained NSString *breed;
	__unsafe_unretained NSString *chipNo;
	__unsafe_unretained NSString *coatMarkings;
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *dateAdded;
	__unsafe_unretained NSString *diet;
	__unsafe_unretained NSString *emergencyVet;
	__unsafe_unretained NSString *eyeColor;
	__unsafe_unretained NSString *gender;
	__unsafe_unretained NSString *guid;
	__unsafe_unretained NSString *imageData;
	__unsafe_unretained NSString *insurance;
	__unsafe_unretained NSString *licenseNo;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *owned;
	__unsafe_unretained NSString *pedigree;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *primaryGroomer;
	__unsafe_unretained NSString *primaryKennel;
	__unsafe_unretained NSString *primaryVet;
	__unsafe_unretained NSString *spayedNeutered;
	__unsafe_unretained NSString *species;
	__unsafe_unretained NSString *tagNo;
	__unsafe_unretained NSString *weight;
} PetAttributes;

extern const struct PetRelationships {
	__unsafe_unretained NSString *appointment;
	__unsafe_unretained NSString *contact;
	__unsafe_unretained NSString *petItem;
} PetRelationships;

extern const struct PetFetchedProperties {
} PetFetchedProperties;

@class Appointment;
@class Contact;
@class MedicalItem;





























@interface PetID : NSManagedObjectID {}
@end

@interface _Pet : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PetID*)objectID;




@property (nonatomic, strong) NSString* birthday;


//- (BOOL)validateBirthday:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* breed;


//- (BOOL)validateBreed:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* chipNo;


//- (BOOL)validateChipNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* coatMarkings;


//- (BOOL)validateCoatMarkings:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* color;


//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* dateAdded;


//- (BOOL)validateDateAdded:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* diet;


//- (BOOL)validateDiet:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* emergencyVet;


//- (BOOL)validateEmergencyVet:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* eyeColor;


//- (BOOL)validateEyeColor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* gender;


//- (BOOL)validateGender:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* guid;


//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSData* imageData;


//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* insurance;


//- (BOOL)validateInsurance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* licenseNo;


//- (BOOL)validateLicenseNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* notes;


//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* owned;


//- (BOOL)validateOwned:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* pedigree;


//- (BOOL)validatePedigree:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSData* photo;


//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* price;


//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* primaryGroomer;


//- (BOOL)validatePrimaryGroomer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* primaryKennel;


//- (BOOL)validatePrimaryKennel:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* primaryVet;


//- (BOOL)validatePrimaryVet:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* spayedNeutered;


@property BOOL spayedNeuteredValue;
- (BOOL)spayedNeuteredValue;
- (void)setSpayedNeuteredValue:(BOOL)value_;

//- (BOOL)validateSpayedNeutered:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* species;


//- (BOOL)validateSpecies:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* tagNo;


//- (BOOL)validateTagNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* weight;


//- (BOOL)validateWeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* appointment;

- (NSMutableSet*)appointmentSet;




@property (nonatomic, strong) NSSet* contact;

- (NSMutableSet*)contactSet;




@property (nonatomic, strong) NSSet* petItem;

- (NSMutableSet*)petItemSet;





@end

@interface _Pet (CoreDataGeneratedAccessors)

- (void)addAppointment:(NSSet*)value_;
- (void)removeAppointment:(NSSet*)value_;
- (void)addAppointmentObject:(Appointment*)value_;
- (void)removeAppointmentObject:(Appointment*)value_;

- (void)addContact:(NSSet*)value_;
- (void)removeContact:(NSSet*)value_;
- (void)addContactObject:(Contact*)value_;
- (void)removeContactObject:(Contact*)value_;

- (void)addPetItem:(NSSet*)value_;
- (void)removePetItem:(NSSet*)value_;
- (void)addPetItemObject:(MedicalItem*)value_;
- (void)removePetItemObject:(MedicalItem*)value_;

@end

@interface _Pet (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBirthday;
- (void)setPrimitiveBirthday:(NSString*)value;




- (NSString*)primitiveBreed;
- (void)setPrimitiveBreed:(NSString*)value;




- (NSString*)primitiveChipNo;
- (void)setPrimitiveChipNo:(NSString*)value;




- (NSString*)primitiveCoatMarkings;
- (void)setPrimitiveCoatMarkings:(NSString*)value;




- (NSString*)primitiveColor;
- (void)setPrimitiveColor:(NSString*)value;




- (NSDate*)primitiveDateAdded;
- (void)setPrimitiveDateAdded:(NSDate*)value;




- (NSString*)primitiveDiet;
- (void)setPrimitiveDiet:(NSString*)value;




- (NSString*)primitiveEmergencyVet;
- (void)setPrimitiveEmergencyVet:(NSString*)value;




- (NSString*)primitiveEyeColor;
- (void)setPrimitiveEyeColor:(NSString*)value;




- (NSString*)primitiveGender;
- (void)setPrimitiveGender:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;




- (NSString*)primitiveInsurance;
- (void)setPrimitiveInsurance:(NSString*)value;




- (NSString*)primitiveLicenseNo;
- (void)setPrimitiveLicenseNo:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;




- (NSString*)primitiveOwned;
- (void)setPrimitiveOwned:(NSString*)value;




- (NSString*)primitivePedigree;
- (void)setPrimitivePedigree:(NSString*)value;




- (NSData*)primitivePhoto;
- (void)setPrimitivePhoto:(NSData*)value;




- (NSString*)primitivePrice;
- (void)setPrimitivePrice:(NSString*)value;




- (NSString*)primitivePrimaryGroomer;
- (void)setPrimitivePrimaryGroomer:(NSString*)value;




- (NSString*)primitivePrimaryKennel;
- (void)setPrimitivePrimaryKennel:(NSString*)value;




- (NSString*)primitivePrimaryVet;
- (void)setPrimitivePrimaryVet:(NSString*)value;




- (NSNumber*)primitiveSpayedNeutered;
- (void)setPrimitiveSpayedNeutered:(NSNumber*)value;

- (BOOL)primitiveSpayedNeuteredValue;
- (void)setPrimitiveSpayedNeuteredValue:(BOOL)value_;




- (NSString*)primitiveSpecies;
- (void)setPrimitiveSpecies:(NSString*)value;




- (NSString*)primitiveTagNo;
- (void)setPrimitiveTagNo:(NSString*)value;




- (NSString*)primitiveWeight;
- (void)setPrimitiveWeight:(NSString*)value;





- (NSMutableSet*)primitiveAppointment;
- (void)setPrimitiveAppointment:(NSMutableSet*)value;



- (NSMutableSet*)primitiveContact;
- (void)setPrimitiveContact:(NSMutableSet*)value;



- (NSMutableSet*)primitivePetItem;
- (void)setPrimitivePetItem:(NSMutableSet*)value;


@end
