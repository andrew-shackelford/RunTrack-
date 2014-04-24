//
//  AWSItemCell.h
//  RunTrack+
//
//  Created by Andrew Shackelford on 4/23/14.
//  Copyright (c) 2014 Andrew Shackelford Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWSItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
