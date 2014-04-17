//
//  AWSItemStore.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/16/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWSItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (void)workoutJustEnded;

@end
