//
//  AWSWeightSettingsView.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/5/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSWeightSettingsView.h"
#import "AWSVariables.h"


@implementation AWSWeightSettingsView

NSString *currentUnits;
NSString *KgComponentZero;
NSString *KgComponentOne;


@synthesize promptLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
            }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger numberOfComponents;
    /* if we are using imperial units, we want one component (pounds)
     if we are using metric units, we want two components (kg and .5 kg) */
    AWSVariables *obj = [[AWSVariables alloc] init];
    currentUnits = obj.units;
    NSLog(@"%@", currentUnits);
    if ([currentUnits isEqualToString:@"Metric"]) {
        [promptLabel setText:@"Enter your weight in kilograms"];
    } else {
        [promptLabel setText:@"Enter your weight in pounds"];
    }
    if ([currentUnits isEqualToString:@"Metric"]) {
        numberOfComponents = 2;
    } else {
        numberOfComponents = 1;
    }
    return numberOfComponents;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows;
    if (component == 0) {
    if ([currentUnits isEqualToString:@"Imperial"]) {
        numberOfRows = 500; //500 pounds seems like a safe maximum
    } else {
        numberOfRows = 250; //so does 250 kg
    }
    } else {
        numberOfRows = 2; //this will only happen for the second column of kg
        // which we want to be just .0 and .5
    }
    return numberOfRows;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *titleForRow;
    if (component == 0) {
        NSInteger number = row + 1;
        titleForRow = [NSString stringWithFormat:@"%ld", number];
    } else  if (row == 0) {
        titleForRow = [NSString stringWithFormat:@".0"];
    } else {
        titleForRow = [NSString stringWithFormat:@".5"];
    }
    return titleForRow;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSString *weightString;
    NSLog(@"Selected Row %ld", row);
    if ([currentUnits isEqualToString:@"Metric"]) {
        if (component == 0) {
            KgComponentZero = [[NSNumber numberWithLong:row + 1] stringValue];
        } else { //component = 1
            if (row == 0) {
                KgComponentOne = @".0";
            } else { //row = 1
                KgComponentOne = @".5";
            }
        }
        weightString = [KgComponentZero stringByAppendingString:KgComponentOne];
        obj.weightInKilograms = [weightString floatValue];
        obj.weightInPounds = [weightString floatValue]*2.20462;
    } else { //units are imperial
        weightString = [[NSNumber numberWithLong:row + 1] stringValue];
        obj.weightInPounds = [weightString floatValue];
        obj.weightInKilograms = [weightString floatValue]*0.453592;
    }
    NSLog(@"Selected weight is: %@", weightString);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
