//
//  AWSWorkoutTableViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/16/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSWorkoutTableViewController.h"
#import "AWSItemStore.h"
#import "AWSVariables.h"

@implementation AWSWorkoutTableViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AWSItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    
    NSArray *items = [[AWSItemStore sharedStore] allItems];
    NSDictionary *item = items[indexPath.row];
    
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSString *currentUnits = obj.units;
    NSString *distanceLabel;
    if ([currentUnits isEqualToString:@"Metric"]) {
        distanceLabel = [NSString stringWithFormat:@"%.2f km", [[item objectForKey:@"Distance"] floatValue] * 1.60934];
    } else {
        distanceLabel = [NSString stringWithFormat:@"%.2f mi", [[item objectForKey:@"Distance"] floatValue]];
    }
    float timeSeconds = [[item objectForKey:@"Time"] floatValue];
    NSString *timeLabel;
    if (timeSeconds/36000 >= 1) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/3600 >= 1) {
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        NSInteger hours = (ti / 3600);
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else if (timeSeconds/600 >= 1) { //are we talking two-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds/60 >= 1) { //are we talking one-digit minutes?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        NSInteger minutes = (ti / 60) % 60;
        timeLabel = [NSString stringWithFormat:@"%1ld:%02ld", (long)minutes, (long)seconds];
    } else if (timeSeconds > 0) { // are we talking seconds?
        NSInteger ti = (NSInteger)timeSeconds;
        NSInteger seconds = ti % 60;
        timeLabel = [NSString stringWithFormat:@"0:%02ld", (long)seconds];
    }
    cell.textLabel.text = distanceLabel;
    cell.detailTextLabel.text = timeLabel;
    
    return cell;
}

@end
