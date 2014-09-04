//
//  TMFYelpAPIClient.m
//  corelocationPractice
//
//  Created by Tarik Fayad on 7/28/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import "TMFYelpAPIClient.h"
#import "OAuthConsumer.h"

NSString *const CONSUMER_KEY = @"Qv2juF5Td1VYLYmWvZ30PA";
NSString *const CONSUMER_SECRET = @"cXpBB5DPDEwuofi_FkyGCZ-x42Q";
NSString *const TOKEN = @"7V1I7fWNZ2hVHcHqt6RlPyuf0N7frr9E";
NSString *const TOKEN_SECRET = @"TlOeGtZdmOOUZyh-ILGDDHZOPis";

@implementation TMFYelpAPIClient

+ (void) fetchYelpLocationsOfType: (NSString *)type inCity: (NSString *)city WithCompletion:(void (^)(NSDictionary *locations))completionBlock
{
    NSString *escapedCity = [city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"http://api.yelp.com/v2/search?term=%@&location=%@", type, escapedCity];
    
    NSURL *url= [NSURL URLWithString:urlString];
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET];
    OAToken *token = [[OAToken alloc] initWithKey:TOKEN secret:TOKEN_SECRET];
    
    id <OASignatureProviding, NSObject> provider = [OAHMAC_SHA1SignatureProvider new];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
                                    initWithURL:url
                                    consumer:consumer
                                    token:token
                                    realm:nil
                                    signatureProvider:provider];
    
    [request prepare];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *locations = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completionBlock (locations);
    }];
    
    [task resume];
}

+ (void) fetchYelpLocationsOfType: (NSString *)type atLatitude: (NSString *)latitude andLongitude: (NSString *)longitude withCompletion:(void (^)(NSDictionary *locations))completionBlock
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://api.yelp.com/v2/search?term=%@", type];
    [urlString appendString:[NSString stringWithFormat:@"&ll=%@,%@", latitude, longitude]];
    NSURL *url = [NSURL URLWithString: urlString];
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET];
    OAToken *token = [[OAToken alloc] initWithKey:TOKEN secret:TOKEN_SECRET];
    
    id <OASignatureProviding, NSObject> provider = [OAHMAC_SHA1SignatureProvider new];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
                                    initWithURL:url
                                    consumer:consumer
                                    token:token
                                    realm:nil
                                    signatureProvider:provider];
    
    [request prepare];


    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *locations = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completionBlock (locations);
    }];

    [task resume];
}


+ (void)fetchYelpLocationsOfType:(NSString *)type atLatitude:(NSString *)latitude andLongitude:(NSString *)longitude withinRadius:(NSNumber *)radius withCompletion:(void (^)(NSDictionary *))completionBlock
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://api.yelp.com/v2/search?term=%@", type];
    [urlString appendString:[NSString stringWithFormat:@"&ll=%@,%@", latitude, longitude]];
    [urlString appendString:[NSString stringWithFormat:@"&radius_filter=%@",radius]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET];
    OAToken *token = [[OAToken alloc] initWithKey:TOKEN secret:TOKEN_SECRET];
    
    id <OASignatureProviding, NSObject> provider = [OAHMAC_SHA1SignatureProvider new];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
                                    initWithURL:url
                                    consumer:consumer
                                    token:token
                                    realm:nil
                                    signatureProvider:provider];
    
    [request prepare];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *locations = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completionBlock(locations);
    }];
    
    [task resume];
}

//#pragma mark - OAuth Methods
//+ (OAMutableURLRequest *) generateOARequestWithURL: (NSURL *)url andRealm: (NSString *) realm
//{
//    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET];
//    OAToken *token = [[OAToken alloc] initWithKey:TOKEN secret:TOKEN_SECRET];
//    
//    id <OASignatureProviding, NSObject> provider = [OAHMAC_SHA1SignatureProvider new];
//    
//    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
//                                    initWithURL:url
//                                    consumer:consumer
//                                    token:token
//                                    realm:realm
//                                    signatureProvider:provider];
//    
//    return request;
//}

@end