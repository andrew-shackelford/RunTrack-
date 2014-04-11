//
//  AWSNewTimeWorkoutViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/10/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSNewTimeWorkoutViewController.h"
#import "AWSVariables.h"

@interface AWSNewTimeWorkoutViewController ()

@end

@implementation AWSNewTimeWorkoutViewController

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
    [obj updateWorkout:@"Time"];
    self.navigationItem.prompt = @"Choose your time goal";
    [_picker selectRow:[[NSNumber numberWithInt:1] integerValue] inComponent:[[NSNumber numberWithInt:0]integerValue] animated:YES];
    [_picker selectRow:[[NSNumber numberWithInt:0] integerValue] inComponent:[[NSNumber numberWithInt:1]integerValue] animated:YES];
    componentOne = 1;
    componentTwo = 0;
    [obj updateGoal:60.015]; // have to add .015 for it to display correctly
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
            numberOfRows = 11; // hours (10) (zero is an option)
    } else {
        numberOfRows = 60; // minutes (60)
    }
    return numberOfRows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *titleForRow;
    if (component == 0) {
        NSInteger number = row;
        titleForRow = [NSString stringWithFormat:@"%ld hr", (long)number];
    } else {
        titleForRow = [NSString stringWithFormat:@"%ld min", (long)row];
    }
    return titleForRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //storing workoutGoal in minutes
    AWSVariables *obj = [[AWSVariables alloc] init];
    if (row == 0 && component == 0 && componentTwo == 0) {
        [_picker selectRow:1 inComponent:0 animated:YES];
        [obj updateGoal:60];
        NSLog(@"workoutGoal is 60");
    } else if (row == 0 && component == 1 && componentOne == 0) {
        [_picker selectRow:1 inComponent:1 animated:YES];
        [obj updateGoal:0.1];
        NSLog(@"workoutGoal is 1");
    } else {
        if (component == 0) {
            componentOne = row;
        } else {
            componentTwo = row;
        }
        NSString *workoutGoalString = [NSString stringWithFormat:@"%.0f min", componentOne * 60 + componentTwo];
        NSLog(@"workoutGoalString is %@", workoutGoalString);
        float workoutGoal = componentOne * 60 + componentTwo + .015; // have to add .015 for it to display correctly
        [obj updateGoal:workoutGoal];
    }
    
}


@end
