//
//  LocationStack.h
//  Button1
//
//  Location Stack is a stack (array) of LocationEntries
//  The head is the top of the stack (where add and pop to and from).
//
//  Created by David Schwartz on 11/4/14.
//  Copyright (c) 2014 David Schwartz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationEntry.h"

@interface LocationStack : NSObject

@property LocationEntry *top;
@property BOOL empty;

- (id) init;
- (void) push:(LocationEntry*) location;
- (LocationEntry *) pop;

@end
