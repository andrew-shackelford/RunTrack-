//
//  AWSFlipsideViewController.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 3/31/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AWSFlipsideViewController;

@protocol AWSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(AWSFlipsideViewController *)controller;
@end

@interface AWSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <AWSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
