//
//  CategoryDetailViewController.h
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCategory.h"

@interface CategoryDetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) TaskCategory* detailItem;

@end
