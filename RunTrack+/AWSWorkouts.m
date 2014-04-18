//
//  AWSWorkouts.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/16/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSWorkouts.h"
#import "AWSVariables.h"
#import "AWSWorkoutTableViewController.h"

@implementation AWSWorkouts

@synthesize workouts;

- (id) init
{
    self = [super init];
    if ( self )
    {
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"Workouts.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:destPath]) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Workouts" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
        }
        
        // Load the Property List.
        
        workouts = [[NSMutableArray alloc] initWithContentsOfFile:destPath];
        
    }
    
    return self;
}

-(void) updatePastWorkouts:(NSString *)workoutType :(float)goal :(float)distance :(float)time :(float)calories :(NSDate *)startDate :(NSDate *)endDate
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"Workouts.plist"];
    workouts = [[NSMutableArray alloc] initWithContentsOfFile:destPath];
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSString *currentUnits = obj.units;
    //store everything in imperial units
    NSString *goalString;
    NSString *distanceString;
    if ([currentUnits isEqualToString:@"Imperial"]) {
        if ([workoutType isEqualToString:@"Free"] == NO) {
            goalString = [NSString stringWithFormat:@"%.1f", goal];
        }
        distanceString = [NSString stringWithFormat:@"%.2f", distance];
    } else {
        if ([currentUnits isEqualToString:@"Distance"]) {
            if ([workoutType isEqualToString:@"Free"] == NO) {
                goalString = [NSString stringWithFormat:@"%.1f", goal*0.621371];
            }
        } else {
            if ([workoutType isEqualToString:@"Free"] == NO) {
                goalString = [NSString stringWithFormat:@"%.1f", goal];
            }
        }
        distanceString = [NSString stringWithFormat:@"%.2f", distance*0.621371];
    }
    if ([workoutType isEqualToString:@"Time"]) {
        goalString = [NSString stringWithFormat:@"%.0f", goal];
    }
    if ([workoutType isEqualToString:@"Free"]) {
        goalString = @"None";
    }
    NSString *workoutTypeString = [NSString stringWithFormat:@"%@", workoutType];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time - 0.9];
    NSString *caloriesString = [NSString stringWithFormat:@"%.0f", calories];
    NSArray *workoutObjects = [NSArray arrayWithObjects:workoutTypeString, goalString, distanceString, timeString, caloriesString, startDate, endDate, nil];
    NSArray *workoutKeys = [NSArray arrayWithObjects:@"Type of Workout", @"Goal", @"Distance", @"Time", @"Calories", @"Start Date", @"End Date", nil];
    NSDictionary *workoutDictionary = [NSDictionary dictionaryWithObjects: workoutObjects forKeys:workoutKeys];
    for (id key in workoutDictionary) {
        NSLog(@"Key:%@, Object: %@", key, [workoutDictionary objectForKey:key]);
    }
    [workouts insertObject:workoutDictionary atIndex:0];
    [workouts writeToFile:destPath atomically:YES];
}

-(void) deleteWorkout:(int)workoutNumber
{
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"Workouts.plist"];
    workouts = [[NSMutableArray alloc] initWithContentsOfFile:destPath];
    [workouts removeObjectAtIndex:[[NSNumber numberWithInt:workoutNumber] integerValue]];
    [workouts writeToFile:destPath atomically:YES];
    AWSWorkoutTableViewController *workoutTableViewObj = [[AWSWorkoutTableViewController alloc] init];
    [workoutTableViewObj reloadTableViewData];
}

@end
