//
//  ViewController1.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/8.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [NSString stringWithFormat:@"View controller at index %lu", (unsigned long)[self.scrollViewController.viewControllers indexOfObject:self]];
    [self.button setTitle:@"Set 3 view controllers" forState:UIControlStateNormal];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller"];
    ViewController1 *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 1"];
    ViewController2 *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 2"];
    
    self.scrollViewController.viewControllers = @[vc, vc1, vc2];
}

@end
