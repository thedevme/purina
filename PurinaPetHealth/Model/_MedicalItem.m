// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MedicalItem.m instead.

#import "_MedicalItem.h"

const struct MedicalItemAttributes MedicalItemAttributes = {
	.category = @"category",
	.data = @"data",
	.date = @"date",
	.dateAdded = @"dateAdded",
	.display = @"display",
	.dosage = @"dosage",
	.guid = @"guid",
	.type = @"type",
	.value = @"value",
};

const struct MedicalItemRelationships MedicalItemRelationships = {
	.pet = @"pet",
};

const struct MedicalItemFetchedProperties MedicalItemFetchedProperties = {
};

@implementation MedicalItemID
@end

@implementation _MedicalItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MedicalItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MedicalItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MedicalItem" inManagedObjectContext:moc_];
}

- (MedicalItemID*)objectID {
	return (MedicalItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic category;






@dynamic data;






@dynamic date;






@dynamic dateAdded;






@dynamic display;






@dynamic dosage;






@dynamic guid;






@dynamic type;






@dynamic value;






@dynamic pet;

	






@end
