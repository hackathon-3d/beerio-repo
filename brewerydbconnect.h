//
//  brewerydbconnect.h
//  Beer.io
//
//  Created by AJ DaNelz on 8/23/13.
//  Copyright (c) 2013 Tony Winters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brewerydbconnect : NSObject
- (NSString *) getLocations: (NSString *)city withRegion:(NSString *)region;
@end