//
//  AWSVariables.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/4/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWSVariables : NSObject

@property (readwrite, nonatomic) NSString *units;
@property (readwrite, nonatomic) float weightInPounds;
@property (readwrite, nonatomic) float weightInKilograms;
@property (nonatomic, strong) NSDictionary *settings;
@property (readwrite, nonatomic) float workoutGoal;
@property (readwrite, nonatomic) NSString *typeOfWorkout;
@property (readwrite, nonatomic) int cellTapped;
@property (readwrite, nonatomic) BOOL appHasBeenOpened;

-(void) updateWeight:(float)weight;
-(void) updateUnits:(NSString *)newUnits;
-(void) updateWorkout:(NSString *)workout;
-(void) updateGoal:(float)goal;
-(void) updateCellTapped:(int)cellNumber;
-(void) updateAppOpened:(BOOL)isAppOpened;

@end
