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
        
        NSString *query = [cityStateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        query = [query stringByReplacingOccurrencesOfString:@" "
                                               withString:@"+"];
        returnedJSON = [connection getCityState:(query)];
        
    }
    
    else if([segue.identifier isEqualToString:@"toResultsCurrentLocation"]){

        returnedJSON = [connection getCityState:(locationManager.location.coordinate.latitude) withLong:(locationManager.location.coordinate.longitude)];

        
    }
    NSLog(returnedJSON);
    NSError *jsonParsingError = nil;
    NSData *json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                               options:0
                                                                 error:&jsonParsingError];
    
    NSArray *results = [jsonObject objectForKey:@"results"];
    NSDictionary *addressStuff = [results objectAtIndex:0];
    NSArray *address = [addressStuff objectForKey:@"address_components"];
    for (int i = 0; i < [address count]; i++) {
        NSString *res = [[address objectAtIndex:i] objectForKey:@"long_name"];
        NSLog(res);
    }
    int index1 = [address count]-3;
    int index2 = [address count]-2;
    NSDictionary *city = [address objectAtIndex:index1];
    NSDictionary *region = [address objectAtIndex:index2];
    NSString *rCity = [city objectForKey:@"long_name"];
    NSString *rState = [region  objectForKey:@"long_name"];
    
    rCity = [rCity stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    rState = [rState stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    rCity = [rCity stringByReplacingOccurrencesOfString:@" "
                                             withString:@"+"];
    rState = [rState stringByReplacingOccurrencesOfString:@" "
                                               withString:@"+"];
    
    
    returnedJSON = [connection getLocations: rCity withRegion: rState];

    DetailViewController *destViewController = segue.destinationViewController;
    destViewController.data = returnedJSON;
}
@end
