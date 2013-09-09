// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pet.m instead.

#import "_Pet.h"

const struct PetAttributes PetAttributes = {
	.birthday = @"birthday",
	.breed = @"breed",
	.chipNo = @"chipNo",
	.coatMarkings = @"coatMarkings",
	.color = @"color",
	.dateAdded = @"dateAdded",
	.diet = @"diet",
	.emergencyVet = @"emergencyVet",
	.eyeColor = @"eyeColor",
	.gender = @"gender",
	.guid = @"guid",
	.imageData = @"imageData",
	.insurance = @"insurance",
	.licenseNo = @"licenseNo",
	.name = @"name",
	.notes = @"notes",
	.owned = @"owned",
	.pedigree = @"pedigree",
	.photo = @"photo",
	.price = @"price",
	.primaryGroomer = @"primaryGroomer",
	.primaryKennel = @"primaryKennel",
	.primaryVet = @"primaryVet",
	.spayedNeutered = @"spayedNeutered",
	.species = @"species",
	.tagNo = @"tagNo",
	.weight = @"weight",
};

const struct PetRelationships PetRelationships = {
	.appointment = @"appointment",
	.contact = @"contact",
	.petItem = @"petItem",
};

const struct PetFetchedProperties PetFetchedProperties = {
};

@implementation PetID
@end

@implementation _Pet

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pet";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:moc_];
}

- (PetID*)objectID {
	return (PetID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"spayedNeuteredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"spayedNeutered"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic birthday;






@dynamic breed;






@dynamic chipNo;






@dynamic coatMarkings;






@dynamic color;






@dynamic dateAdded;






@dynamic diet;






@dynamic emergencyVet;






@dynamic eyeColor;






@dynamic gender;






@dynamic guid;






@dynamic imageData;






@dynamic insurance;






@dynamic licenseNo;






@dynamic name;






@dynamic notes;






@dynamic owned;






@dynamic pedigree;






@dynamic photo;






@dynamic price;






@dynamic primaryGroomer;






@dynamic primaryKennel;






@dynamic primaryVet;






@dynamic spayedNeutered;



- (BOOL)spayedNeuteredValue {
	NSNumber *result = [self spayedNeutered];
	return [result boolValue];
}

- (void)setSpayedNeuteredValue:(BOOL)value_ {
	[self setSpayedNeutered:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSpayedNeuteredValue {
	NSNumber *result = [self primitiveSpayedNeutered];
	return [result boolValue];
}

- (void)setPrimitiveSpayedNeuteredValue:(BOOL)value_ {
	[self setPrimitiveSpayedNeutered:[NSNumber numberWithBool:value_]];
}





@dynamic species;






@dynamic tagNo;






@dynamic weight;






@dynamic appointment;

	
- (NSMutableSet*)appointmentSet {
	[self willAccessValueForKey:@"appointment"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"appointment"];
  
	[self didAccessValueForKey:@"appointment"];
	return result;
}
	

@dynamic contact;

	
- (NSMutableSet*)contactSet {
	[self willAccessValueForKey:@"contact"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contact"];
  
	[self didAccessValueForKey:@"contact"];
	return result;
}
	

@dynamic petItem;

	
- (NSMutableSet*)petItemSet {
	[self willAccessValueForKey:@"petItem"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"petItem"];
  
	[self didAccessValueForKey:@"petItem"];
	return result;
}
	






@end
