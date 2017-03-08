//
//  SWScrollViewController.h
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/5.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWTitleScrollView.h"

@interface SWScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) SWTitleScrollView *titleScrollView;
@property (nonatomic, strong, readonly) NSArray <UIButton *> *titleButtons; // in title scroll view
@property (nonatomic, strong, readonly) UIView *markLine; // in title scroll view; to mark the title
@property (nonatomic, strong, readonly) UIScrollView *contentScrollView;

@property (nonatomic, copy) NSArray <__kindof UIViewController *> *viewControllers;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong, readonly) UIViewController *contentViewController; // view controller displaying content
@property (nonatomic, strong, readonly) UIView *contentView; // for content view controller
@property (nonatomic) CGFloat minEndDraggingVelocity;

- (instancetype)initWithControllers:(NSArray <__kindof UIViewController *> *)controllers;

/**
 Hide or show title scroll view.
 
 Parameters:
 
 hide: Specify YES to hide the title scroll view or NO to show it
 */
- (void)hideTitleScrollView:(BOOL)hide;

@end

@interface UIViewController (SWScrollViewItem)

@property (nonatomic, weak, readonly) SWScrollViewController *scrollViewController;

@end
