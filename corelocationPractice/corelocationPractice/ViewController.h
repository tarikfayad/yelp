//
//  ViewController.h
//  corelocationPractice
//
//  Created by Tarik Fayad on 7/28/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *locationsArray;

@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet UILabel *horizontalAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *altitude;
@property (weak, nonatomic) IBOutlet UILabel *verticalAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property(strong, nonatomic) CLLocation *startLocation;
- (IBAction)resetDistance:(id)sender;


@end

