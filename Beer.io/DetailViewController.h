//
//  DetailViewController.h
//  Beer.io
//
//  Created by Tony Winters on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) GMSMapView *mapView_;

@end
