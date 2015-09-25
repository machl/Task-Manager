//
//  MasterViewController.h
//  taskmanager
//
//  Created by Lukas Machalik on 22.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

#define USERDEFAULTS_TASKLIST_SORT_KEY @"SortTaskListByColumn"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

