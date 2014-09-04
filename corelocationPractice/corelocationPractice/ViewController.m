//
//  ViewController.m
//  corelocationPractice
//
//  Created by Tarik Fayad on 7/28/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import "ViewController.h"
#import "TMFYelpAPIClient.h"
#import "TMFYelpLocation.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationsArray = [NSMutableArray new];
   
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.startLocation = nil;
    
    [TMFYelpAPIClient fetchYelpLocationsOfType:@"restuarants" inCity:@"New York" WithCompletion:^(NSDictionary *locations) {
        NSLog(@"%@", locations);
    }];
    
    [TMFYelpAPIClient fetchYelpLocationsOfType:@"restaurant" atLatitude:@"40.75609804" andLongitude:@"-73.9857880" withinRadius:@10000 withCompletion:^(NSDictionary *locations) {
        NSLog(@"%@", locations);
        NSLog(@"%lu", (unsigned long)[[locations allKeys] count]);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetDistance:(id)sender {
    self.startLocation = nil;
}

#pragma mark - Core Location Delegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"%@", newLocation);
    CLLocation *oldLocation;
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    }
    
    NSString *latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    [TMFYelpAPIClient fetchYelpLocationsOfType:@"restaurants" atLatitude:latitude andLongitude:longitude withCompletion:^(NSDictionary *locations) {
        NSArray *businesses = locations[@"businesses"];
        for (NSInteger i = 0; i < businesses.count; i++) {
            TMFYelpLocation *location = [TMFYelpLocation new];
            location.name = businesses[i][@"name"];
            location.imageURL = [NSURL URLWithString:businesses[i][@"image_url"]];
            
            [self.locationsArray addObject:location];
        }
        TMFYelpLocation *printLocation = self.locationsArray[0];
        NSLog(@"%@", printLocation.name);
    }];
    
    NSString *currentLatitude = [NSString stringWithFormat:@"%+.6f", newLocation.coordinate.latitude];
    self.latitude.text = currentLatitude;
    
    NSString *currentLongitude = [NSString stringWithFormat:@"%+.6f", newLocation.coordinate.longitude];
    self.longitude.text = currentLongitude;
    
    NSString *currentHorizontalAccuracy = [NSString stringWithFormat:@"%+.6f", newLocation.horizontalAccuracy];
    self.horizontalAccuracy.text = currentHorizontalAccuracy;
    
    NSString *currentVerticalAccuracy = [NSString stringWithFormat:@"%+.6f", newLocation.verticalAccuracy];
    self.verticalAccuracy.text = currentVerticalAccuracy;
    
    NSString *currentAltitude = [NSString stringWithFormat:@"%+.6f", newLocation.altitude];
    self.altitude.text = currentAltitude;
    
    if (self.startLocation == nil) {
        self.startLocation = newLocation;
    }
    
    CLLocationDistance distanceBetween = [newLocation distanceFromLocation:oldLocation];
    NSString *distanceString = [NSString stringWithFormat:@"%f", distanceBetween];
    self.distance.text = distanceString;
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

@end