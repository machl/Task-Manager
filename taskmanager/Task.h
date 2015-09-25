//
//  Task.h
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define COREDATA_ENTITYNAME_TASK @"Task"

@class TaskCategory;

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Task *)taskWithName:(NSString *)name
              deadline:(NSDate *)deadline
              category:(TaskCategory*)category
inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"
