//
//  SettingsNotificationsTableCell.m
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "SettingsNotificationsTableCell.h"

@implementation SettingsNotificationsTableCell

- (void)awakeFromNib {
    // Initialization code
    
    // Init switch to proper state
    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    if ([arrayOfLocalNotifications count] == 0) {
        [self.deactivateNotificationsSwitch setOn:NO];
        [self.deactivateNotificationsSwitch setEnabled:NO];
    } else {
        [self.deactivateNotificationsSwitch setOn:YES];
        [self.deactivateNotificationsSwitch setEnabled:YES];
    }
}

- (IBAction)deactivateNotificationSwitchValueChanged:(UISwitch *)sender {
    if (!sender.isOn) { // Switched from on to off
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self.deactivateNotificationsSwitch setEnabled:NO];
    }
}

@end
