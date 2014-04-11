//
//  AWSNewDistanceWorkoutViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/10/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSNewDistanceWorkoutViewController.h"
#import "AWSVariables.h"

@interface AWSNewDistanceWorkoutViewController ()

@end

@implementation AWSNewDistanceWorkoutViewController

NSString *currentUnits;
float componentOne;
float componentTwo;

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
    
    
    AWSVariables *obj = [[AWSVariables alloc] init];
    currentUnits = obj.units;
    [obj updateWorkout:@"Distance"];
    if ([currentUnits isEqualToString: @"Imperial"]) {
        self.navigationItem.prompt = @"Choose your distance goal in miles";
    } else {
    self.navigationItem.prompt = @"Choose your distance goal in kilometers";
    }
    [_picker selectRow:[[NSNumber numberWithInt:1] integerValue] inComponent:[[NSNumber numberWithInt:0]integerValue] animated:YES];
    [_picker selectRow:[[NSNumber numberWithInt:0] integerValue] inComponent:[[NSNumber numberWithInt:1]integerValue] animated:YES];
    componentOne = 1;
    componentTwo = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows;
    if (component == 0) {
        if ([currentUnits isEqualToString:@"Imperial"]) {
            numberOfRows = 50; //Imperial first component
        } else {
            numberOfRows = 80; //Metric first component
        }
    } else {
        numberOfRows = 10; //Imperial and Metric second component
        }
    return numberOfRows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *titleForRow;
    if (component == 0) {
        NSInteger number = row;
        titleForRow = [NSString stringWithFormat:@"%ld", (long)number];
    } else {
        NSString *secondPartOfNumber = [NSString stringWithFormat:@"%ld", (long)row];
        titleForRow = [[NSString stringWithFormat:@"."] stringByAppendingString:secondPartOfNumber];
    }
    return titleForRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AWSVariables *obj = [[AWSVariables alloc] init];
    if (row == 0 && component == 0 && componentTwo == 0) {
        [_picker selectRow:1 inComponent:0 animated:YES];
        [obj updateGoal:1];
        NSLog(@"workoutGoal is 1.0");
    } else if (row == 0 && component == 1 && componentOne == 0) {
        [_picker selectRow:1 inComponent:1 animated:YES];
        [obj updateGoal:0.1];
        NSLog(@"workoutGoal is 0.1");
    } else {
        if (component == 0) {
            componentOne = row;
        } else {
            componentTwo = row;
        }
        NSString *workoutGoalString = [NSString stringWithFormat:@"%.0f.%.0f", componentOne, componentTwo];
        NSLog(@"workoutGoalString is %@", workoutGoalString);
        float workoutGoal = [workoutGoalString floatValue];
        [obj updateGoal:workoutGoal];
    }
    
}

@end
