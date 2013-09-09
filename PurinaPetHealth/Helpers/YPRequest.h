//
//  YPRequest.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/28/12.
//
//

#import <Foundation/Foundation.h>
#import "NSURL+PathParameters.h"

@interface YPRequest : NSObject

+ (NSURLRequest *)getYellowPagesData:(NSString *)searchLocation withSearhType:(NSString *)type;

@end
