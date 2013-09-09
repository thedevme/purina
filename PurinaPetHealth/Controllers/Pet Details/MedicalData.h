//
// Created by craigclayton on 12/17/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface MedicalData : NSObject

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString *dosage;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSDate *dateAdded;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *guid;

@end