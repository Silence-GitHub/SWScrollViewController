//
//  ViewController2.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/8.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [NSString stringWithFormat:@"View controller at index %lu", (unsigned long)[self.scrollViewController.viewControllers indexOfObject:self]];
    [self.button setTitle:@"Set 10 view controllers" forState:UIControlStateNormal];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:10];
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller"];
    ViewController1 *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 1"];
    ViewController2 *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 2"];
    ViewController3 *vc3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 3"];
    ViewController4 *vc4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 4"];
    
    [viewControllers addObject:vc1];
    [viewControllers addObject:vc2];
    [viewControllers addObject:vc3];
    [viewControllers addObject:vc4];
    [viewControllers addObject:vc];
    
    for (int i = 0; i < 5; ++i) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor greenColor];
        vc.view.alpha = 0.1 * (i + 1);
        [viewControllers addObject:vc];
    }
    
    self.scrollViewController.viewControllers = viewControllers;
}

@end
