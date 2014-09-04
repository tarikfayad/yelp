//
//  TMFYelpAPIClient.h
//  corelocationPractice
//
//  Created by Tarik Fayad on 7/28/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMFYelpAPIClient : NSObject

#pragma warning - Rewrite all of the methods below to allow for the User to enter the number of locations they want pulled in (be it 1 or >100) and also rewrite them to automatically use the device's current location so that they don't have to do all of the CoreLocation information.

//Fetches 20 locations of a given type in a given city and returns them as an NSDictionary object.
+ (void) fetchYelpLocationsOfType: (NSString *)type inCity: (NSString *)city WithCompletion:(void (^)(NSDictionary *locations))completionBlock;

//Fetches 20 locations of a given type at a specific latitude and longitude and returns them as an NSDictionary object.
+ (void) fetchYelpLocationsOfType: (NSString *)type atLatitude: (NSString *)latitude andLongitude: (NSString *)longitude withCompletion:(void (^)(NSDictionary *locations))completionBlock;

//Fetches 20 locations of a given type at a specific latitude and longitude within a given radius (in meters) and returns them as an NSDictionary object.
+ (void) fetchYelpLocationsOfType: (NSString *)type atLatitude: (NSString *)latitude andLongitude: (NSString *)longitude withinRadius: (NSNumber *)radius withCompletion: (void (^)(NSDictionary * locations))completionBlock;

@end
