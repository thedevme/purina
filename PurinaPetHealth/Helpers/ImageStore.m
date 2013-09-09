//
//  ImageStore.m
//  EasyTableView
//
//  Created by Aleksey Novicov on 1/30/12.
//  Copyright (c) 2012 Yodel Code LLC. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

@synthesize operationQueue = _operationQueue;
@synthesize delegate = _delegate;
@synthesize titles = _titles;
@synthesize urls = _urls;
@synthesize imageCache = _imageCache;


- (id)initWithDelegate:(id<ImageStoreDelegate>)aDelegate andType:(NSString *)type {
    self = [super init];
    if (self) {
		self.delegate = aDelegate;
		
		// We need a separate queue for all of our network transactions
		NSOperationQueue *queue = [[NSOperationQueue alloc] init];
		
		[queue addOperationWithBlock:^{
			NSDictionary *json = nil;
			NSError *error;
			
			// Due to the high frequency of JSON deserialization errors, loop until there is no error
			do {
				error = nil;

				// Retrieve list of public images from Flickr
				//NSURL *url = [NSURL URLWithString:@""];
				//NSData *listData = [NSData dataWithContentsOfURL:url];


                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dog-tips" ofType:@"json"];
                //else filePath = [[NSBundle mainBundle] pathForResource:@"cat-tips" ofType:@"json"];

                NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
                NSError *error;
                json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];


                //json = [NSJSONSerialization JSONObjectWithData:listData options:NSJSONReadingAllowFragments error:&error];
                //NSLog(@"%@", json);
                // Make sure to call delegate on main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if ([aDelegate respondsToSelector:@selector(errorMessage:)]) {
                        if (error)
                            [aDelegate errorMessage:[NSString stringWithFormat:@"%@ Retrying...", [error localizedDescription]]];
                        else
                            [aDelegate errorMessage:nil];
                    }
                }];
			}
			while (error);

			// If there is no network connection, json will be nil
			if (json) {

                //NSLog(@"%@", json);
                NSString *image = [NSString stringWithFormat:@"%@.png", [json valueForKeyPath:@"copy"]];
				self.titles = [json valueForKeyPath:@"title"];
				self.urls = image;
//
//				// Setup image cache
				NSMutableDictionary *cache = [[NSMutableDictionary alloc] initWithCapacity:[self.titles count]];
				self.imageCache = cache;

				// Make sure to call delegate on main queue
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					if ([aDelegate respondsToSelector:@selector(imageTitles:)]) {
						[aDelegate imageTitles:self.titles];
					}
				}];
			}
		}];
		
		self.operationQueue = queue;
    }
    return self;
}

- (UIImage *)imageAtIndex:(NSUInteger)index {
	//NSString *urlString = [self.urls objectAtIndex:index];
	UIImage *image = [UIImage imageNamed:self.urls];

    NSLog(@"%@", self.urls);
	
//	if (!image) {
//		//NSURL *url = [NSURL URLWithString:urlString];
//
//		[self.operationQueue addOperationWithBlock:^{
//			NSData *imageData = [NSData dataWithContentsOfURL:url];
//			UIImage *newImage = [UIImage imageWithData:imageData];
//
//			// Save the image in the image cache
//			if (newImage) {
//				[self.imageCache setObject:newImage forKey:urlString];
//
//				// Make sure to call delegate on main queue
//				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//					if ([self.delegate respondsToSelector:@selector(image:loadedAtIndex:)]) {
//						[self.delegate image:newImage loadedAtIndex:index];
//					}
//				}];
//			}
//		}];
//	}
	return image;
}

- (void)clearImageCache {
	[self.imageCache removeAllObjects];
}

@end
