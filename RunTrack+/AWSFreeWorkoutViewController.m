//
//  AWSFreeWorkoutViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/11/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSFreeWorkoutViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AWSVariables.h"
#import "AWSWorkouts.h"
#import "AWSItemStore.h"

@interface AWSFreeWorkoutViewController () <CLLocationManagerDelegate>

@end

@implementation AWSFreeWorkoutViewController

CLLocationManager *manager;
CLLocation *startingLocation;
NSString *distanceTraveled;
float distanceTraveledNumber;
CLLocation *pausedLocation;
CLLocation *restartingPausedLocation;
BOOL workoutPaused;
CLLocationDistance distancePausedTraveled;
NSDate *workoutStartDate;
NSDate *currentDate;
NSDate *datePaused;
NSTimeInterval secondsSinceWorkoutStart;
NSTimeInterval secondsPaused;
NSTimeInterval secondsSinceWorkoutStartWhenPaused;
NSString *typeOfWorkout;
NSString *currentUnits;
float caloriesBurned;
float weight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!manager) manager = [[CLLocationManager alloc] init];
    
    
    [_pauseWorkoutButton setTitle:@"Pause Workout" forState:UIControlStateNormal];
    
    AWSVariables *obj = [[AWSVariables alloc] init];
    currentUnits = obj.units;
    typeOfWorkout = obj.typeOfWorkout;

    distanceTraveledNumber = 0;
    caloriesBurned = 0;
    
    if ([typeOfWorkout isEqualToString:@"Distance"]) {
        self.navigationItem.title = @"Distance Workout";
    }
    if ([typeOfWorkout isEqualToString:@"Time"]) {
        self.navigationItem.title = @"Time Workout";
    }
    if ([typeOfWorkout isEqualToString:@"Calorie"]) {
        self.navigationItem.title = @"Calorie Workout";
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    if ([typeOfWorkout isEqualToString:@"Distance"]) {
        if ([currentUnits isEqualToString:@"Imperial"]) {
            [_distance setText:@"0 mi"];
            [_pace setText:@"0:00/mi"];
            [_speed setText: @"0 mi/h"];
        } else {
            [_distance setText:@"0 km"];
            [_pace setText:@"0:00/km"];
            [_speed setText:@"0 mi/h"];
        }
    }
    
    if ([currentUnits isEqualToString:@"Imperial"]) {
        weight = obj.weightInPounds;
    } else {
        weight = obj.weightInKilograms;
    }
    
    
    [_calories setText:@"0 calories burned"];
    [_workoutTime setText:@"0:00"];
    
    workoutPaused = NO;
    secondsPaused = 0;
    caloriesBurned = 0;
    
    
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
    workoutStartDate = [NSDate date];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pauseWorkout:(id)sender {
    
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    
    if ([buttonName isEqualToString:@"Pause Workout"])
    {
        [manager stopUpdatingLocation];
        datePaused = [NSDate date];
        secondsSinceWorkoutStartWhenPaused = secondsSinceWorkoutStart;
        workoutPaused = YES;
        self.speed.text = @"Workout Paused";
        _speed.font = [UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:34];
        self.pace.text = @"Workout Paused";
        _pace.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:30];
        [sender setTitle:@"Resume Workout" forState:UIControlStateNormal];
        
        //displaying the time
        
        //are we talking two-digit hours here (that's a long workout...) ?
        if (secondsSinceWorkoutStartWhenPaused/36000 >= 1) {
            NSInteger ti = (NSInteger)secondsSinceWorkoutStartWhenPaused;
            NSInteger seconds = ti % 60;
            NSInteger minutes = (ti / 60) % 60;
            NSInteger hours = (ti / 3600);
            _workoutTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
        } else if (secondsSinceWorkoutStartWhenPaused/3600 >= 1) {
            NSInteger ti = (NSInteger)secondsSinceWorkoutStartWhenPaused;
            NSInteger seconds = ti % 60;
            NSInteger minutes = (ti / 60) % 60;
            NSInteger hours = (ti / 3600);
            _workoutTime.text = [NSString stringWithFormat:@"%1ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
        } else if (secondsSinceWorkoutStartWhenPaused/600 >= 1) { //are we talking two-digit minutes?
            NSInteger ti = (NSInteger)secondsSinceWorkoutStartWhenPaused;
            NSInteger seconds = ti % 60;
            NSInteger minutes = (ti / 60) % 60;
            _workoutTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
        } else if (secondsSinceWorkoutStartWhenPaused/60 >= 1) { //are we talking one-digit minutes?
            NSInteger ti = (NSInteger)secondsSinceWorkoutStartWhenPaused;
            NSInteger seconds = ti % 60;
            NSInteger minutes = (ti / 60) % 60;
            _workoutTime.text = [NSString stringWithFormat:@"%1ld:%02ld", (long)minutes, (long)seconds];
        } else if (secondsSinceWorkoutStartWhenPaused > 0) { // are we talking seconds?
            NSInteger ti = (NSInteger)secondsSinceWorkoutStartWhenPaused;
            NSInteger seconds = ti % 60;
            _workoutTime.text = [NSString stringWithFormat:@"0:%02ld", (long)seconds];
        }
        
        
    } else {
        secondsPaused = [[NSDate date] timeIntervalSinceDate:datePaused] + secondsPaused;
        [manager startUpdatingLocation];
        [sender setTitle:@"Pause Workout" forState:UIControlStateNormal];
        _pace.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
        _speed.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:34];
    }
    
}

#pragma mark CLLocationManagerDelegate Methods



-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"Old Location: %@", oldLocation);
    NSLog(@"New Location: %@", newLocation);
    
    CLLocation *currentLocation;
    CLLocation *pastLocation;
    
    secondsSinceWorkoutStart = [[NSDate date] timeIntervalSinceDate:[workoutStartDate dateByAddingTimeInterval:secondsPaused]];
    
    //are we talking two-digit hours here (that's a long workout...) ?
    if (secondsSinceWorkoutStart/36000 >= 1) {
        NSInteger ti = (NSInteger)secondsSinceWorkoutStart;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        _workoutTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (secondsSinceWorkoutStart/3600 >= 1) {
        NSInteger ti = (NSInteger)secondsSinceWorkoutStart;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        _workoutTime.text = [NSString stringWithFormat:@"%1ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (secondsSinceWorkoutStart/600 >= 1) { //are we talking two-digit minutes?
        NSInteger ti = (NSInteger)secondsSinceWorkoutStart;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        _workoutTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    } else if (secondsSinceWorkoutStart/60 >= 1) { //are we talking one-digit minutes?
        NSInteger ti = (NSInteger)secondsSinceWorkoutStart;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        _workoutTime.text = [NSString stringWithFormat:@"%1ld:%02ld", (long)minutes, (long)seconds];
    } else if (secondsSinceWorkoutStart > 0) { // are we talking seconds?
        NSInteger ti = (NSInteger)secondsSinceWorkoutStart;
        NSInteger seconds = ti % 60;
        _workoutTime.text = [NSString stringWithFormat:@"0:%02ld", (long)seconds];
    }
    

    
    if (workoutPaused == NO) {
        currentLocation = newLocation;
        pastLocation = oldLocation;
        
        if (!startingLocation)
            startingLocation = currentLocation;
        
        if (currentLocation != nil) { //location must exist to do things
            
            
            if (pastLocation != nil && [currentLocation distanceFromLocation:pastLocation] > 0) {
                
                CLLocationDistance distanceRecentlyTraveled = [currentLocation distanceFromLocation:pastLocation];
                NSString *distanceRecentlyTraveledString = [NSString stringWithFormat:@"%.8f", distanceRecentlyTraveled];
                float distanceRecentlyTraveledNumber = [distanceRecentlyTraveledString floatValue];
                float distanceRecentlyTraveledNumberUnits;
                if ([currentUnits isEqualToString:@"Imperial"]) {
                    distanceRecentlyTraveledNumberUnits = distanceRecentlyTraveledNumber * 0.000621371;
                } else {
                    distanceRecentlyTraveledNumberUnits = distanceRecentlyTraveledNumber * .001;
                }
                
                if (distanceRecentlyTraveledNumberUnits < .03) {
                    distanceTraveledNumber = distanceRecentlyTraveledNumberUnits + distanceTraveledNumber;
                    if ([currentUnits isEqualToString:@"Imperial"]) {
                        distanceTraveled = [NSString stringWithFormat:@"%.2f mi", distanceTraveledNumber];
                        caloriesBurned = 0.75 * weight * distanceTraveledNumber;
                    } else {
                        distanceTraveled = [NSString stringWithFormat:@"%.2f km", distanceTraveledNumber];
                        caloriesBurned = 0.75 * weight * distanceTraveledNumber * 2.20462 * 0.621371;
                    }
                    [_calories setText:[NSString stringWithFormat:@"%.0f calories burned",caloriesBurned]];
                    
                }
                self.distance.text = distanceTraveled;
                if (currentLocation.speed > 0) {
                    if ([currentUnits isEqualToString: @"Imperial"]) {
                        self.speed.text = [NSString stringWithFormat:@"%.1f mi/h", currentLocation.speed * 2.23693629];
                    } else {
                        self.speed.text = [NSString stringWithFormat:@"%.1f km/h", currentLocation.speed * 3.6];
                    }
                    
                } else {
                    if ([currentUnits isEqualToString:@"Imperial"]) {
                        self.speed.text = [NSString stringWithFormat:@"0 mi/h"];
                    } else {
                        self.speed.text = [NSString stringWithFormat:@"0 km/h"];
                    }
                    
                }
                
            } else if ([currentLocation distanceFromLocation:startingLocation] == 0) { // no movement
                
                if ([currentUnits isEqualToString:@"Imperial"]) {
                    self.distance.text = [NSString stringWithFormat:@"0 mi"];
                    self.speed.text = [NSString stringWithFormat:@"0 mi/h"];
                } else {
                    self.distance.text = [NSString stringWithFormat:@"0 km"];
                    self.speed.text = [NSString stringWithFormat:@"0 km/h"];
                }
                
                distanceTraveledNumber = 0.00;
                
            }
        
    } else {
        self.distance.text = distanceTraveled;
        if ([currentUnits isEqualToString:@"Imperial"]) {
            self.speed.text = [NSString stringWithFormat:@"0 mi/h"];
        } else {
            self.speed.text = [NSString stringWithFormat:@"0 km/h"];
        }
        currentLocation = newLocation;
        pastLocation = newLocation;
        workoutPaused = NO;
        
    }
    
    // pace calculations
    
    float pace;
    
    if (currentLocation.speed > 0.01) {
        if ([currentUnits isEqualToString:@"Imperial"]) {
            pace = 3600 / (currentLocation.speed * 2.23693629); // seconds/hour / mi/h
            NSLog(@"pace: %.0f", pace);
            if (pace/36000 >= 1) {
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                NSInteger hours = (ti / 3600);
                _pace.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld/mi", (long)hours, (long)minutes, (long)seconds];
            } else if (pace/3600 >= 1) {
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                NSInteger hours = (ti / 3600);
                _pace.text = [NSString stringWithFormat:@"%1ld:%02ld:%02ld/mi", (long)hours, (long)minutes, (long)seconds];
            } else if (pace/600 >= 1) { //are we talking two-digit minutes?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                _pace.text = [NSString stringWithFormat:@"%02ld:%02ld/mi", (long)minutes, (long)seconds];
            } else if (pace/60 >= 1) { //are we talking one-digit minutes?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                _pace.text = [NSString stringWithFormat:@"%1ld:%02ld/mi", (long)minutes, (long)seconds];
            } else if (pace > 0) { // are we talking seconds?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                _pace.text = [NSString stringWithFormat:@"0:%02ld/mi", (long)seconds];
            }
        } else {
            pace = 3600 / (currentLocation.speed * 3.6); // seconds/hour / km/h
            if (pace/36000 >= 1) {
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                NSInteger hours = (ti / 3600);
                _pace.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld/km", (long)hours, (long)minutes, (long)seconds];
            } else if (pace/3600 >= 1) {
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                NSInteger hours = (ti / 3600);
                _pace.text = [NSString stringWithFormat:@"%1ld:%02ld:%02ld/km", (long)hours, (long)minutes, (long)seconds];
            } else if (pace/600 >= 1) { //are we talking two-digit minutes?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                _pace.text = [NSString stringWithFormat:@"%02ld:%02ld/km", (long)minutes, (long)seconds];
            } else if (pace/60 >= 1) { //are we talking one-digit minutes?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                NSInteger minutes = (ti / 60) % 60;
                _pace.text = [NSString stringWithFormat:@"%1ld:%02ld/km", (long)minutes, (long)seconds];
            } else if (pace > 0) { // are we talking seconds?
                NSInteger ti = (NSInteger)pace;
                NSInteger seconds = ti % 60;
                _pace.text = [NSString stringWithFormat:@"0:%02ld/km", (long)seconds];
            }
        }
    } else {
        _pace.text = [NSString stringWithFormat:@"N/A"];
        if ([currentUnits isEqualToString:@"Imperial"]) {
            _speed.text = [NSString stringWithFormat:@"0 mi/h"];
        } else {
            _speed.text = [NSString stringWithFormat:@"0 km/h"];
        }
    }
    
    }
    
}

- (IBAction)endWorkout:(id)sender {
    AWSWorkouts *workoutsObj = [[AWSWorkouts alloc] init];
    float zero = [[NSNumber numberWithInt:0] floatValue];
    [workoutsObj updatePastWorkouts:typeOfWorkout :zero :distanceTraveledNumber :secondsSinceWorkoutStart :caloriesBurned :workoutStartDate :[NSDate date]];
    [manager stopUpdatingLocation];
    manager = nil;
    AWSItemStore *itemStoreObj = [[AWSItemStore alloc] init];
    [itemStoreObj workoutJustEnded];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
