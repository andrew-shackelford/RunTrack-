//
//  AWSWorkoutViewController.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/10/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWSWorkoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *distance;
- (IBAction)pauseWorkout:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pauseWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *workoutTime;
@property (strong, nonatomic) IBOutlet UILabel *pace;
@property (strong, nonatomic) IBOutlet UILabel *calories;
@property (strong, nonatomic) IBOutlet UILabel *stuffToGoal;

@end
