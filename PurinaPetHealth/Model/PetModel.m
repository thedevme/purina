//
//  PetModel.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import "PetModel.h"
#import "PetData.h"
#import "ContactData.h"
#import "Contact.h"
#import "MedicalItem.h"
#import "MedicalData.h"
#import "Constants.h"
#import "UniqueID.h"
#import "AppointmentData.h"
#import "Appointment.h"

@implementation PetModel

- (id) init
{
    self = [super init];
    
    if (self)
    {
        [self createModel];
        NSLog(@"create pet model");
    }
    
    return self;
}

- (void) createModel
{
    _dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    _dataStack.coreDataStoreType = CDSStoreTypeSQL;

    //[CoreDataStack coreDataStackWithDatabaseURL: _dataStack.databaseURL];
}


- (PetData *) getPetByID:(PetData *)data
{
    PetData* objPetData = data;
    //NSLog(@"get pet by id %@", data);
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    //NSLog(@"done getting pet now return");

    return [self convertPet:objPetData withPet:objPet];
}

- (Pet *) getPetDataByID:(Pet *)data withDataStack:(CoreDataStack *)datastack
{
    Pet* objPetData = data;
    //NSLog(@"get pet by id %@", data);
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:datastack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [datastack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    //NSLog(@"done getting pet now return");

    return objPet;
}

- (NSArray *) getPetData
{
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Pet"
                                              inManagedObjectContext:self.dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];

    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];

    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSMutableArray* arrPetsData = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    NSMutableArray *arrPets = [[NSMutableArray alloc] init];

    for (int i = 0; i < [arrPetsData count]; i++)
    {
        PetData *objPetData = [[PetData alloc] init];
        Pet *objPet = [arrPetsData objectAtIndex:i];
        NSLog(@"date added %@", [[arrPetsData objectAtIndex:i] dateAdded]);

        [arrPets addObject:[self convertPet:objPetData withPet:objPet]];
        //NSLog(@"name: %@", objPetData.name);
    }

    return arrPets;
}

- (PetData *) updatePet:(PetData *)data
{
    PetData* objPetData = data;
    NSLog(@"save %@", [objPetData guid]);
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    NSLog(@"you are updating pet %@", array);
    NSLog(@"this pet has %i total contacts", [[objPet.contact allObjects] count]);

    objPet.name = objPetData.name;
    objPet.gender = objPetData.gender;
    objPet.breed = objPetData.breed;
    objPet.chipNo = objPetData.chipNo;
    objPet.coatMarkings = objPetData.coatMarkings;
    objPet.color = objPetData.color;
    objPet.eyeColor = objPetData.eyeColor;
    objPet.pedigree = objPetData.pedigree;
    objPet.licenseNo = objPetData.licenseNo;
    objPet.primaryVet = objPetData.primaryVet;
    if ([objPetData.spayedNeutered isEqualToString:@"No"]) objPet.spayedNeutered = [NSNumber numberWithBool:NO];
    if ([objPetData.spayedNeutered isEqualToString:@"Yes"]) objPet.spayedNeutered = [NSNumber numberWithBool:YES];

    objPet.primaryKennel = objPetData.primaryKennel;
    objPet.primaryGroomer = objPetData.primaryGroomer;
    objPet.price = objPetData.price;
    objPet.species = objPetData.species;
    objPet.tagNo = objPetData.tagNo;
    objPet.weight = objPetData.weight;
    objPet.birthday = objPetData.birthday;

    objPet.guid = objPetData.guid;
    objPet.imageData = objPetData.imageData;

    NSArray *contacts = [objPet.contact allObjects];

    NSLog(@"before delete %i",contacts.count);

    for (NSManagedObject * contact in contacts) {
        [self.dataStack.managedObjectContext deleteObject:contact];
    }

    NSLog(@"after delete %i",contacts.count);



    for (int j = 0; j < [objPetData.contacts count]; j++)
    {
        ContactData* objContactData = [objPetData.contacts objectAtIndex:j];
        //Contact * objSavedContactData = [self getContactByID:objContactData.listingID];

        Contact *objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];

        NSLog(@"save new contact %@ name %@", objContactData, objContactData.name);
        objContact.name = [objContactData name];
        objContact.city = [objContactData city];
        objContact.contentType = [objContactData contentType];
        objContact.type = [objContactData type];
        objContact.email = [objContactData email];
        objContact.guid = [objContactData guid];
        //objContact.listingID = [objContactData listingID];
        objContact.longitude = [NSNumber numberWithFloat:objContactData.longCoordinate];
        objContact.latitude = [NSNumber numberWithFloat:objContactData.latCoordinate];
        objContact.phone = [objContactData phone];
        objContact.state = [objContactData state];
        objContact.streetAddress = [objContactData streetAddress];
        objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];

        [objPet addContactObject:objContact];
        [objContact addPetObject:objPet];

//        if (!objSavedContactData)
//        {
//            Contact *objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];
//
//            NSLog(@"save new contact %@ name %@", objContactData, objContactData.name);
//            objContact.name = [objContactData name];
//            objContact.city = [objContactData city];
//            objContact.contentType = [objContactData contentType];
//            objContact.type = [objContactData type];
//            objContact.email = [objContactData email];
//            objContact.guid = [objContactData guid];
//            objContact.listingID = [objContactData listingID];
//            objContact.longitude = [NSNumber numberWithFloat:objContactData.longCoordinate];
//            objContact.latitude = [NSNumber numberWithFloat:objContactData.latCoordinate];
//            objContact.phone = [objContactData phone];
//            objContact.state = [objContactData state];
//            objContact.streetAddress = [objContactData streetAddress];
//            objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];
//
//            [objPet addContactObject:objContact];
//            [objContact addPetObject:objPet];
//        }
//        else
//        {
//            NSLog(@"contact was found");
//            [objPet addContactObject:objSavedContactData];
//        }


    }

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];

    PetData *objConvertedPetData = [self convertPet:objPetData withPet:objPet];

    return objConvertedPetData;
}

- (PetData *)savePet:(PetData *)data
{
    PetData* objPetData = data;
    Pet *objPet = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Pet class]) inManagedObjectContext:self.dataStack.managedObjectContext];

    objPet.name = objPetData.name;
    objPet.gender = objPetData.gender;
    objPet.breed = objPetData.breed;
    objPet.chipNo = objPetData.chipNo;
    objPet.coatMarkings = objPetData.coatMarkings;
    objPet.color = objPetData.color;
    objPet.eyeColor = objPetData.eyeColor;
    objPet.dateAdded = [NSDate date];
    objPet.pedigree = objPetData.pedigree;
    objPet.licenseNo = objPetData.licenseNo;
    objPet.price = objPetData.price;
    objPet.species = objPetData.species;
    objPet.tagNo = objPetData.tagNo;


//    NSLog(@"save pet vet %@", objPetData.primaryVet);
//    NSLog(@"save pet groomer %@", objPetData.primaryGroomer);
//    NSLog(@"save pet kennel %@", objPetData.primaryKennel);
    objPet.primaryVet = objPetData.primaryVet;
    objPet.primaryGroomer = objPetData.primaryGroomer;
    objPet.primaryKennel = objPetData.primaryKennel;
    objPet.weight = objPetData.weight;
    objPet.birthday = objPetData.birthday;
    objPet.guid = objPetData.guid;
    objPet.imageData = objPetData.imageData;

    for (int j = 0; j < [objPetData.contacts count]; j++)
    {
//        ContactData* objContactData = [objPetData.contacts objectAtIndex:j];
//        Contact *objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];
//
//        objContact.name = [objContactData name];
//        objContact.city = [objContactData city];
//        objContact.contentType = [objContactData contentType];
//        objContact.type = [objContactData type];
//        objContact.email = [objContactData email];
//        objContact.guid = [objContactData guid];
//        objContact.listingID = [objContactData listingID];
//        objContact.longitude = [NSNumber numberWithFloat:objContactData.longCoordinate];
//        objContact.latitude = [NSNumber numberWithFloat:objContactData.latCoordinate];
//        objContact.phone = [objContactData phone];
//        objContact.state = [objContactData state];
//        objContact.streetAddress = [objContactData streetAddress];
//        objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];
//
//        [objPet addContactObject:objContact];
//        [objContact addPetObject:objPet];

        ContactData* objContactData = [objPetData.contacts objectAtIndex:j];
        Contact *objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];

        NSLog(@"save new contact %@ name %@", objContactData, objContactData.name);
        objContact.name = [objContactData name];
        objContact.city = [objContactData city];
        objContact.contentType = [objContactData contentType];
        objContact.type = [objContactData type];
        objContact.email = [objContactData email];
        objContact.guid = [objContactData guid];
        //objContact.listingID = [objContactData listingID];
        objContact.longitude = [NSNumber numberWithFloat:objContactData.longCoordinate];
        objContact.latitude = [NSNumber numberWithFloat:objContactData.latCoordinate];
        objContact.phone = [objContactData phone];
        objContact.state = [objContactData state];
        objContact.streetAddress = [objContactData streetAddress];
        objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];

        [objPet addContactObject:objContact];
        [objContact addPetObject:objPet];
//        ContactData * objSavedContactData = [self getContactByID:objContactData.listingID];
//
//        NSLog(@"%@", objSavedContactData);
//
//        if (!objSavedContactData)
//        {
//
//        }
//        else
//        {
//            NSLog(@"contact was found");
//            [objPet addContactObject:objSavedContactData];
//        }
    }

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];

    PetData *objConvertedPetData = [self convertPet:objPetData withPet:objPet];

    return objConvertedPetData;
}

- (PetData *)savePetData:(PetData *)data
{
    PetData* objPetData = data;
    NSLog(@"save %@", [objPetData name]);
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    objPet.name = objPetData.name;
    objPet.gender = objPetData.gender;
    objPet.breed = objPetData.breed;
    objPet.chipNo = objPetData.chipNo;
    objPet.coatMarkings = objPetData.coatMarkings;
    objPet.color = objPetData.color;
    objPet.eyeColor = objPetData.eyeColor;
    objPet.dateAdded = objPetData.dateAdded;
    objPet.pedigree = objPetData.pedigree;
    objPet.licenseNo = objPetData.licenseNo;
    objPet.price = objPetData.price;
    objPet.species = objPetData.species;
    objPet.tagNo = objPetData.tagNo;
    objPet.weight = objPetData.weight;
    objPet.owned = objPetData.owned;

    if ([objPetData.spayedNeutered isEqualToString:@"No"]) objPet.spayedNeutered = [NSNumber numberWithBool:NO];
    if ([objPetData.spayedNeutered isEqualToString:@"Yes"]) objPet.spayedNeutered = [NSNumber numberWithBool:YES];


    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];



    PetData *objConvertedPetData = [self convertPet:objPetData withPet:objPet];

    return objConvertedPetData;
}


- (PetData *)convertPet:(PetData *)data withPet:(Pet *)pet
{
    PetData *objPetData = [[PetData alloc] init];
    Pet *objPet = pet;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm/dd/yyyy"];

    NSString *spayedNeutered;
    NSString *weight;
    NSString *color;
    NSString *eyeColor;
    NSString *coatMarkings;
    NSString *price;
    NSString *tagNo;
    NSString *chipNo;
    NSString *license;
    NSString *pedigree;
    NSString *birthday;
    NSString *owned;
   // NSString *added;
    NSString *notes;
    NSString *insurance;
    NSString *diet;
    NSString *breed;
    NSString *species;
    NSString *gender;

    if ([objPet.spayedNeutered boolValue]) spayedNeutered = @"Yes";
    else spayedNeutered = @"No";

    //NSString *strBirthday = [formatter stringFromDate: objPet.birthday];
    //NSString *strDateAdded = [formatter stringFromDate:objPet.dateAdded];


    //Notes
    if (objPet.notes.length == 0)  notes = @"NA";
    else notes = objPet.notes;

    //Insurance
    if (objPet.insurance.length == 0)  insurance = @"NA";
    else insurance = objPet.insurance;

    //Diet
    if (objPet.diet.length == 0)  diet = @"NA";
    else diet = objPet.diet;

    //Gender
    if (objPet.gender.length == 0)  gender = @"NA";
    else gender = objPet.gender;

    //Breed
    if (objPet.breed.length == 0)  breed = @"NA";
    else breed = objPet.breed;

    //Weight
    if (objPet.weight.length == 0)  weight = @"NA";
    else weight = objPet.weight;

    //Color
    if (objPet.color.length == 0)  color = @"NA";
    else color = objPet.color;

    //Eye Color
    if (objPet.eyeColor.length == 0)  eyeColor = @"NA";
    else eyeColor = objPet.eyeColor;

    //Coat Markings
    if (objPet.coatMarkings.length == 0)  coatMarkings = @"NA";
    else coatMarkings = objPet.coatMarkings;

    //Price
    if (objPet.price.length == 0)  price = @"NA";
    else price = objPet.price;

    //Tag No
    if (objPet.tagNo.length == 0)  tagNo = @"NA";
    else tagNo = objPet.tagNo;

    //Chip No
    if (objPet.chipNo.length == 0)  chipNo = @"NA";
    else chipNo = objPet.chipNo;

    //License No
    if (objPet.licenseNo.length == 0)  license = @"NA";
    else license = objPet.licenseNo;

    //Pedigree
    if (objPet.pedigree.length == 0)  pedigree = @"NA";
    else pedigree = objPet.pedigree;

    //Species
    if (objPet.species.length == 0) species = @"NA";
    else species = objPet.species;

    //Birthday
    if (objPet.birthday.length == 0) birthday = @"NA";
    else birthday =  objPet.birthday;

    //Date Owned
    if (data.owned.length == 0)  owned = @"NA";
    else owned = data.owned;


    objPetData.name = objPet.name;
    objPetData.diet = objPet.diet;
    objPetData.insurance = objPet.insurance;
    objPetData.notes = objPet.notes;
    objPetData.breed = breed;
    objPetData.weight = weight;
    objPetData.color = color;
    objPetData.eyeColor = eyeColor;
    objPetData.coatMarkings = coatMarkings;
    objPetData.dateAdded = objPet.dateAdded;
    objPetData.price = price;
    objPetData.tagNo = tagNo;
    objPetData.chipNo = chipNo;
    objPetData.guid = objPet.guid;
    objPetData.licenseNo = license;
    objPetData.pedigree = pedigree;
    objPetData.primaryVet = objPet.primaryVet;
    objPetData.primaryGroomer = objPet.primaryGroomer;
    objPetData.primaryKennel = objPet.primaryKennel;
    objPetData.birthday = birthday;
    objPetData.owned = owned;
    objPetData.species = species;
    objPetData.spayedNeutered = spayedNeutered;
    objPetData.gender = gender;
    objPetData.imageData = objPet.imageData;

    //NSLog(@"primary vet convert pet %@", objPet.primaryVet);

    //NSLog(@"convert pet insurance:  %@", objPetData.insurance);

    NSArray *contactData = [[NSArray alloc] initWithArray:[[objPet contact] allObjects]];
    NSMutableArray *contact = [[NSMutableArray alloc] init];

    //Contacts
    for (int j = 0; j < [contactData count]; j++)
    {
        ContactData* objContactData = [[ContactData alloc] init];
        Contact *objContact = [contactData objectAtIndex:j];
        objContactData.name = [objContact name];
        objContactData.city = [objContact city];
        objContactData.contentType = [objContact contentType];
        objContactData.type = [objContact type];
        objContactData.email = [objContact email];
        objContactData.guid = [objContact guid];
        objContactData.listingID = [objContact listingID];
        objContactData.longCoordinate = [[objContact longitude] floatValue];
        objContactData.latCoordinate = [[objContact latitude] floatValue];
        objContactData.phone = [objContact phone];
        objContactData.state = [objContact state];
        objContactData.streetAddress = [objContact streetAddress];
        objContactData.zipCode = [[objContact zipCode] intValue];
        //NSLog(@"create contact %i", j+1);

        [contact addObject:objContactData];
    }


    NSArray *medicalItemData = [[NSArray alloc] initWithArray:[[objPet petItem] allObjects]];
    NSMutableArray *medicalItems = [[NSMutableArray alloc] init];

    //NSLog(@"after contacts created");
    //Medical Items
    for (int j = 0; j < [medicalItemData count]; j++)
    {
        MedicalData*objMedicalData = [[MedicalData alloc] init];
        MedicalItem *objMedicalItem = [medicalItemData objectAtIndex:j];

        objMedicalData.name = [objMedicalItem value];
        objMedicalData.type = [objMedicalItem type];
        objMedicalData.date = [objMedicalItem date];
        objMedicalData.dosage = [objMedicalItem dosage];
        objMedicalData.dateAdded = [objMedicalItem dateAdded];
        objMedicalData.data = [objMedicalItem data];
        objMedicalData.category = [objMedicalItem category];
        objMedicalData.guid = [objMedicalItem guid];
        //NSLog(@"convert guid %@", [objMedicalItem guid]);

        [medicalItems addObject:objMedicalData];
    }

    NSArray *appointmentData = [[NSArray alloc] initWithArray:[[objPet appointment] allObjects]];
    NSMutableArray *appointment = [[NSMutableArray alloc] init];

    //NSLog(@"after contacts created");
    //Appointments
    for (int j = 0; j < [appointmentData count]; j++)
    {
        AppointmentData *objAppointmentData = [[AppointmentData alloc] init];
        Appointment *objAppointmentItem = [appointmentData objectAtIndex:j];

        objAppointmentData.startDate = objAppointmentItem.startDate;
        objAppointmentData.type = objAppointmentItem.type;
        objAppointmentData.appointmentDate = objAppointmentItem.appointmentDate;
        objAppointmentData.time = objAppointmentItem.time;
        objAppointmentData.saveToCalendar = [objAppointmentItem.saveToCalendar boolValue];
        objAppointmentData.title = objAppointmentItem.title;
        objAppointmentData.notes = objAppointmentItem.notes;

        //NSLog(@"%@", [objAppointmentItem.pet allObjects]);

        NSArray *arrPetData = [[NSMutableArray alloc] initWithArray:[objAppointmentItem.pet allObjects]];

        for (int i = 0; i < arrPetData.count; i++)
        {
            [ objAppointmentData.pets addObject:[[arrPetData objectAtIndex:i] name]];
        }



        [appointment addObject:objAppointmentData];
    }

    objPetData.contacts = contact;
    objPetData.medicalItems = medicalItems;
    objPetData.appointments = appointment;

    //NSLog(@"name: %@", objPetData.name);

    return objPetData;
}


- (PetData *) saveMedicalMisc:(MedicalData *)item withPet:(PetData *)pet
{
    PetData* objPetData = pet;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    if ([item.type isEqualToString:kMedicalTypeNotes]) objPet.notes = item.data;
    if ([item.type isEqualToString:kMedicalTypeInsurance]) objPet.insurance = item.data;
    if ([item.type isEqualToString:kMedicalTypeDiet]) objPet.diet = item.data;



    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];

    PetData *objConvertedPetData = [self convertPet:objPetData withPet:objPet];

    NSLog(@"save medical misc");
    return objConvertedPetData;
}


- (PetData *) saveMedicalItem:(MedicalData *)item withPet:(PetData *)pet
{
    PetData* objPetData = pet;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];


    MedicalItem *objMedicalItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([MedicalItem class]) inManagedObjectContext:self.dataStack.managedObjectContext];
    NSLog(@"before save data type %@", item.type);
    objMedicalItem.type = item.type;
    objMedicalItem.value = item.name;
    objMedicalItem.date = item.date;
    objMedicalItem.data = item.data;
    NSDate *today = [NSDate date];
    objMedicalItem.dateAdded = today;
    objMedicalItem.dosage = item.dosage;
    objMedicalItem.category = item.category;
    objMedicalItem.guid = item.guid;

    NSLog(@"save med item guid %@", objMedicalItem.guid);

    [objPet addPetItemObject:objMedicalItem];

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];

    PetData *objConvertedPetData = [self convertPet:objPetData withPet:objPet];

    NSLog(@"save medical data success %i", objConvertedPetData.medicalItems.count);
    return objConvertedPetData;
}


- (void)updateContact:(ContactData *)data
{
    ContactData* objContactData = data;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Contact"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objContactData.guid];
    Contact *objContact = [[array filteredArrayUsingPredicate:predicate] lastObject];

    objContact.name = objContactData.name;
    objContact.streetAddress = objContactData.streetAddress;
    objContact.city = objContactData.city;
    objContact.state = objContactData.state;
    //objContact.listingID = objContactData.listingID;
    objContact.zipCode = [NSString stringWithFormat:@"%i", objContactData.zipCode];
    objContact.phone = objContactData.phone;
    objContact.type = objContactData.type;

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];
}

- (void)updateMedicalItem:(MedicalData *)data
{
    MedicalData* item = data;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"MedicalItem"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", item.guid];
    MedicalItem *objMedicalItem = [[array filteredArrayUsingPredicate:predicate] lastObject];

    objMedicalItem.type = item.type;
    objMedicalItem.value = item.name;
    objMedicalItem.date = item.date;
    objMedicalItem.data = item.data;
    objMedicalItem.dosage = item.dosage;
    objMedicalItem.category = item.category;
    objMedicalItem.guid = item.guid;

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];
}

- (void) deletePet:(PetData *)petData
{
    PetData* objPetData = petData;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Pet"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objPetData.guid];
    Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];

    [self.dataStack.managedObjectContext deleteObject:objPet];

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error %@", error);
    }];
}

- (void) deleteMedicalItem:(MedicalData *)medicalData
{
    MedicalData* objMedicalData = medicalData;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"MedicalItem"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objMedicalData.guid];
    MedicalItem *objMedicalItem = [[array filteredArrayUsingPredicate:predicate] lastObject];

    //NSLog(@"delete %@ guid %@", array, objMedicalData.guid);
    [self.dataStack.managedObjectContext deleteObject:objMedicalItem];

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error %@", error);
    }];

    NSLog(@"item was deleted");
}


- (Contact *) getContactByID:(NSString *)guid
{
    //ContactData* objContactData = [[ContactData alloc] init];
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Contact"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"listingID == %@", guid];
    Contact *objContact = [[array filteredArrayUsingPredicate:predicate] lastObject];

//    objContactData.name = objContact.name;
//    objContactData.streetAddress = objContact.streetAddress;
//    objContactData.city = objContact.city;
//    objContactData.listingID = objContact.listingID;
//    objContactData.state = objContact.state;
//    objContactData.zipCode = [objContact.zipCode intValue];
//    objContactData.phone = objContact.phone;
//    objContactData.type = objContact.type;

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error saving pet %@", error);
    }];

    return objContact;
}
@end
