//
//  AWSFreeWorkoutViewController.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/11/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWSFreeWorkoutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *workoutTime;
@property (weak, nonatomic) IBOutlet UILabel *pace;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UIButton *pauseWorkoutButton;
- (IBAction)pauseWorkout:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *distance;
@end
