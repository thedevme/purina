//
//  ImageCache.h
//
//  Created by Craig Clayton on 8/12/12.
//  
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject
{
	NSString *documentsDirectory;
	NSString *cacheFileUrl;
	NSDictionary *dictCache;
}

@property (nonatomic, retain) NSDictionary *dictCache;

+ (ImageCache*) instance;

- (BOOL) isRemoteFileCached:(NSString*)url;
- (NSData*) getCachedRemoteFile:(NSString*)url;
- (BOOL) addRemoteFileToCache:(NSString*)url withData:(NSData*)data;

@end