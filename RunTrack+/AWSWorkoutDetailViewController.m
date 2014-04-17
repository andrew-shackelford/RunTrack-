//
//  AWSWorkoutDetailViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/17/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSWorkoutDetailViewController.h"
#import "AWSWorkoutTableViewController.h"
#import "AWSVariables.h"
#import "AWSWorkouts.h"
#import "AWSItemStore.h"

@interface AWSWorkoutDetailViewController ()

@end

@implementation AWSWorkoutDetailViewController

int cellTapped;

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
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:.898039216 green:.321568627 blue:.054901961 alpha:1];
    self.navigationItem.title = @"Workout Details";
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSString *currentUnits = obj.units;
    int rowSelected = obj.cellTapped;
    NSArray *items = [[AWSItemStore sharedStore] allItems];
    NSDictionary *item = items[rowSelected];
    NSString *distanceLabel;
    if ([currentUnits isEqualToString:@"Metric"]) {
        distanceLabel = [NSString stringWithFormat:@"%.2f km", [[item objectForKey:@"Distance"] floatValue]];
    } else {
        distanceLabel = [NSString stringWithFormat:@"%.2f mi", [[item objectForKey:@"Distance"] floatValue]];
    }
    float timeSeconds = [[item objectForKey:@"Time"] floatValue];
    NSString *timeLabel;
    if (timeSeconds/36000 >= 1) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/3600 >= 1) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/600 >= 1) { //are we talking two-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds/60 >= 1) { //are we talking one-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds > 0) { // are we talking seconds?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        timeLabel = [NSString stringWithFormat:@"0:%02ld", (long)seconds];
    }
    NSString *caloriesLabel = [NSString stringWithFormat:@"%d calories burned", [[item objectForKey:@"Calories"] intValue]];
    _distance.text = distanceLabel;
    _time.text = timeLabel;
    _calories.text = caloriesLabel;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"M/d/yy hh:mm:ss a"];
    NSString *startTimeLabel = [formatter stringFromDate:[item objectForKey:@"Start Date"]];
    NSString *endTimeLabel = [formatter stringFromDate:[item objectForKey:@"End Date"]];
    _startTime.text = startTimeLabel;
    _endTime.text = endTimeLabel;
    NSLog(@"%@", startTimeLabel);
    NSLog(@"%@", endTimeLabel);
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
