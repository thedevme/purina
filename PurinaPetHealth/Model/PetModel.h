//
//  PetModel.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Pet.h"

@class PetData;
@class MedicalData;
@class ContactData;

@interface PetModel : NSObject

@property (nonatomic, retain) NSManagedObject* managedObjectModel;
@property (nonatomic, retain) CoreDataStack* dataStack;

- (NSArray *) getPetData;
- (PetData *)savePetData:(PetData *)data;
- (PetData *)savePet:(PetData *)data;
- (PetData *)saveMedicalItem:(MedicalData *)item withPet:(PetData *)pet;
- (PetData *) saveMedicalMisc:(MedicalData *)item withPet:(PetData *)pet;

- (void)updateContact:(ContactData *)data;
- (PetData *) updatePet:(PetData *)data;
- (void) deleteMedicalItem:(MedicalData *)medicalData;
- (void) deletePet:(PetData *)petData;
- (PetData *) getPetByID:(PetData *)data;
- (Pet *) getPetDataByID:(Pet *)data withDataStack:(CoreDataStack *)datastack;
- (void)updateMedicalItem:(MedicalData *)data;

- (ContactData *)getContactByID:(NSString *)guid;

@end
