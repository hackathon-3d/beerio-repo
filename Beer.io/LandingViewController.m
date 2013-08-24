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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    brewerydbconnect *connection = [[brewerydbconnect alloc] init];
    NSString *returnedJSON;
    NSError *jsonParsingError;
    NSData *json;
    NSDictionary *jsonObject;
    NSString *rCity;
    NSString *rState;
    float lat = 0;
    float lon = 0;
    if ([segue.identifier isEqualToString:@"toResults"]) {
        
        NSString *query = [cityStateField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        query = [query stringByReplacingOccurrencesOfString:@" "
                                                 withString:@"+"];
        returnedJSON = [connection getCityState:(query)];
        json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
        
        
        jsonParsingError = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                                   options:0
                                                                     error:&jsonParsingError];
        
        NSArray *results = [jsonObject objectForKey:@"results"];
        if ([results count] == 0) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to find Beer"
                                                              message:@"Make sure you are connected Bitch!"
                                                             delegate:self
                                                    cancelButtonTitle:@"Try Again"
                                                    otherButtonTitles:nil];
            [message show];
            returnedJSON = @"";
        } else{
            NSDictionary *addressStuff = [results objectAtIndex:0];
            NSArray *addressComp = [addressStuff objectForKey:@"address_components"];
            
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
            if (rCity == NULL && rState == NULL ) {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to find Beer"
                                                                  message:@"Make sure you are connected Bitch!"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Try Again"
                                                        otherButtonTitles: nil];
                [message show];
                returnedJSON = @"";
            }
            else{
                returnedJSON = [connection getCityState:(query)];
                json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                                           options:0
                                                                             error:&jsonParsingError];
                NSArray *results = [jsonObject objectForKey:@"results"];
                if ([results count] == 0) {
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to find Beer"
                                                                      message:@"Make sure you are connected Bitch!"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Try Again"
                                                            otherButtonTitles:nil];
                    [message show];
                    returnedJSON = @"";
                } else{
                    NSDictionary *addressStuff = [results objectAtIndex:0];
                    NSDictionary *geo = [addressStuff objectForKey:@"geometry"];
                    NSDictionary *location = [geo objectForKey:@"location"];
                    NSString *latS = [location objectForKey:@"lat"];
                    NSString *lonS = [location objectForKey:@"lng"];
                    lat = [latS floatValue];
                    lon = [lonS floatValue];
                    
                }
            }
        }
    }else{
        lat = locationManager.location.coordinate.latitude;
        lon = locationManager.location.coordinate.longitude;
        returnedJSON = [connection getCityState:(lat) withLon:lon];
        json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
        
        
        jsonParsingError = nil;
        jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                                   options:0
                                                                     error:&jsonParsingError];
        
        NSArray *results = [jsonObject objectForKey:@"results"];
        if ([results count] == 0) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to find Beer"
                                                              message:@"Make sure you are connected Bitch!"
                                                             delegate:self
                                                    cancelButtonTitle:@"Try Again"
                                                    otherButtonTitles:nil];
            [message show];
            returnedJSON = @"";
        } else{
            NSDictionary *addressStuff = [results objectAtIndex:0];
            NSArray *addressComp = [addressStuff objectForKey:@"address_components"];
            
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
        }
    }
    
    
    returnedJSON = [connection getLocations:(rState)];
    json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
    jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                               options:0
                                                                 error:&jsonParsingError];
    NSString *numPS = [jsonObject objectForKey:@"numberOfPages"];
    NSString *numLoc = [jsonObject objectForKey:@"totalResults"];
    int  numPages = [numPS integerValue];
    NSArray *allData = [jsonObject objectForKey:@"data"];
    NSArray *tmpData;
    for (int i = 2; i <= numPages; i++) {
        returnedJSON = [connection getAllLocations: (i)];
        json=[returnedJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                                   options:0
                                                                     error:&jsonParsingError];
        tmpData = [jsonObject objectForKey:@"data"];
        allData = [allData arrayByAddingObjectsFromArray:tmpData];
    }
    
    DetailViewController *destViewController = segue.destinationViewController;
    destViewController.data = allData;
    NSLog([NSString stringWithFormat:@"%@ total results. and %i retrieved results",numLoc, [allData count]]);
    destViewController.latitude = lat;
    destViewController.longitude = lon;
}
@end
