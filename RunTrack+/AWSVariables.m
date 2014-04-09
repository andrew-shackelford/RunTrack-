//
//  AWSVariables.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/4/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSVariables.h"

@implementation AWSVariables

@synthesize units;
@synthesize weightInPounds;
@synthesize weightInKilograms;
@synthesize settings;



- (id) init
{
    self = [super init];
    if ( self )
    {
        NSString *settingsFile = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        settings = [[NSDictionary alloc] initWithContentsOfFile:settingsFile];
        units = [settings objectForKey:@"Units"];
        if ([units isEqualToString:@"Imperial"]) {
            weightInPounds = [[settings objectForKey:@"Weight"] floatValue];
            weightInKilograms = weightInPounds*0.453592;
        } else {
            weightInKilograms = [[settings objectForKey:@"Weight"] floatValue];
            weightInPounds = weightInKilograms*2.20462;
        }
    }
    
    return self;
}

- (void) updateWeight:(float)weight {
    NSString *settingsFile = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
    units = [settings objectForKey:@"Units"];
    if ([units isEqualToString:@"Imperial"]) {
        weightInPounds = weight;
        weightInKilograms = weightInPounds*0.453592;
        [settings setValue:[NSNumber numberWithFloat:weight] forKey:@"Weight"];
    } else {
        weightInKilograms = weight;
        weightInPounds = weightInKilograms*2.20462;
        [settings setValue:[NSNumber numberWithFloat:weight] forKey:@"Weight"];
    }
    [settings writeToFile:settingsFile atomically:YES];
}

- (void) updateUnits:(NSString *)newUnits {
    NSString *settingsFile = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFile];
    NSNumber *oldWeight = [settings objectForKey:@"Weight"];
    NSNumber *newWeight;
    if ([newUnits isEqualToString:@"Imperial"]) {
        newWeight = [NSNumber numberWithFloat:[oldWeight floatValue] * 2.20462];
    } else {
        newWeight = [NSNumber numberWithFloat:[oldWeight floatValue] * 0.453592];
    }
    [settings setValue:newWeight forKey:@"Weight"];
    [settings setValue:newUnits forKey:@"Units"];
    [settings writeToFile:settingsFile atomically:YES];
}




@end
