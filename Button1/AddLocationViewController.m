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
#import <CoreLocation/CoreLocation.h>

@interface AddLocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationField;
@property LocationStack *locStack;  // note done...paused here....
@property LocationEntry *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *bestEffortAtLocation;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@end

//======================================================================================
@implementation AddLocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _locStack = [[LocationStack alloc] init];           // initialize the location stack
    _currentLocation = [[LocationEntry alloc] init];  // same as self.currentLocation = ...
    
}

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return _dateFormatter;
}

#pragma mark - Location Manager Stuff

- (IBAction)getLocation:(id)sender {
// -----------------  TEMP LOCATIONS -----------------------------------------
    NSString *tempLoc = @"Linq Hotel, Las Vegas, NV";   // Get the location
    NSString *tempLoc2 = @"2855 Scott St., San Francisco, CA";
    NSString *tempLoc3 = @"50 California St., San Francisco, CA";
    static int n = 0;
    


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
    
// -------------------END TEMP STUFF -----------------------------------------

// Test the current authorization status of this app to use Location Services
    
    (CLAuthorizationStatus *)status = [CLLocationManager authorizationStatus];
    
    
    // Create the core location manager object
    
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    

    
    
    
    
    
    
    
    
    self.currentLocation = [[LocationEntry alloc] init]; // Initialize a Location object every button push
    self.currentLocation.name = tempLocation;  //replace with getting real geo-coordinate
    self.currentLocation.creationDate = [NSDate date];
    
    [self.locStack push:self.currentLocation]; // push onto stack for permanent storage
  
    
    
    
    NSString *formattedDateString = [self.dateFormatter stringFromDate:self.currentLocation.creationDate];
    NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, formattedDateString];
    
    
    self.locationField.text = displayString;
    
    
}








- (IBAction)clearLocation:(id)sender {
    // via an invisible button, clear the location string from the display
    
    // Set the date formatting appropriately
    


    [self.locStack pop];
    if( !self.locStack.empty){          // or could just test currentLocation for nil in next line...
        self.currentLocation = self.locStack.head;
        NSString *formattedDateString = [self.dateFormatter stringFromDate:self.currentLocation.creationDate];
        NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, formattedDateString];
        self.locationField.text = displayString;
    } else {
        self.locationField.text = @"";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// =========================================================================================
//                LOCATION SERVICES STUFF


// Request permission to use location services
/*
+ (CLAuthorizationStatus)authorizationStatus;

- (void) requestWhenInUseAuthoriztion {
    
    
}
*/
 
/*
 - (void)startSignificantChangeUpdates
 {
    // Create the location manager if this object does not already have one
     if( nil == locationManager)
         locationManager = [[CLLocationManager alloc] init];
     
     locationManager.delegate = self;
     
 
 */
 
 
 

//==========================================================================================
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
