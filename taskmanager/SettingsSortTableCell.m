//
//  SettingsSortTableCell.m
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "SettingsSortTableCell.h"
#import "MasterViewController.h"

@implementation SettingsSortTableCell

- (void)awakeFromNib {
    // Initialization code
    
    // Init value of sorting switch (segmented control)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [defaults stringForKey:USERDEFAULTS_TASKLIST_SORT_KEY];
    if ([key isEqualToString:@"deadline"]) {
        [self.sortingSwitch setSelectedSegmentIndex:0];
    } else if ([key isEqualToString:@"name"]) {
        [self.sortingSwitch setSelectedSegmentIndex:1];
    }
}

- (IBAction)sortingSwitchValueChanged:(UISegmentedControl *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (sender.selectedSegmentIndex) {
        case 0:
            [defaults setValue:@"deadline" forKey:USERDEFAULTS_TASKLIST_SORT_KEY];
            break;
        case 1:
            [defaults setValue:@"name" forKey:USERDEFAULTS_TASKLIST_SORT_KEY];
            break;
        default:
            break;
    }
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateSortingNotification" object:nil];
}

@end
