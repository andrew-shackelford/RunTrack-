//
//  AWSWorkoutDetailViewController.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/17/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWSWorkoutDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@end
