//
//  TaskTableCell.m
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "TaskTableCell.h"

@implementation TaskTableCell

- (void)awakeFromNib {
    // Initialization here
    
    [self updateFinishedCheckbox];
}

- (void)updateFinishedCheckbox {
    if ([self.task.isFinished boolValue]) {
        [self.finishedCheckbox setTitle:@"☑️" forState:UIControlStateNormal];
    } else {
        [self.finishedCheckbox setTitle:@"⃞" forState:UIControlStateNormal];
    }
}

- (IBAction)finishedCheckboxPressed:(UIButton *)sender {
    // inverse
    self.task.isFinished = [NSNumber numberWithBool:![self.task.isFinished boolValue]];
    
    [self updateFinishedCheckbox];
}

@end
