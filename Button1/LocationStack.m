//
//  LocationStack.m
//  Button1
//
//  Created by David Schwartz on 11/4/14.
//  Copyright (c) 2014 David Schwartz. All rights reserved.
//

#import "LocationStack.h"
#import "LocationEntry.h"

@interface LocationStack()
@property NSMutableArray *locArray;
@end


@implementation LocationStack

- (void) add:location {
    [self.locArray addObject:location];

    // last object in array is most recent - the head of the stack
    self.head = [self.locArray lastObject];
    
    // trying to set timestamp....
    // bug: how to set readonly?-->     self.head.creationDate = [NSDate date];
    
    
}

- (void) pushToServer {
    // This method will push the location entries to the persistent server and clear the stack
}
@end
