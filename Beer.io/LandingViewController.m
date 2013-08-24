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
    if ([segue.identifier isEqualToString:@"toResults"]) {
        brewerydbconnect *connection = [[brewerydbconnect alloc] init];
        
        NSString *city = [cityField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *region = [stateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        city = [city stringByReplacingOccurrencesOfString:@" "
                                               withString:@"+"];
        region = [region stringByReplacingOccurrencesOfString:@" "
                                                   withString:@"+"];
        NSString *returnedJSON = [connection getLocations:(city) withRegion:(region)];

        
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = returnedJSON;
    }
    
    else if([segue.identifier isEqualToString:@"toResultsCurrentLocation"]){
                

        NSString *url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString:url]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
            
        }
        
        NSLog([[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding]);
        
    }
}
@end
