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
#import "AWSItemCell.h"

@implementation AWSWorkoutTableViewController

@synthesize cellTapped;

-(void)viewDidLoad
{
    AWSVariables *obj = [[AWSVariables alloc] init];
    NSLog(@"%@", obj.units);
    
    BOOL appOpened = obj.appHasBeenOpened;
    if (!appOpened) {
        UIAlertView *settingsAlert = [[UIAlertView alloc] initWithTitle:@"Settings" message:[NSString stringWithFormat:@"Go to settings to set your weight and preferred units"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Settings", nil];
        [settingsAlert show];
        appOpened = YES;
        [obj updateAppOpened:YES];
        NSLog(@"app has not been opened");
    } else {
        NSLog(@"app has been opened");
    }
    
    UINib *nib = [UINib nibWithNibName:@"AWSItemCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AWSItemCell"];
    
}

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

- (void) reloadTableViewData
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AWSItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AWSItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AWSItemCell" forIndexPath:indexPath];
    
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"M/d/yy"];
    NSString *startDateLabel = [formatter stringFromDate:[item objectForKey:@"Start Date"]];
    cell.distance.text = distanceLabel;
    cell.time.text = timeLabel;
    cell.date.text = startDateLabel;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AWSVariables *obj2 = [[AWSVariables alloc] init];
    int row = [[NSNumber numberWithInteger:indexPath.row] intValue];
    [obj2 updateCellTapped:row];
    [self performSegueWithIdentifier:@"Accessory" sender:self];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"Settings" sender:self];
    }
}


@end
