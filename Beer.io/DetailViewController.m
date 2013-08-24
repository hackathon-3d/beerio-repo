//
//  DetailViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
GMSMapView *mapView_;
@synthesize data;



#pragma mark - Managing the detail item


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
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
    
    double mapLatit = [[brewery objectForKey:@"latitude"] doubleValue];
    double mapLongit = [[brewery objectForKey:@"longitude"] doubleValue];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapLatit
                                                            longitude:mapLongit
                                                                 zoom:8];
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
        marker.position = CLLocationCoordinate2DMake(latit, longit);
        marker.title = [location objectForKey:@"name"];
        marker.snippet = [brewery objectForKey:@"phone"];
        marker.map = mapView_;
        
        
       
    }
    
    
    
    
    
    
  
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
