//
//  AWSWorkouts.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/16/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWSWorkouts : NSObject

@property (readwrite, nonatomic) NSMutableArray *workouts;

-(void) updatePastWorkouts:(NSString *)workoutType :(float)goal :(float)distance :(float)time :(float)calories :(NSDate *)startDate :(NSDate *)endDate;
-(void) deleteWorkout:(int)workoutNumber;

@end
