//
//  TaskCategory.m
//  taskmanager
//
//  Created by Lukas Machalik on 24.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "TaskCategory.h"
#import "Task.h"

@implementation TaskCategory

// Insert code here to add functionality to your managed object subclass

+ (TaskCategory *)taskCategoryWithName:(NSString *)name
                                 color:(UIColor *)color
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    TaskCategory *newTaskCategory = [NSEntityDescription insertNewObjectForEntityForName:COREDATA_ENTITYNAME_TASKCATEGORY inManagedObjectContext:context];
    
    newTaskCategory.name = name;
    newTaskCategory.color = [NSKeyedArchiver archivedDataWithRootObject:color];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return newTaskCategory;
}

- (UIColor *)colorAsUIColor
{
    return (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:self.color];
}

@end
