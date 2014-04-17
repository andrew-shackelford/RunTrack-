//
//  AWSMainViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 3/31/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSMainViewController.h"
#import "AWSVariables.h"
#import "AWSWorkouts.h"

@interface AWSMainViewController ()

@end

@implementation AWSMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSLog(@"%@", obj.units);
    
    AWSWorkouts *workoutsObj = [[AWSWorkouts alloc] init];
    NSArray *workouts = workoutsObj.workouts;
    NSLog(@"Count is %ld", (long)[workouts count]);
    NSLog(@"%@", workouts);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(AWSFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
