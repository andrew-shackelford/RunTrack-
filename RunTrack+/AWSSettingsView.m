//
//  AWSSettingsView.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/5/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSSettingsView.h"
#import "AWSVariables.h"

@implementation AWSSettingsView

NSString *weightLabelText;
float weightLabelNumber;
int segmentedControlSelected;
BOOL unitsJustChanged = NO;

@synthesize weightLabel;

- (void)awakeFromNib
{
    if (unitsJustChanged == YES) {
    if (segmentedControlSelected == 0) {
        AWSVariables *obj1 = [[AWSVariables alloc] init];
        [obj1 updateUnits:@"Imperial"];
    }
    if (segmentedControlSelected == 1) {
        AWSVariables *obj2 = [[AWSVariables alloc] init];
        [obj2 updateUnits:@"Metric"];
        NSLog(@"sup");
    }
    } else {
        AWSVariables *obj3 = [[AWSVariables alloc] init];
        NSString *currentUnits = obj3.units;
        if ([currentUnits isEqualToString:@"Imperial"]) {
            _segmentedControl.selectedSegmentIndex = 0;
        } else {
            _segmentedControl.selectedSegmentIndex = 1;
        }
    }
    unitsJustChanged = NO;
    NSLog(@"Hi again!");
     AWSVariables *obj = [[AWSVariables alloc] init];
     NSString *weightLabelText;
     float weightLabelNumber;
     if ([obj.units isEqualToString:@"Metric"]) {
         weightLabelNumber = obj.weightInKilograms;
         weightLabelText = [[NSString stringWithFormat:@"%.1f", weightLabelNumber] stringByAppendingString:@" kg"];
         NSLog(@"sup2");
     } else {
         weightLabelNumber = obj.weightInPounds;
         weightLabelText = [[NSString stringWithFormat:@"%.0f", weightLabelNumber] stringByAppendingString:@" lbs"];
         NSLog(@"sup3");
     }
     NSLog(@"Weight string is '%@'.", weightLabelText);
     [weightLabel setText:weightLabelText];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (IBAction)segmentedControlIndexChanged:(id)sender {
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            segmentedControlSelected = 0;
            break;
        case 1:
            segmentedControlSelected = 1;
            break;
    }
    unitsJustChanged = YES;
    NSLog(@"Units just changed!");
    [self awakeFromNib];
}
@end
