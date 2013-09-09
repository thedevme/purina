// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmergencyVet.m instead.

#import "_EmergencyVet.h"

const struct EmergencyVetAttributes EmergencyVetAttributes = {
	.city = @"city",
	.email = @"email",
	.guid = @"guid",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.name = @"name",
	.phone = @"phone",
	.primary = @"primary",
	.state = @"state",
	.streetAddress = @"streetAddress",
	.type = @"type",
	.zipCode = @"zipCode",
};

const struct EmergencyVetRelationships EmergencyVetRelationships = {
};

const struct EmergencyVetFetchedProperties EmergencyVetFetchedProperties = {
};

@implementation EmergencyVetID
@end

@implementation _EmergencyVet

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EmergencyVet" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EmergencyVet";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EmergencyVet" inManagedObjectContext:moc_];
}

- (EmergencyVetID*)objectID {
	return (EmergencyVetID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"primaryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"primary"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic city;






@dynamic email;






@dynamic guid;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





@dynamic name;






@dynamic phone;






@dynamic primary;



- (BOOL)primaryValue {
	NSNumber *result = [self primary];
	return [result boolValue];
}

- (void)setPrimaryValue:(BOOL)value_ {
	[self setPrimary:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePrimaryValue {
	NSNumber *result = [self primitivePrimary];
	return [result boolValue];
}

- (void)setPrimitivePrimaryValue:(BOOL)value_ {
	[self setPrimitivePrimary:[NSNumber numberWithBool:value_]];
}





@dynamic state;






@dynamic streetAddress;






@dynamic type;






@dynamic zipCode;











@end
