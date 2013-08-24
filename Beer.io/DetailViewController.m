//
//  DetailViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "DetailViewController.h"
#import "BreweryDetailsViewController.h"

@interface DetailViewController () <GMSMapViewDelegate>
- (void)configureView;
@end

@implementation DetailViewController
GMSMapView *mapView_;

@synthesize data;
@synthesize latitude;
@synthesize longitude;
@synthesize breweryLabel;
@synthesize breweryName;




- (void)configureView
{
    mapView_.delegate = self;

}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    [self wayUberButton: marker.userData];
}

- (void)viewDidLoad
{  
    NSArray *breweryArray = data;
    
    NSDictionary *brewery;
    
    brewery= [breweryArray objectAtIndex:0];
    
    double mapLatit = latitude;
    double mapLongit = longitude;
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapLatit
                                                            longitude:mapLongit
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

    
    
    for(int i=0; i<[breweryArray count];i++)
    {
        
        brewery= [breweryArray objectAtIndex:i];
        
        NSDictionary *location = [brewery objectForKey:@"brewery"];
        NSDictionary *images = [location objectForKey:@"images"];
        NSString *icon = [images objectForKey:@"icon"];
        
        double latit = [[brewery objectForKey:@"latitude"] doubleValue];
        double longit = [[brewery objectForKey:@"longitude"] doubleValue];
        
        
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.icon = [UIImage imageNamed:@"marker.png"];
        marker.position = CLLocationCoordinate2DMake(latit, longit);
        marker.title = [location objectForKey:@"name"];
        NSString *desc = [location objectForKey:@"description"];
        if(desc == NULL){
            desc = @"";
        }
        NSString *web = [location objectForKey:@"website"];
        if(web == NULL){
            web = @"N/A";
        }
        
        NSString *phone = [brewery objectForKey:@"phone"];
        if(phone == NULL){
            phone = @"N/A";
        }
        marker.snippet =  [NSString stringWithFormat:@"%@  -   %@   - %@", phone, web, desc];
        marker.map = mapView_;
        marker.userData = [location objectForKey: @"id"];
        NSLog(marker.userData);
        
        
       
    }
    
    
    
    
    
  
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
   
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wayUberButton:(id)sender {
    NSLog(@"merica");
    NSLog(sender);
    [self performSegueWithIdentifier:(@"getDetails") sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"getDetails"]) {
        BreweryDetailsViewController *destController = segue.destinationViewController;
        destController.breweryId = sender;
        
         
    }
         }
@end
