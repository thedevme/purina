//
// Created by craigclayton on 12/26/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface EmergencyData : NSObject


@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *streetAddress;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *guid;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *state;
@property(nonatomic) float latitude;
@property(nonatomic) float longitude;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *zipCode;
@end