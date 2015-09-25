//
//  CategoryDetailViewController.m
//  taskmanager
//
//  Created by Lukas Machalik on 25.09.15.
//  Copyright © 2015 Lukas Machalik. All rights reserved.
//

#import "CategoryDetailViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


@interface CategoryDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *selectedColorView;
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation CategoryDetailViewController

static int colorArray[14] = {0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.slider.minimumValue = 0.5;
    self.slider.maximumValue = 13.5;
    
    self.selectedColorView.backgroundColor = self.detailItem.colorAsUIColor;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    UIColor *color = UIColorFromRGB(colorArray[(int)self.slider.value]);
    self.selectedColorView.backgroundColor = color;
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        
        self.detailItem.color = [NSKeyedArchiver archivedDataWithRootObject:self.selectedColorView.backgroundColor];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshSettingsNotification" object:nil];
    }
    [super viewWillDisappear:animated];
}

@end
