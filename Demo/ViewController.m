//
//  ViewController.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/5.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [NSString stringWithFormat:@"View controller at index %lu", (unsigned long)[self.scrollViewController.viewControllers indexOfObject:self]];
    [self.button setTitle:@"Title on/off" forState:UIControlStateNormal];
    [self.button2 setTitle:@"Select view controller at index 1" forState:UIControlStateNormal];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    [self.scrollViewController hideTitleScrollView:(self.scrollViewController.titleScrollView ? YES : NO)];    
}

- (IBAction)button2Pressed:(UIButton *)sender {
    
    self.scrollViewController.selectedIndex = 1;
}
@end
