//
//  AWSNewCalorieWorkoutViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/10/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSNewCalorieWorkoutViewController.h"
#import "AWSVariables.h"

@interface AWSNewCalorieWorkoutViewController ()

@end

@implementation AWSNewCalorieWorkoutViewController

NSString *currentUnits;
float caloriesGoal;

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
    
    [obj updateWorkout:@"Calorie"];
    caloriesGoal = 25;
    [obj updateGoal:caloriesGoal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 160;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", (row + 1)*25];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AWSVariables *obj = [[AWSVariables alloc] init];
    [obj updateGoal:[[NSString stringWithFormat:@"%d", (row + 1)*25] floatValue]];
}

@end
