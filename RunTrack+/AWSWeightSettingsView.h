//
//  AWSWeightSettingsView.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/5/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWSWeightSettingsView : UIView <UIPickerViewDataSource,UIPickerViewDelegate> {
    UILabel *promptLabel;
}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

@end
