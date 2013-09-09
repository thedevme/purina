//
//  PetData.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import <Foundation/Foundation.h>

@interface PetData : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *guid;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *chipNo;
@property (nonatomic, retain) NSString *coatMarkings;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *eyeColor;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSData *imageData;
@property (nonatomic, retain) NSString *licenseNo;
@property (nonatomic, retain) NSString *owned;
@property (nonatomic, retain) NSString *pedigree;
@property (nonatomic, retain) NSString *primaryVet;
@property (nonatomic, retain) NSString *primaryGroomer;
@property (nonatomic, retain) NSString *primaryKennel;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *spayedNeutered;
@property (nonatomic, retain) NSString *species;
@property (nonatomic, retain) NSString *tagNo;
@property (nonatomic, retain) NSString *weight;
@property (nonatomic, retain) NSString *breed;
@property (nonatomic, retain) NSDate *dateAdded;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *insurance;
@property (nonatomic, retain) NSString *diet;

@property (nonatomic, retain) NSMutableArray *appointments;
@property (nonatomic, retain) NSMutableArray *contacts;
@property (nonatomic, retain) NSMutableArray *medicalItems;

@end
