//
//  LandingViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "LandingViewController.h"
#import "DetailViewController.h"

@interface LandingViewController ()


@end



@implementation LandingViewController

@synthesize cityField;
@synthesize stateField;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
@end
