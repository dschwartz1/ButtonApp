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
@property NSMutableArray *locStack;
@end


@implementation LocationStack

- (id) init {
    self = [super init];
    
    if(self) {
        self.locStack = [[NSMutableArray alloc] init];
    }
    self.top = nil;
    self.empty = TRUE;
    
    return self;
}

- (void) push:(LocationEntry*) location {
    // Push the given location entry onto the stack and reset the head to point to it
    
    [self.locStack addObject:location];

    // last object in array is most recent - the head of the stack  ****>> change to Top and Bottom - top is most recent
    self.top = [self.locStack lastObject];
    self.empty = FALSE;
    
    // trying to set timestamp....
    // bug: how to set readonly?-->     self.head.creationDate = [NSDate date];
    
    
}

- (LocationEntry *) pop {
    // Pop the current location from the stack
    // Reset the head to the new location at the top of the stack, or nil if empty
    // Reset the .empty flag as appropriate.
    
    LocationEntry *newHead;
    if (!self.empty){
        [self.locStack removeLastObject];
        newHead = [self.locStack lastObject];
        self.top = newHead;
        if( [self.locStack count] == 0){
            self.empty = TRUE;
        }
        return newHead;
        
     } else {
         return nil;
     }

}


- (void) pushToServer {
    // This method will push the location entries to the persistent server and clear the stack
}

-(void) flush {
    [self.locStack removeAllObjects];
    self.top = nil;
}
@end
