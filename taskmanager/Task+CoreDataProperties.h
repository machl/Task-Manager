//
//  Task+CoreDataProperties.h
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *deadline;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *isFinished;
@property (nullable, nonatomic, retain) TaskCategory *category;

@end

NS_ASSUME_NONNULL_END
