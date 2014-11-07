//
//  AddLocationViewController.m
//  Button1
//
//  Created by David Schwartz on 11/4/14.
//  Copyright (c) 2014 David Schwartz. All rights reserved.
//

#import "AddLocationViewController.h"
#import "LocationEntry.h"
#import "LocationStack.h"

@interface AddLocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationField;
@property NSMutableArray *locationArray; //  ***** FIX THIS TO USE STACK INSTEAD OF THIS ARRAY ******
@property LocationEntry *location;
@end

@implementation AddLocationViewController

- (IBAction)getLocation:(id)sender {
    //  Get the location, put it in a string
    //  Set the model to the location string
    //  Future:  push the location to the server (or do that in the model?)
    //  Show the location string on the debug version of the app
    
    NSString *tempLoc = @"50 California St., San Francisco, CA";   // Get the location
    LocationEntry *loc = [[LocationEntry alloc] init];              // Initialize a Location object
    loc.name = tempLoc;                                             // Set the name of the instance
    [self.locationArray addObject:loc];                             // Add the object to the array (stack)
    self.locationField.text = loc.name;
    
}

- (IBAction)clearLocation:(id)sender {
    // via an invisible button, clear the location string from the display
    self.locationField.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //start with local array, then refactor with LocationStack
    
    self.locationArray = [NSMutableArray array];            // the same as alloc init?
//    LocationEntry *loc = [[LocationEntry alloc] init];      // initialize a location Model item
//    self.location = loc;                                    // set view controller property to the (empty) item
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
