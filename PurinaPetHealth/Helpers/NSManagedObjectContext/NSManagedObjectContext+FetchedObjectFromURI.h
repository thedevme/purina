//
//  NSManagedObjectContext+FetchedObjectFromURI.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/9/12.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FetchedObjectFromURI)
- (NSManagedObject *)objectWithURI:(NSURL *)uri;
@end
