//
//  ViewController4.m
//  SWScrollViewController
//
//  Created by 陆凯波 on 16/5/8.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController4.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [NSString stringWithFormat:@"View controller at index %lu", (unsigned long)[self.scrollViewController.viewControllers indexOfObject:self]];
    [self.button setTitle:@"Present or push" forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller"];
    ViewController1 *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"View controller 1"];
    
    SWScrollViewController *sv = [[SWScrollViewController alloc] initWithControllers:@[vc, vc1]];
    
    if (self.navigationController) {
        [self.navigationController pushViewController:sv animated:YES];
    } else {
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:sv];
        sv.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
        [self presentViewController:nc animated:YES completion:nil];
    }
}

- (void)goBack:(id)sender {
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
