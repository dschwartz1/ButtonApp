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

- (void) push:(LocationEntry*) location {
    [self.locStack addObject:location];

    // last object in array is most recent - the head of the stack
    self.head = [self.locStack lastObject];
    self.empty = FALSE;
    
    // trying to set timestamp....
    // bug: how to set readonly?-->     self.head.creationDate = [NSDate date];
    
    
}

- (LocationEntry *) pop {
    LocationEntry *poppedEntry;
    if (!self.empty){
        poppedEntry = [self.locStack lastObject]; //***  BUG seems to be here.....
        
        [self.locStack removeLastObject];
//        self.head = [self.locStack lastObject];  //**********  not sure we need this; beware empty stack.

        return poppedEntry;
     } else {
         self.empty = TRUE;
         return nil;
     }

}


- (void) pushToServer {
    // This method will push the location entries to the persistent server and clear the stack
}

-(void) flush {
    [self.locStack removeAllObjects];
    self.head = nil;
}
@end
