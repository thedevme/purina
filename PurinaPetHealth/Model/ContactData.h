//
//  ContactData.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/7/12.
//
//

#import <Foundation/Foundation.h>


@interface ContactData : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, retain) NSString* streetAddress;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* state;
@property (nonatomic, retain) NSString* phone;
@property (nonatomic, retain) NSNumber* distance;
@property (nonatomic, retain) NSString* guid;
@property (nonatomic, retain) NSString* listingID;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* contentType;
@property (assign) float longCoordinate;
@property (assign) float latCoordinate;
@property (assign) int zipCode;
@property (assign) BOOL isPreferred;

@end
