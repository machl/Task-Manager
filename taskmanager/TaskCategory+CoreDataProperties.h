//
//  TaskCategory+CoreDataProperties.h
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TaskCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSData *color;
@property (nullable, nonatomic, retain) NSSet<Task *> *tasks;

@end

@interface TaskCategory (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet<Task *> *)values;
- (void)removeTasks:(NSSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
