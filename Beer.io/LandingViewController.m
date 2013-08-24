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
        float lat = locationManager.location.coordinate.latitude;
        float lon = locationManager.location.coordinate.longitude;
        
        returnedJSON = [connection getCityState:(lat) withLon:(lon)];

        
    }
    NSLog(returnedJSON);
    NSError *jsonParsingError = nil;
    NSData *json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                               options:0
                                                                 error:&jsonParsingError];
    
    NSArray *results = [jsonObject objectForKey:@"results"];
    NSDictionary *addressStuff = [results objectAtIndex:0];
    NSArray *addressComp = [addressStuff objectForKey:@"address_components"];
    NSString *rCity;
    NSString *rState;
    for (int i = 0; i < [addressComp count]; i++) {
        Boolean locality = false;
        Boolean state = false;
        NSString *res = [[addressComp objectAtIndex:i] objectForKey:@"long_name"];
        NSArray *types = [[addressComp objectAtIndex:i] objectForKey:@"types"];
        for (int j = 0; j < [types count]; j++) {
            NSString *type = [types objectAtIndex:j];
            if ([type isEqualToString:@"locality"]){
                locality = true;
            }else if ([type isEqualToString:@"administrative_area_level_1"]){
                state = true;
            }
        }

        if(locality){
            rCity = res;
            locality = false;
        }
        if (state) {
            rState = res;
            state = false;
        }
    }
    
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
