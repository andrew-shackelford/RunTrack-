//
//  AWSNewTimeWorkoutViewController.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/10/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWSNewTimeWorkoutViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate> {
    
}
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@end
