// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appointment.h instead.

#import <CoreData/CoreData.h>


extern const struct AppointmentAttributes {
	__unsafe_unretained NSString *alert;
	__unsafe_unretained NSString *appointmentDate;
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *guid;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *repeat;
	__unsafe_unretained NSString *saveToCalendar;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *time;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *type;
} AppointmentAttributes;

extern const struct AppointmentRelationships {
	__unsafe_unretained NSString *pet;
} AppointmentRelationships;

extern const struct AppointmentFetchedProperties {
} AppointmentFetchedProperties;

@class Pet;













@interface AppointmentID : NSManagedObjectID {}
@end

@interface _Appointment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AppointmentID*)objectID;




@property (nonatomic, strong) NSString* alert;


//- (BOOL)validateAlert:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* appointmentDate;


//- (BOOL)validateAppointmentDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* endDate;


//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* guid;


//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* notes;


//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* repeat;


//- (BOOL)validateRepeat:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* saveToCalendar;


@property BOOL saveToCalendarValue;
- (BOOL)saveToCalendarValue;
- (void)setSaveToCalendarValue:(BOOL)value_;

//- (BOOL)validateSaveToCalendar:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* startDate;


//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* time;


//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* pet;

- (NSMutableSet*)petSet;





@end

@interface _Appointment (CoreDataGeneratedAccessors)

- (void)addPet:(NSSet*)value_;
- (void)removePet:(NSSet*)value_;
- (void)addPetObject:(Pet*)value_;
- (void)removePetObject:(Pet*)value_;

@end

@interface _Appointment (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAlert;
- (void)setPrimitiveAlert:(NSString*)value;




- (NSString*)primitiveAppointmentDate;
- (void)setPrimitiveAppointmentDate:(NSString*)value;




- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;




- (NSString*)primitiveRepeat;
- (void)setPrimitiveRepeat:(NSString*)value;




- (NSNumber*)primitiveSaveToCalendar;
- (void)setPrimitiveSaveToCalendar:(NSNumber*)value;

- (BOOL)primitiveSaveToCalendarValue;
- (void)setPrimitiveSaveToCalendarValue:(BOOL)value_;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;




- (NSString*)primitiveTime;
- (void)setPrimitiveTime:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (NSMutableSet*)primitivePet;
- (void)setPrimitivePet:(NSMutableSet*)value;


@end
