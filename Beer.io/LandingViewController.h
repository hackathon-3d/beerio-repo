//
//  LandingViewController.h
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brewerydbconnect.h"


@interface LandingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UITextField *cityStateField;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (IBAction)currentLocation:(id)sender;


- (IBAction)searchButton:(id)sender;

@end
