//
//  DetailViewController.m
//  taskmanager
//
//  Created by Lukas Machalik on 22.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "DetailViewController.h"
#import "TaskCategory.h"

@interface DetailViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *categories;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Task*)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.nameTextField.text = self.detailItem.name;
        [self setDeadlineTextFieldDate:self.detailItem.deadline];
        self.categoryTextField.text = self.detailItem.category.name;
        self.categoryTextField.backgroundColor = self.detailItem.category.colorAsUIColor;
        
        // Notification switch
        [self.notificationSwitch setOn:NO];
        NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
        for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
            if ([localNotification.alertBody isEqualToString:self.detailItem.name]) {
                [self.notificationSwitch setOn:YES];
                break;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


#pragma mark - Task name

- (IBAction)nameTextFieldEditingDidEnd:(UITextField *)sender {
    self.detailItem.name = self.nameTextField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMasterNotification" object:nil];
}


#pragma mark - Task deadline

- (IBAction)deadlineTextFieldDidBeginEditing:(UITextField *)sender {
    // Create a date picker for the date field.
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker setDate:self.detailItem.deadline];
    [datePicker addTarget:self action:@selector(updateDeadlineField) forControlEvents:UIControlEventValueChanged];
    
    // If the date field has focus, display a date picker instead of keyboard.
    // Set the text to the date currently displayed by the picker.
    self.deadlineTextField.inputView = datePicker;
    [self setDeadlineTextFieldDate:datePicker.date];
}

- (void)updateDeadlineField {
    UIDatePicker *picker = (UIDatePicker *)self.deadlineTextField.inputView;
    [self setDeadlineTextFieldDate:picker.date];
    self.detailItem.deadline = picker.date;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMasterNotification" object:nil];
}

- (void)setDeadlineTextFieldDate:(NSDate *)date {
    static NSDateFormatter *dateFormat = nil;
    if (nil == dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterLongStyle];
        [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    }
    
    self.deadlineTextField.text = [dateFormat stringFromDate:date];
}


#pragma mark - Task category

- (IBAction)categoryTextFieldDidBeginEditing:(UITextField *)sender {
    UIPickerView *categoryPicker = [[UIPickerView alloc] init];
    [categoryPicker setDataSource:self];
    [categoryPicker setDelegate:self];
    categoryPicker.showsSelectionIndicator = YES;
    [categoryPicker selectRow:[self.categories indexOfObject:self.detailItem.category] inComponent:0 animated:NO];
    self.categoryTextField.inputView = categoryPicker;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.categories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    TaskCategory *tc = self.categories[row];
    return tc.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TaskCategory *tc = self.categories[row];
    self.categoryTextField.text = tc.name;
    self.categoryTextField.backgroundColor = tc.colorAsUIColor;
    self.detailItem.category = tc;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMasterNotification" object:nil];
}

- (NSArray *)categories {
    if (_categories != nil) {
        return _categories;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:COREDATA_ENTITYNAME_TASKCATEGORY inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.categories = results;
    return results;
}


#pragma mark - Notification

- (IBAction)notificationSwitchValueChanged:(id)sender {
    if (self.notificationSwitch.isOn) { // Add notification
        
        if ([self.detailItem.deadline compare:[NSDate date]] == NSOrderedAscending) {
            [self.notificationSwitch setOn:NO];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Notification"
                                                                           message:@"Deadline is in the past. Notification can't be scheduled."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = self.detailItem.deadline;
        notification.alertBody = self.detailItem.name;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    } else { // Remove notification
        
        NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
        for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
            if ([localNotification.alertBody isEqualToString:self.detailItem.name]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
                break;
            }
        }
        
    }
}


@end
