//
//  TMFYelpAPIClient.h
//  corelocationPractice
//
//  Created by Tarik Fayad on 7/28/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMFYelpAPIClient : NSObject

+ (void) fetchYelpLocationsOfType: (NSString *)type inCity: (NSString *)city WithCompletion:(void (^)(NSDictionary *locations))completionBlock;
+ (void) fetchYelpLocationsOfType: (NSString *)type atLatitude: (NSString *)latitude andLongitude: (NSString *)longitude withCompletion:(void (^)(NSDictionary *locations))completionBlock;

@end
