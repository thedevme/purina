// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.m instead.

#import "_Contact.h"

const struct ContactAttributes ContactAttributes = {
	.city = @"city",
	.contentType = @"contentType",
	.email = @"email",
	.guid = @"guid",
	.latitude = @"latitude",
	.listingID = @"listingID",
	.longitude = @"longitude",
	.name = @"name",
	.phone = @"phone",
	.primary = @"primary",
	.state = @"state",
	.streetAddress = @"streetAddress",
	.type = @"type",
	.zipCode = @"zipCode",
};

const struct ContactRelationships ContactRelationships = {
	.pet = @"pet",
};

const struct ContactFetchedProperties ContactFetchedProperties = {
};

@implementation ContactID
@end

@implementation _Contact

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contact";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc_];
}

- (ContactID*)objectID {
	return (ContactID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"listingIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"listingID"];
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






@dynamic contentType;






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





@dynamic listingID;



- (int64_t)listingIDValue {
	NSNumber *result = [self listingID];
	return [result longLongValue];
}

- (void)setListingIDValue:(int64_t)value_ {
	[self setListingID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveListingIDValue {
	NSNumber *result = [self primitiveListingID];
	return [result longLongValue];
}

- (void)setPrimitiveListingIDValue:(int64_t)value_ {
	[self setPrimitiveListingID:[NSNumber numberWithLongLong:value_]];
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






@dynamic pet;

	
- (NSMutableSet*)petSet {
	[self willAccessValueForKey:@"pet"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pet"];
  
	[self didAccessValueForKey:@"pet"];
	return result;
}
	






@end
