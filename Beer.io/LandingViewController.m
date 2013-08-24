//
//  LandingViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "LandingViewController.h"
#import "DetailViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LandingViewController ()


@end



@implementation LandingViewController

@synthesize cityField;
@synthesize stateField;
@synthesize cityStateField;
CLLocationManager *locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
        
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}


- (IBAction)currentLocation:(id)sender {
}

- (IBAction)searchButton:(id)sender {
      
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    brewerydbconnect *connection = [[brewerydbconnect alloc] init];
    NSString *returnedJSON;
    if ([segue.identifier isEqualToString:@"toResults"]) {
        
        NSString *city = [cityField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *region = [stateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        city = [city stringByReplacingOccurrencesOfString:@" "
                                               withString:@"+"];
        region = [region stringByReplacingOccurrencesOfString:@" "
                                                   withString:@"+"];
        returnedJSON = [connection getLocations:(city) withRegion:(region)];

        
        
    }
    
    else if([segue.identifier isEqualToString:@"toResultsCurrentLocation"]){

        returnedJSON = [connection getCityState:(locationManager.location.coordinate.latitude) withLong:(locationManager.location.coordinate.longitude)];

        
    }
    DetailViewController *destViewController = segue.destinationViewController;
    destViewController.data = returnedJSON;
}
@end
