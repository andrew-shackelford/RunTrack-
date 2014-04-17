//
//  AWSItemStore.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/16/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSItemStore.h"
#import "AWSWorkouts.h"

@interface AWSItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation AWSItemStore

BOOL newWorkoutCreated = NO;

+ (instancetype)sharedStore
{
    static AWSItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    if (newWorkoutCreated) {
        sharedStore = nil;
        sharedStore = [[self alloc] initPrivate];
        newWorkoutCreated = NO;
    }
    
    return sharedStore;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"Workouts.plist"];
        _privateItems = [[NSMutableArray alloc] initWithContentsOfFile:destPath];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (id)init {
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

- (void)workoutJustEnded
{
    newWorkoutCreated = YES;
}

@end
