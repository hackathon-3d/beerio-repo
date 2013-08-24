//
//  brewerydbconnect.m
//  Beer.io
//
//  Created by AJ DaNelz on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "brewerydbconnect.h"
#define apiKey @"fb8684f5499a9dad231f262efca6b2f5"

@implementation brewerydbconnect

- (NSString *) getResponse:(NSString *) url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSLog(url);
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSString *) getLocations:(NSString *)city withRegion:(NSString *)region{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/locations?key=%@&locality=%@&region=%@",apiKey, city, region];
    
    return [self getResponse:url];
}

- (NSString *) getLocations:(NSString *)region{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/locations?key=%@&region=%@",apiKey, region];
    
    return [self getResponse:url];
}

- (NSString *) getAllLocations{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/locations?key=%@",apiKey];
    
    return [self getResponse:url];
}

- (NSString *) getAllLocations: (int)page{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/locations?key=%@&p=%i",apiKey, page];
    
    return [self getResponse:url];
}

- (NSString *) getLocation: (NSString *)locationId{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/location/%@?key=%@", locationId,apiKey];
    
    return [self getResponse:url];
}
- (NSString *) searchBrewerys: (NSString *)query{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/search?key=%@&q=%@", apiKey, query];
    
    return [self getResponse:url];
}
- (NSString *) getBrewery: (NSString *)brewId{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/brewery/%@?key=%@", brewId, apiKey];
    
    return [self getResponse:url];
}
- (NSString *) getBreweryBeers: (NSString *)brewId{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/brewery/%@/beers?key=%@", brewId, apiKey];
    
    return [self getResponse:url];
}



- (NSString *) getCityState:(float)lat withLon:(float)lon{
    
    NSString *url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false", lat, lon];
    
    return [self getResponse:url];
}
- (NSString *) getCityState:(NSString *)q{
    
    NSString *url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", q];
    
    return [self getResponse:url];
}

@end
