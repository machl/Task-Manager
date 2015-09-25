//
//  SettingsTableViewController.h
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
