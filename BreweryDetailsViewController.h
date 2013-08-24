//
//  BreweryDetailsViewController.h
//  Beer.io
//
//  Created by Tony Winters on 8/24/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brewerydbconnect.h"

@interface BreweryDetailsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

- (void)setBreweryId:(NSString *)breweryIdHa;

@property (nonatomic, strong) NSString *breweryId;



@end
