//
//  TaskCategory.h
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

#define COREDATA_ENTITYNAME_TASKCATEGORY @"TaskCategory"

@class Task;

NS_ASSUME_NONNULL_BEGIN

@interface TaskCategory : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (TaskCategory *)taskCategoryWithName:(NSString *)name
                                 color:(UIColor *)color
                inManagedObjectContext:(NSManagedObjectContext *)context;

- (UIColor *)colorAsUIColor;

@end

NS_ASSUME_NONNULL_END

#import "TaskCategory+CoreDataProperties.h"
