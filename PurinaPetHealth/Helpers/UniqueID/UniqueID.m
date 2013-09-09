//
//  UniqueID.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/9/12.
//
//

#import "UniqueID.h"

@implementation UniqueID

+ (NSString *)getUUID
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	NSString *string = (__bridge NSString *)CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	
    return string;
}

@end
