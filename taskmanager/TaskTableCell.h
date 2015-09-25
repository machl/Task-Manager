//
//  TaskTableCell.h
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UIButton *finishedCheckbox;
@property (strong, nonatomic) Task *task;

- (void)updateFinishedCheckbox;

@end
