//
//  BreweryDetailsViewController.m
//  Beer.io
//
//  Created by Tony Winters on 8/24/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "BreweryDetailsViewController.h"

@interface BreweryDetailsViewController ()

@end

@implementation BreweryDetailsViewController
@synthesize breweryId;
NSArray *recipes;






- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BITCHES AND HOES");
    NSLog(breweryId);
    
	// Do any additional setup after loading the view.
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
   
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    return cell;
}


@end
