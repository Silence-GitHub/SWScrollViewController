//
//  ViewController3.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/8.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [NSString stringWithFormat:@"View controller at index %lu", (unsigned long)[self.scrollViewController.viewControllers indexOfObject:self]];
    [self.button setTitle:@"Set 2 view controllers" forState:UIControlStateNormal];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:10];
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller"];
    [viewControllers addObject:vc];
    ViewController1 *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 1"];
    [viewControllers addObject:vc1];
    
    self.scrollViewController.viewControllers = viewControllers;
}

@end
