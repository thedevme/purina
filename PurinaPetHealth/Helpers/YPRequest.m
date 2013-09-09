//
//  YPRequest.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/28/12.
//
//

#define kAPIKEY "8729ab9732ea172e4b4bc8ba02525d5c"
#import "YPRequest.h"
#import "Constants.h"

@implementation YPRequest

+ (NSURLRequest *)getYellowPagesData:(NSString *)searchLocation withSearhType:(NSString *)type
{
    NSString* listCount = @"50";
    NSString *distance = @"20";
    NSString *json = @"json";

    NSDictionary *queryParams;
    if ([[type lowercaseString] isEqualToString:@"emergency+veterinarian"]) queryParams = [NSDictionary dictionaryWithObjectsAndKeys: @"veterinarian", @"T", distance, @"R", searchLocation, @"W", listCount, @"L", json, @"F",  nil];
    else queryParams = [NSDictionary dictionaryWithObjectsAndKeys: type, @"T", distance, @"R", searchLocation, @"W", listCount, @"L", json, @"F",  nil];

    NSString *geoType;

    NSLog(@"search contentType: %@", type);
    if ([[type lowercaseString] isEqualToString:@"veterinarian"])    geoType = @"Purina_FindVets.ashx";
    if ([[type lowercaseString] isEqualToString:@"emergency+veterinarian"])    geoType = @"Purina_FindVets.ashx";
    if ([[type lowercaseString] isEqualToString:@"groomer"])         geoType = @"Purina_FindGroomers.ashx";
    if ([[type lowercaseString] isEqualToString:@"kennel"])          geoType = @"Purina_FindKennels.ashx";
    if ([[type lowercaseString] isEqualToString:@"dogpark"] || [[type lowercaseString] isEqualToString:@"dog park"])  geoType = @"Purina_FindDogParks.ashx";


    NSString *base = @"http://utils.triadretail.com/GeoServices/";
    NSString *path = [NSString stringWithFormat:@"%@%@", base, geoType];
    NSURL* url = [NSURL URLWithString:path];

    url = [url URLByAppendingParameters:queryParams];
    NSLog(@"%@", url);
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    
    return req;
}

@end
