//
//  brewerydbconnect.h
//  Beer.io
//
//  Created by AJ DaNelz on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brewerydbconnect : NSObject
- (NSString *) getResponse:(NSString *) url;
- (NSString *) getLocations: (NSString *)city withRegion:(NSString *)region;
- (NSString *) getLocations: (NSString *)region;
- (NSString *) getAllLocations;
- (NSString *) getAllLocations: (int) page;
- (NSString *) getLocation: (NSString *)locationId;
- (NSString *) searchBrewerys: (NSString *)query;
- (NSString *) getBrewery: (NSString *)brewId;
- (NSString *) getBreweryBeers: (NSString *)brewId;
- (NSString *) getCityState:(float)lat withLon:(float)lon;
- (NSString *) getCityState:(NSString *)q;

@end
