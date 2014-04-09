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
BOOL awakeFromNibHasAlreadyRun = NO;

@synthesize weightLabel;

- (void)awakeFromNib
{
     NSLog(@"Hi again!");
     AWSVariables *obj = [[AWSVariables alloc] init];
     NSString *weightLabelText;
     float weightLabelNumber;
     if ([obj.units isEqualToString:@"Metric"]) {
         weightLabelNumber = obj.weightInKilograms;
         weightLabelText = [[NSString stringWithFormat:@"%.1f", weightLabelNumber] stringByAppendingString:@" kg"];
     } else {
         weightLabelNumber = obj.weightInPounds;
         weightLabelText = [[NSString stringWithFormat:@"%.0f", weightLabelNumber] stringByAppendingString:@" lbs"];
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

@end
