//
//  brewerydbconnect.m
//  Beer.io
//
//  Created by AJ DaNelz on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import "brewerydbconnect.h"

@implementation brewerydbconnect

- (NSString *) getLocations:(NSString *)city withRegion:(NSString *)region{
    
    NSString *url = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/locations?key=fb8684f5499a9dad231f262efca6b2f5&locality=%@&region=%@", city, region];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

@end
