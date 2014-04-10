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
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"Settings.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:destPath]) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
        }
        
        // Load the Property List.
        settings = [[NSMutableDictionary alloc] initWithContentsOfFile:destPath];

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
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"Settings.plist"];
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:destPath];

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
    [settings writeToFile:destPath atomically:YES];
}

- (void) updateUnits:(NSString *)newUnits {
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"Settings.plist"];
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:destPath];
    NSNumber *oldWeight = [settings objectForKey:@"Weight"];
    NSNumber *newWeight;
    float finalWeight;
    NSNumber *finalFinalWeight;
    int newWeightInt;
    BOOL greaterThanPoint5 = NO;
    if ([newUnits isEqualToString:@"Imperial"]) {
        newWeight = [NSNumber numberWithFloat:[oldWeight floatValue] * 2.20462];
        if (fmodf([newWeight floatValue], 1) > .5) {
            greaterThanPoint5 = YES;
        }
        if (greaterThanPoint5 == YES) {
            newWeightInt = [newWeight intValue];
            finalWeight = (float)newWeightInt + 1;
        } else {
            finalWeight = (float)[newWeight intValue];
        }
    } else {
        newWeight = [NSNumber numberWithFloat:[oldWeight floatValue] * 0.453592];
        if (fmodf([newWeight floatValue], 1) > .5) {
            greaterThanPoint5 = YES;
        }
        if (greaterThanPoint5 == YES) {
            newWeightInt = [newWeight intValue];
            finalWeight = (float)newWeightInt + .5;
        } else {
            finalWeight = (float)[newWeight intValue];
        }
    }
    finalFinalWeight = [NSNumber numberWithFloat:finalWeight];
    [settings setValue:finalFinalWeight forKey:@"Weight"];
    [settings setValue:newUnits forKey:@"Units"];
    [settings writeToFile:destPath atomically:YES];
}



@end
