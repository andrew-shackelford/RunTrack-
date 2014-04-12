//
//  AWSDetermingLocationViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/11/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSDetermingLocationViewController.h"
#import "AWSVariables.h"
#import <CoreLocation/CoreLocation.h>

@interface AWSDetermingLocationViewController ()

@end

@implementation AWSDetermingLocationViewController

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
    
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSString *typeOfWorkout = obj.typeOfWorkout;
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Workout", typeOfWorkout];
    self.navigationItem.hidesBackButton = YES;
    
    CLLocationManager *manager;
    if (!manager) manager = [[CLLocationManager alloc] init];
    [manager startUpdatingLocation];
    
    if ([typeOfWorkout isEqualToString:@"Free"]) {
        [self performSelector:@selector(performSegueWithIdentifier:sender:) withObject:@"Free Workout" afterDelay:10];
    } else {
        [self performSelector:@selector(performSegueWithIdentifier:sender:) withObject:@"Workout" afterDelay:10];
    }
    
    [manager performSelector:@selector(stopUpdatingLocation) withObject:NULL afterDelay:11];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
