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




- (void)configureView
{
    mapView_.delegate = self;

}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    DetailViewController *landscapeCoverController = [[DetailViewController alloc] init];
    [self presentModalViewController:landscapeCoverController animated:YES];
    
}

- (void)viewDidLoad
{
    
    
    NSError *jsonParsingError = nil;
    NSData *json=[data dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json
                                                               options:0
                                                                 error:&jsonParsingError];
    
    NSArray *breweryArray = [jsonObject objectForKey:@"data"];
    
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
        marker.snippet = [location objectForKey:@"description"];
        marker.map = mapView_;
        
        
       
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


@end
