// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appointment.m instead.

#import "_Appointment.h"

const struct AppointmentAttributes AppointmentAttributes = {
	.alert = @"alert",
	.appointmentDate = @"appointmentDate",
	.endDate = @"endDate",
	.guid = @"guid",
	.notes = @"notes",
	.repeat = @"repeat",
	.saveToCalendar = @"saveToCalendar",
	.startDate = @"startDate",
	.time = @"time",
	.title = @"title",
	.type = @"type",
};

const struct AppointmentRelationships AppointmentRelationships = {
	.pet = @"pet",
};

const struct AppointmentFetchedProperties AppointmentFetchedProperties = {
};

@implementation AppointmentID
@end

@implementation _Appointment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Appointment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Appointment" inManagedObjectContext:moc_];
}

- (AppointmentID*)objectID {
	return (AppointmentID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"saveToCalendarValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"saveToCalendar"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic alert;






@dynamic appointmentDate;






@dynamic endDate;






@dynamic guid;






@dynamic notes;






@dynamic repeat;






@dynamic saveToCalendar;



- (BOOL)saveToCalendarValue {
	NSNumber *result = [self saveToCalendar];
	return [result boolValue];
}

- (void)setSaveToCalendarValue:(BOOL)value_ {
	[self setSaveToCalendar:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSaveToCalendarValue {
	NSNumber *result = [self primitiveSaveToCalendar];
	return [result boolValue];
}

- (void)setPrimitiveSaveToCalendarValue:(BOOL)value_ {
	[self setPrimitiveSaveToCalendar:[NSNumber numberWithBool:value_]];
}





@dynamic startDate;






@dynamic time;






@dynamic title;






@dynamic type;






@dynamic pet;

	
- (NSMutableSet*)petSet {
	[self willAccessValueForKey:@"pet"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pet"];
  
	[self didAccessValueForKey:@"pet"];
	return result;
}
	






@end
