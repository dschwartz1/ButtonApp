//
//  AddLocationViewController.m
//  Button1
//
//  Created by David Schwartz on 11/4/14.
//  Copyright (c) 2014 David Schwartz. All rights reserved.
//

//  Creates view of Button
//  Creates location manager object at creation of view
//  0.1  Captures location upon a button push, stores in stack.

#import "AddLocationViewController.h"
#import "LocationEntry.h"
#import "LocationStack.h"
#import <CoreLocation/CoreLocation.h>

@interface AddLocationViewController ()                             // Conforms to CLLocationManagerDelegate protocol

@property (weak, nonatomic) IBOutlet   UILabel  *locationField;     // hidden field in the button to show the location
@property                         LocationStack *locStack;          // note done...paused here....
@property                         LocationEntry *currentLocation;   // The latest captured location. May initially be stale...

@property (nonatomic, strong) CLLocationManager *locationManager;   //** any issue if view/app goes into background?
@property (nonatomic) CLLocationAccuracy         desiredAccuracy;
@property (nonatomic, strong) CLLocation        *bestEffortAtLocation;
@property (nonatomic, strong) NSDateFormatter   *dateFormatter;
@property (nonatomic) CLGeocoder                *getAddress;        // Reverse geo-codes lat&long to get address


@end

//==============================================================================

@implementation AddLocationViewController

//--------------------------------------------------------------------------------

- (void)viewDidLoad {                                   // When the button view first loads, check perms and init
    [super viewDidLoad];
// Do any additional setup after loading the view.
    
    _locStack = [[LocationStack alloc] init];           // initialize the location stack
    _currentLocation = [[LocationEntry alloc] init];    // init a currentLocation
    
    
// Create the core location manager object
    if (_locationManager == nil) {                      // Check if already created - probably unnecessary
        _locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;        // Set Desired accuracy.
    self.locationManager.distanceFilter = kCLDistanceFilterNone;           // Monitor all movements  *** Change to 20ft?
    // Must be set to None in order to use Deferred Updates Until...
    
    
// Check if this App is authorized to use Location Services
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    if (authStatus == kCLAuthorizationStatusNotDetermined){         // If not determined, ask for permission
        [self.locationManager requestAlwaysAuthorization];
        // how to properly exit the app if location services is not allowed?
    }
    else if (false) {                                               // ** Add other checks here
        // Do what if not allowed? Show some message until location permission is received...
    }
    
}

//--------------------------------------------------------------------------------

- (NSDateFormatter *)dateFormatter {                        // Utility function for formatting dates
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return _dateFormatter;
}


//=================================================================================================
#pragma mark - Location Manager Stuff

/* ---- This was .1 implementation. Hard-coded locations, push locations on to stack each button push.

- (IBAction)getLocation:(id)sender {                        // Called when the button is pressed. Get current location and save.
 
    
    //   TEMP LOCATIONS -----------------------------------------
    NSString *tempLoc = @"Rose's Cafe, Union St., San Francisco, CA";
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
    
    //   END TEMP STUFF -----------------------------------------


    
    
    self.currentLocation = [[LocationEntry alloc] init];    // Initialize a Location object every button push
    self.currentLocation.name = tempLocation;               // **replace with getting real geo-coordinate
    
    
    self.currentLocation.creationDate = [NSDate date];
    
    [self.locStack push:self.currentLocation];              // push onto stack for permanent storage
  
    
    
    
    NSString *formattedDateString = [self.dateFormatter stringFromDate:self.currentLocation.creationDate];
    NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, formattedDateString];
    
    
    self.locationField.text = displayString;                // display current location
    
    
}

*/

- (IBAction)getLocation:(id)sender {
    //  0.2 implementation - Button press toggles location tracking On and Off.
    //   - Pushing button once turns ON location tracking
    //   - Location changes immediately update UI
    //   - Pushing button again turns OFF location tracking
    

    static int n = 0;           // 0 means location tracking is OFF
    

    if (n == 0){
        [self.locationManager startUpdatingLocation];
        n = 1;
    }
    else {
        [self.locationManager stopUpdatingLocation];
        n = 0;
    }
    
    
    // removed setting self.currentLocation properties and pushing onto the stack.
    
}

//--------------------------------------------------------------------------------


- (IBAction)clearLocation:(id)sender {
    // via an invisible button, clear the location string from the display
    
    // Set the date formatting appropriately
    


    [self.locStack pop];
    if( !self.locStack.empty){          // or could just test currentLocation for nil in next line...
        self.currentLocation = self.locStack.top;
        NSString *formattedDateString = [self.dateFormatter stringFromDate:self.currentLocation.creationDate];
        NSString *displayString = [NSString stringWithFormat:@"%@\n%@", self.currentLocation.name, formattedDateString];
        self.locationField.text = displayString;
    } else {
        self.locationField.text = @"";
    }
}

//--------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//--------------------------------------------------------------------------------

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // Notifies the delegate object (this object) that new location data is available.
    // This method is REQUIRED, part of the CLLocationManagerDelegate protocol

    // It is called from/on the main event loop every time new data is available.
    
    // Most recent update is the last item in the array.
    
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 5.0) {                              // ignore updates older than 5 secs
    
        NSString *timeStamp = [self.dateFormatter stringFromDate:location.timestamp];
        
        CLLocationSpeed mph = (location.speed * 2.23694);
        if (mph < 0) mph = 0;
        
    /*    NSString *displayString = [NSString stringWithFormat:@"Lat: %3.0f Lng: %3.0f %@\nDir: %3.0f Alt: %3.0f Acc: %3.0f MPH: %2.0f",
                                   location.coordinate.latitude,
                                   location.coordinate.longitude,
                                   timeStamp,
                                   location.course,
                                   location.altitude,
                                   location.horizontalAccuracy,
                                   mph
                                   ];
        self.locationField.text = displayString;
    */
        
    // if > 15 sec, and location has changed by 10 M horizontally, and accuracy is within 10 M, do place lookup, and push location onto stack.  Goal is to know exactly which house someone is at, and if they go to another house.
        
    // Re-factor this to push, reverse geo-code (get address), and display location data as separate methods.
        
        if (!_getAddress){
            _getAddress = [[CLGeocoder alloc] init];
        }
        

        [_getAddress reverseGeocodeLocation:location completionHandler:
         ^(NSArray *placemarks, NSError *error) {
             NSString *dispStr = nil;
             CLPlacemark *place = nil;     // ** replace with LocationEntry later
             NSString *address = nil;
             CLLocationDirection direction;
             NSString *dirString = nil;
             NSString *areasOfInterest = nil;
             NSString *aoiString = nil;
             
             if (error.code == kCLErrorNetwork){
                 self.locationField.text = @"Too many place lookups per minute...";
             } else if ([placemarks count] > 0){
                 place = [placemarks lastObject];
                 address = place.subThoroughfare;
                 if ([address length] == 0) {
                     address = @"";
                 }
                 if (place.areasOfInterest != nil){
                     areasOfInterest = place.areasOfInterest[0];
                     aoiString = areasOfInterest;
                 }
                 else {
                     aoiString = @"";
                 }
                 direction = location.course;
                 if (((direction >= 0) && (direction <= 45)) || (direction > 315)){
                     dirString = @"North";
                 }
                 else if((direction > 45) && (direction <= 135)){
                     dirString = @"East";
                 } else if ((direction > 135) && (direction <= 225)){
                     dirString = @"South";
                 } else dirString = @"West";
                 double accuracyFeet = location.horizontalAccuracy * 3.28084;
//                 dispStr = [NSString stringWithFormat: @"%@\n%@ %@, %@, %@\n%@ at %2.0f MPH +/-%3.0fft",
                 dispStr = [NSString stringWithFormat: @"%@\n%@ %@, %@, %@\n %@  +/-%3.0fft",

                            timeStamp,
                            address,
                            place.thoroughfare,
                            place.locality,
                            place.administrativeArea,
//                            dirString,
//                            mph,
                            aoiString,              //Testing this....
                            accuracyFeet];
                 self.locationField.text = dispStr;

             }
         }];
    }
    // Call Deferred Updates here....
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    // Tells the delgate that location updates were paused.
    // This method is REQUIRED, part of the CLLocationManagerDelegate protocol
}

- (void) locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    // Tells the delegate that location updates have been resumed.
    // This method is REQUIRED, part of the CLLocationManagerDelegate protocol

}

- (void) locationManager: (CLLocationManager *) manager didFinishDeferredUpdatesWithError:(NSError *)error{
    // Tells the delgate that location updates will no longer be deferred.
    // E.g. called when timeout or distance parameter is met
    // This method is OPTIONAL, part of the CLLocationManagerDelegate protocol

}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // Tells the delegate that the location manager service was unable to retreive a location value
    // This method is OPTIONAL, part of the CLLocationManagerDelegate protocol

}


- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // Tells the delegate that the autorization status to use Location Service has changed
    // This method is OPTIONAL, part of the CLLocationManagerDelegate protocol

}

//--------------------------------------------------------------------------------

//- (void) locationToAddress:(CLLocation *)location

// =========================================================================================
//                LOCATION SERVICES STUFF


// Request permission to use location services
/*
+ (CLAuthorizationStatus)authorizationStatus;

- (void) requestWhenInUseAuthoriztion {
    
    
}
*/

// locationManager:didChangeAuthorizationStatus  // method returns after prompting for auth
 
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
