//
//  BeerDetailViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/24/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "BeerDetailViewController.h"

@interface BeerDetailViewController ()

@end

@implementation BeerDetailViewController

@synthesize beerName;
@synthesize beerNameLabel;


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
    beerNameLabel.text = beerName;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
