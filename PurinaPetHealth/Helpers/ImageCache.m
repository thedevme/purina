//
//  ImageCache.m
//  ClubRaiderNation
//
//  Created by Craig Clayton on 8/12/12.
//
//

#import "ImageCache.h"

#define kDefaultCacheFile @"imagecache.plist"

//////////////////////////////////////////////////////////////////////////////////////////////////

@interface ImageCache (private)
- (NSString*) makeKeyFromUrl:(NSString*)url;
@end//private ImageCache interface

//////////////////////////////////////////////////////////////////////////////////////////////////

static ImageCache *sharedInstance = nil;

//////////////////////////////////////////////////////////////////////////////////////////////////

@implementation ImageCache
@synthesize dictCache;

////////////////////////////////////////////////////////////////////////////////

- (id)init
{
	if ( (self = [super init]) )
	{
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		
		documentsDirectory = [paths objectAtIndex:0];
		
		// the path to the cache map
		cacheFileUrl = [documentsDirectory stringByAppendingPathComponent:kDefaultCacheFile];
		//[cacheFileUrl retain];
        
		dictCache = [[NSDictionary alloc] initWithContentsOfFile:cacheFileUrl];
		
		if ( dictCache == nil )
		{
			dictCache = [[NSMutableDictionary alloc] init];
		}
	}
	
	return self;
}

////////////////////////////////////////////////////////////////////////////////

+ (ImageCache*) instance
{
	@synchronized(self)
	{
		if ( sharedInstance == nil )
		{
			sharedInstance = [[ImageCache alloc] init];
		}
	}
	return sharedInstance;
}

////////////////////////////////////////////////////////////////////////////////

- (BOOL) isRemoteFileCached:(NSString*)url
{
	NSString *imageFilename = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	
	return (imageFilename != nil);
}

////////////////////////////////////////////////////////////////////////////////

- (NSData*) getCachedRemoteFile:(NSString*)url
{
	NSString *imageFilename = [dictCache valueForKey:[self makeKeyFromUrl:url]];
	NSData *data = nil;
	
	if ( imageFilename != nil )
	{
		data = [NSData dataWithContentsOfFile:imageFilename];
	}
	
	return data;
}

////////////////////////////////////////////////////////////////////////////////

- (BOOL) addRemoteFileToCache:(NSString*)url withData:(NSData*)data
{
	BOOL result = NO;
	NSString *imageFilename = [url lastPathComponent];
	
	if ( imageFilename != nil )
	{
		// the path to the cached image file
		NSString *cachedImageFileUrl = [documentsDirectory stringByAppendingPathComponent:imageFilename];
        
		result = [data writeToFile:cachedImageFileUrl atomically:YES];
		
		if ( result == YES )
		{
			// add the cached file to the dictionary
			[dictCache setValue:cachedImageFileUrl forKey:[self makeKeyFromUrl:url]];
			[dictCache writeToFile:cacheFileUrl atomically:YES];
		}
	}
	
	return result;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods

- (NSString*) makeKeyFromUrl:(NSString*)url
{
	NSString *key = [url stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    
	key = [key stringByReplacingOccurrencesOfString:@":" withString:@"."];
	return key;
}

@end