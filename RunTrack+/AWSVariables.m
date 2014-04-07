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



- (id) init
{
    self = [super init];
    if ( self )
    {
        //put if clause to see if settings plist already exists
        self.units = @"Metric";  //for now
    }
    
    return self;
}



@end
