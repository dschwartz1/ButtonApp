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
@property LocationStack *locStack;  // note done...paused here....
@property LocationEntry *currentLocation;

@end

//======================================================================================
@implementation AddLocationViewController

- (IBAction)getLocation:(id)sender {
    //  Get the location, put it in a string
    //  Set the model to the location string
    //  Future:  push the location to the server (or do that in the model?)
    //  Show the location string on the debug version of the app

/* -----------------  TEMP LOCATIONS ----------------------------------------- */
    NSString *tempLoc = @"Marin Country Day School, Corte Madera, CA";   // Get the location
    NSString *tempLoc2 = @"2855 Scott St., San Francisco, CA";
    NSString *tempLoc3 = @"50 California St., San Francisco, CA";
    static int n = 0;
    
/* --------------------------------------------------------------------------- */

    self.currentLocation = [[LocationEntry alloc] init];    // Initialize a Location object every button push

/* --------------------------------------------------------------------------- */
//         **********  temp stuff here *************
    NSString *tempLocation;
    
    if (n == 0) {
        tempLocation = tempLoc;
        n++;
    } else if (n == 1) {
        tempLocation = tempLoc2;
        n++;
    } else {  // n == 2
        tempLocation = tempLoc3;
        n = 0;
    }
    
/* --------------------------------------------------------------------------- */

    self.currentLocation.name = tempLocation;  //replace with getting real geo-coordinate
    self.currentLocation.creationDate = [NSDate date];
    
    [self.locStack push:self.currentLocation]; // push onto stack for permanent storage
    
    NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, self.currentLocation.creationDate];    // Include location and datetimestamp
    
    self.locationField.text = displayString;
    
//    self.locationField.text = self.currentLocation.name;  // set the diag display to the current location
    
}

- (IBAction)clearLocation:(id)sender {
    // via an invisible button, clear the location string from the display
    [self.locStack pop];
    if( !self.locStack.empty){          // or could just test currentLocation for nil in next line...
        self.currentLocation = self.locStack.head;
        NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, self.currentLocation.creationDate];    // Include location and datetimestamp
        self.locationField.text = displayString;
    } else {
        self.locationField.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //start with local array, then refactor with LocationStack
    
//    self.locationArray = [NSMutableArray array];            // the same as alloc init?
      self.locStack = [[LocationStack alloc] init];           // initialize the location stack
      self.currentLocation = [[LocationEntry alloc] init];

    
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
