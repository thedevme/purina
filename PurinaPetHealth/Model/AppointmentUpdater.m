//
//  AppointmentUpdater.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/6/12.
//
//

#import "AppointmentUpdater.h"
#import "UniqueID.h"
#import "PetData.h"
#import "ContactData.h"
#import "Contact.h"
#import "MedicalData.h"
#import "MedicalItem.h"

@implementation AppointmentUpdater


- (id) init
{
    self = [super init];
    
    if (self)
    {
        [self createModel];
        //NSLog(@"create model");
    }
    
    return self;
}

- (void) createModel
{
    _dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    _dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.petModel = [[PetModel alloc] init];
}

- (NSArray *) getAppointments
{
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Appointment"
                                              inManagedObjectContext:_dataStack.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];

    NSArray *array = [_dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSMutableArray* arrAppointmentsData = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
    NSMutableArray *arrAppointments = [[NSMutableArray alloc] init];

    for (int i = 0; i < arrAppointmentsData.count; i++)
    {
        [arrAppointments addObject:[self convertAppointment:[arrAppointmentsData objectAtIndex:i]]];
    }

    //NSLog(@"get appointments %@", arrAppointmentsData);

    return arrAppointments;
}

- (AppointmentData *)convertAppointment:(Appointment *)appointment
{
    AppointmentData *objAppointmentData = [[AppointmentData alloc] init];
    objAppointmentData.appointmentDate = appointment.appointmentDate;
    objAppointmentData.time = appointment.time;
    objAppointmentData.startDate = appointment.startDate;
    objAppointmentData.endDate = appointment.endDate;
    objAppointmentData.notes = appointment.notes;
    objAppointmentData.title = appointment.title;
    objAppointmentData.type = appointment.type;
    objAppointmentData.guid = appointment.guid;
    objAppointmentData.saveToCalendar = appointment.saveToCalendar.boolValue;

    NSArray *arrPetData = [[NSMutableArray alloc] initWithArray:[appointment.pet allObjects]];
    NSMutableArray *pets = [[NSMutableArray alloc] init];

    for (int i = 0; i < arrPetData.count; i++)
    {
        [pets addObject:[self convertPet:[arrPetData objectAtIndex:i]]];
    }

    objAppointmentData.pets = pets;

    return objAppointmentData;
}


- (void) createAppointment:(AppointmentData *)data
{
    Appointment* appointment = [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:_dataStack.managedObjectContext];


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *apptDate = [dateFormatter dateFromString:data.appointmentDate];
    appointment.title = data.title;
    appointment.appointmentDate = data.appointmentDate;
    appointment.time = data.time;
    appointment.startDate = apptDate;
    appointment.type = data.type;
    appointment.guid = [UniqueID getUUID];
    appointment.saveToCalendar = [NSNumber numberWithInt:data.saveToCalendar];
    appointment.notes = data.notes;
    

    NSArray *pets = [[NSArray alloc] initWithArray:data.pets];

    //appointment.pet
    for (int i = 0; i < [pets count]; i++)
    {
        //PetData* objPetData = [pets objectAtIndex:i];


        NSLog(@"%@", [pets objectAtIndex:i]);




        Pet* objPet = [self getPetByID:[pets objectAtIndex:i]];
//
        [appointment addPetObject:objPet];
        //NSLog(@"%@", objPet);
        [objPet addAppointmentObject:appointment];
    }
    
    [_dataStack saveOrFail:^(NSError* error) {
        NSLog(@"There was an error %@", error);

        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
        NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if(detailedErrors != nil && [detailedErrors count] > 0) {
            for(NSError* detailedError in detailedErrors) {
                NSLog(@"  DetailedError: %@", [detailedError userInfo]);
            }
        }
        else {
            NSLog(@"  %@", [error userInfo]);
        }
    }];
    
    [_delegate appointmentSaved];


    appointment = nil;
}


- (Pet *) getPetDataByID:(Pet *)data
{
    Pet* objPetData = data;
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

    return objPet;
}


- (Pet *) getPetByID:(PetData *)data
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

    return objPet;
}

- (PetData *)convertPet:(Pet *)data
{
    PetData *objPetData = [[PetData alloc] init];
    Pet *objPet = data;

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
    if (objPet.owned.length == 0)  owned = @"NA";
    else owned = objPet.owned;


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

//    NSArray *contactData = [[NSArray alloc] initWithArray:[[objPet contact] allObjects]];
//    NSMutableArray *contact = [[NSMutableArray alloc] init];
//
//    //Contacts
//    for (int j = 0; j < [contactData count]; j++)
//    {
//        ContactData* objContactData = [[ContactData alloc] init];
//        Contact *objContact = [contactData objectAtIndex:j];
//        objContactData.name = [objContact name];
//        objContactData.city = [objContact city];
//        objContactData.contentType = [objContact contentType];
//        objContactData.type = [objContact type];
//        objContactData.email = [objContact email];
//        objContactData.guid = [objContact guid];
//        objContactData.longCoordinate = [[objContact longitude] floatValue];
//        objContactData.latCoordinate = [[objContact latitude] floatValue];
//        objContactData.phone = [objContact phone];
//        objContactData.state = [objContact state];
//        objContactData.streetAddress = [objContact streetAddress];
//        objContactData.zipCode = [[objContact zipCode] intValue];
//        //NSLog(@"create contact %i", j+1);
//
//        [contact addObject:objContactData];
//    }
//
//
//    NSArray *medicalItemData = [[NSArray alloc] initWithArray:[[objPet petItem] allObjects]];
//    NSMutableArray *medicalItems = [[NSMutableArray alloc] init];
//
//    //NSLog(@"after contacts created");
//    //Medical Items
//    for (int j = 0; j < [medicalItemData count]; j++)
//    {
//        MedicalData*objMedicalData = [[MedicalData alloc] init];
//        MedicalItem *objMedicalItem = [medicalItemData objectAtIndex:j];
//
//        objMedicalData.name = [objMedicalItem value];
//        objMedicalData.type = [objMedicalItem type];
//        objMedicalData.date = [objMedicalItem date];
//        objMedicalData.dosage = [objMedicalItem dosage];
//        objMedicalData.data = [objMedicalItem data];
//        objMedicalData.category = [objMedicalItem category];
//        objMedicalData.guid = [objMedicalItem guid];
//        //NSLog(@"convert guid %@", [objMedicalItem guid]);
//
//        [medicalItems addObject:objMedicalData];
//    }
//
//    NSArray *appointmentData = [[NSArray alloc] initWithArray:[[objPet appointment] allObjects]];
//    NSMutableArray *appointment = [[NSMutableArray alloc] init];
//
//    //NSLog(@"after contacts created");
//    //Appointments
//    for (int j = 0; j < [appointmentData count]; j++)
//    {
//        AppointmentData *objAppointmentData = [[AppointmentData alloc] init];
//        Appointment *objAppointmentItem = [appointmentData objectAtIndex:j];
//
//        objAppointmentData.startDate = objAppointmentItem.startDate;
//        objAppointmentData.type = objAppointmentItem.type;
//        objAppointmentData.appointmentDate = objAppointmentItem.appointmentDate;
//        objAppointmentData.time = objAppointmentItem.time;
//        objAppointmentData.saveToCalendar = [objAppointmentItem.saveToCalendar boolValue];
//        objAppointmentData.title = objAppointmentItem.title;
//        objAppointmentData.notes = objAppointmentItem.notes;
//
//        //NSLog(@"%@", [objAppointmentItem.pet allObjects]);
//
//        NSArray *arrPetData = [[NSMutableArray alloc] initWithArray:[objAppointmentItem.pet allObjects]];
//
//        for (int i = 0; i < arrPetData.count; i++)
//        {
//            [ objAppointmentData.pets addObject:[[arrPetData objectAtIndex:i] name]];
//        }
//
//
//
//        [appointment addObject:objAppointmentData];
//    }
//
//    objPetData.contacts = contact;
//    objPetData.medicalItems = medicalItems;
//    objPetData.appointments = appointment;

    //NSLog(@"name: %@", objPetData.name);

    return objPetData;
}

- (void) updateAppointment:(AppointmentData *)data
{
    AppointmentData* objAppointmentData = data;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Appointment"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objAppointmentData.guid];
    Appointment *objAppointment = [[array filteredArrayUsingPredicate:predicate] lastObject];

    NSLog(@"pet count %i", objAppointmentData.pets.count);

    if (objAppointmentData.pets.count == 0)
    {
        NSArray *pets = [objAppointment.pet allObjects];
        for (NSManagedObject * pet in pets)
        {
            [self.dataStack.managedObjectContext deleteObject:pet];
        }
    }

    if (objAppointmentData.pets.count > 0)
    {
        for (int i = 0; i < objAppointmentData.pets.count; i++)
        {
            NSArray *arrData = [objAppointment.pet allObjects];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:[@"guid == %@", [objAppointmentData.pets objectAtIndex:i] guid] ];
            Pet *objPet = [[array filteredArrayUsingPredicate:predicate] lastObject];
            NSLog(@"pet found: r%@", objPet);
        }
    }
//
//    NSLog(@"before delete %i",pets.count);
////

//
//    //NSArray *contacts = [objPet.contact allObjects];
//
//    for (int j = 0; j < [objAppointmentData.pets count]; j++)
//    {
//        PetData* objPetData = [objAppointmentData.pets objectAtIndex:j];
//        Pet *objPet = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Pet class]) inManagedObjectContext:self.dataStack.managedObjectContext];
//
//        NSLog(@"save contact %@ name %@", objPetData, objPetData.name);
//        objPet.name = objPetData.name;
//        objPet.gender = objPetData.gender;
//        objPet.breed = objPetData.breed;
//        objPet.chipNo = objPetData.chipNo;
//        objPet.coatMarkings = objPetData.coatMarkings;
//        objPet.color = objPetData.color;
//        objPet.eyeColor = objPetData.eyeColor;
//        objPet.dateAdded = [NSDate date];
//        objPet.pedigree = objPetData.pedigree;
//        objPet.licenseNo = objPetData.licenseNo;
//        objPet.price = objPetData.price;
//        objPet.species = objPetData.species;
//        objPet.tagNo = objPetData.tagNo;
//        objPet.primaryVet = objPetData.primaryVet;
//        objPet.primaryGroomer = objPetData.primaryGroomer;
//        objPet.primaryKennel = objPetData.primaryKennel;
//        objPet.weight = objPetData.weight;
//        objPet.birthday = objPetData.birthday;
//        objPet.guid = objPetData.guid;
//        objPet.imageData = objPetData.imageData;
//
//        for (int j = 0; j < [objPetData.contacts count]; j++)
//        {
//            ContactData* objContactData = [objPetData.contacts objectAtIndex:j];
//            Contact *objContact = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contact class]) inManagedObjectContext:self.dataStack.managedObjectContext];
//
//            objContact.name = [objContactData name];
//            objContact.city = [objContactData city];
//            objContact.contentType = [objContactData contentType];
//            objContact.type = [objContactData type];
//            objContact.email = [objContactData email];
//            objContact.guid = [objContactData guid];
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
//
//        [objPet addContactObject:objPet];
//        [objPet addAppointmentObject:objAppointment];
//    }



    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *apptDate = [dateFormatter dateFromString:objAppointmentData.appointmentDate];
    objAppointment.title = objAppointmentData.title;
    objAppointment.appointmentDate = objAppointmentData.appointmentDate;
    objAppointment.time = objAppointmentData.time;
    objAppointment.startDate = apptDate;
    objAppointment.type = objAppointmentData.type;
    objAppointment.saveToCalendar = [NSNumber numberWithInt:objAppointmentData.saveToCalendar];
    objAppointment.notes = objAppointmentData.notes;
    NSLog(@"after delete pets %@", objAppointment);

//    NSArray *pets = [[NSArray alloc] initWithArray:objAppointmentData.pets];
//
////
//    for (int i = 0; i < [pets count]; i++)
//    {
//        Pet* objPet = [self getPetByID:[pets objectAtIndex:i]];
//        [objAppointment addPetObject:objPet];
//        [objPet addAppointmentObject:objAppointment];
//    }


    [_dataStack saveOrFail:^(NSError* error) {
        NSLog(@"There was an error %@", error);
    }];

    NSLog(@"save done");
}

- (void) deleteAppointment:(AppointmentData *)data
{
    AppointmentData* objAppointmentData = data;
    NSError* error = nil;
    NSEntityDescription *entityDescription = [NSEntityDescription
            entityForName:@"Appointment"
   inManagedObjectContext:self.dataStack.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", objAppointmentData.guid];
    Appointment *objAppointment = [[array filteredArrayUsingPredicate:predicate] lastObject];

    NSLog(@"object found: %@", objAppointment.guid);

    [self.dataStack.managedObjectContext deleteObject:objAppointment];

    [self.dataStack saveOrFail:^(NSError* error)
    {
        NSLog(@"There was an error %@", error);
    }];
}


@end
