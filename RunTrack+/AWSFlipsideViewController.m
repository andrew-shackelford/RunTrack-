//
//  AWSFlipsideViewController.m
//  RunTrack+
//
//  Created by Andrew Shackelford on 3/31/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import "AWSFlipsideViewController.h"

@interface AWSFlipsideViewController ()


@end

@implementation AWSFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
