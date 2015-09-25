//
//  Task.m
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "Task.h"
#import "TaskCategory.h"

@implementation Task

// Insert code here to add functionality to your managed object subclass

+ (Task *)taskWithName:(NSString *)name
              deadline:(NSDate *)deadline
              category:(TaskCategory*)category
inManagedObjectContext:(NSManagedObjectContext *)context
{
    Task *newTask = [NSEntityDescription insertNewObjectForEntityForName:COREDATA_ENTITYNAME_TASK inManagedObjectContext:context];
    
    newTask.name = name;
    newTask.deadline = deadline;
    newTask.isFinished = [NSNumber numberWithBool:NO];
    newTask.category = category;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return newTask;
}

@end
