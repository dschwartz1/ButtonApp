//
//  LocationEntry.h
//  Button1
//
//  Created by David Schwartz on 11/3/14.
//  Copyright (c) 2014 David Schwartz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationEntry : NSObject

@property CLPlacemark *place;

@property (readonly) NSDate *creationDate;

@end
