//
//  SWScrollViewController.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/5.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "SWScrollViewController.h"

@interface SWScrollViewController ()

@end

@implementation SWScrollViewController {
    BOOL _shouldHideTitleScrollView;
    BOOL _scrollingAfterTitleButtonPressed;
}

#pragma mark - Properties

- (NSArray<UIButton *> *)titleButtons {
    return _titleScrollView.titleButtons;
}

- (UIView *)markLine {
    return _titleScrollView.markLine;
}

@synthesize contentScrollView = _contentScrollView;

- (UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        CGFloat y = [self contentScrollViewY];
        CGFloat height = [self contentScrollViewHeight];
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, height)];
        _contentScrollView.delegate = self;
        _contentScrollView.bounces = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.scrollsToTop = NO;
        [self.view addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    
    if (![self checkControllers:viewControllers]) {
        return;
    }
    
    BOOL hide = _shouldHideTitleScrollView;
    if (!hide) {
        [self hideTitleScrollView:YES];
    }
    [self hideViewControllers];
    
    _viewControllers = viewControllers;
    
    if (!hide) {
        [self hideTitleScrollView:NO];
    }
    [self displayViewControllers];
}

- (void)hideTitleScrollView:(BOOL)hide {
    
    _shouldHideTitleScrollView = hide;
    
    if (hide && _titleScrollView) {
        // Hide title scroll view
        [_titleScrollView removeFromSuperview];
        _titleScrollView = nil;
        
    } else if (!hide && !_titleScrollView) {
        // Show title scroll view
        [self setupTitleScrollView];
    }
    
    // viewWillLayoutSubviews method will update content scroll view frame, child view controller frame and content scroll view content size
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= self.viewControllers.count) {
        NSLog(@"SWScrollViewController selected index (%ld) must < number of view controllers (%lu)", (long)selectedIndex, (unsigned long)self.viewControllers.count);
        return;
    }
    
    [self.contentScrollView scrollRectToVisible:[self frameForContentControllerAtIndex:selectedIndex] animated:YES];
    _selectedIndex = selectedIndex;
}

- (UIViewController *)contentViewController {
    return _viewControllers[_selectedIndex];
}

- (UIView *)contentView {
    return self.contentViewController.view;
}

#pragma mark - View controller life cycle

- (instancetype)init {
    // Init
    self = [super init];
    if (self) {
        _shouldHideTitleScrollView = NO;
        _selectedIndex = 0;
        _minEndDraggingVelocity = 2;
    }
    return self;
}

- (instancetype)initWithControllers:(NSArray <__kindof UIViewController *> *)controllers {
    
    if (![self checkControllers:controllers]) {
        return nil;
    }
    
    // Init
    self = [super init];
    if (self) {
        _shouldHideTitleScrollView = NO;
        _viewControllers = controllers;
        _selectedIndex = 0;
        _minEndDraggingVelocity = 2;
    }
    return self;
}

- (BOOL)checkControllers:(NSArray <__kindof UIViewController *> *)controllers {
    if (controllers.count < 1) {
        NSLog(@"SWSegmentedController must contain at least 1 child controller");
        return NO;
    }
    // Check type of controller
    for (id vc in controllers) {
        if (![vc isKindOfClass:[UIViewController class]]) {
            NSLog(@"Child controllers of SWSegmentedController must be UIViewController class type or its subclass type. Now controllers has a object with class: %@", [vc class]);
            return NO;
        }
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self displayViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_shouldHideTitleScrollView && !_titleScrollView) {
        // Show title scroll view if needed
        [self setupTitleScrollView];
    }
}

- (void)setupTitleScrollView {
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    int i = 0;
    CGFloat maxWidth = 0;
    for (UIViewController *vc in _viewControllers) {
        UIButton *button = [UIButton new];
        [button addTarget:self action:@selector(titleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:(vc.title.length ? vc.title : [NSString stringWithFormat:@"Title %d", i]) forState:UIControlStateNormal];
        [button sizeToFit];
        maxWidth = MAX(maxWidth, button.bounds.size.width);
        [buttons addObject:button];
        
        ++i;
    }
    
    CGFloat minWidth = (self.view.bounds.size.width - buttons.count * BUTTONS_SPACE) / buttons.count; // all buttons are visible in view
    maxWidth = MAX(maxWidth, minWidth);
    
    for (UIButton *button in buttons) {
        button.frame = CGRectMake(0, 0, maxWidth, button.frame.size.height);
    }
    
    _titleScrollView = [[SWTitleScrollView alloc] initWithButtons:buttons];
    [_titleScrollView setup];
    _titleScrollView.frame = CGRectMake(0, [self.topLayoutGuide length], self.view.bounds.size.width, _titleScrollView.contentSize.height);
    [self.view addSubview:_titleScrollView];
}

- (void)titleButtonPressed:(id)sender {
    
    if ([sender isKindOfClass:[UIButton class]] && [self.titleButtons containsObject:sender]) {
        // Get selected button index
        NSUInteger index = [self.titleButtons indexOfObject:sender];
        
        // Scroll to title button
        CGRect titleRect = CGRectMake([sender frame].origin.x - BUTTONS_SPACE * 0.5f, [sender frame].origin.y, [sender frame].size.width + BUTTONS_SPACE, [sender frame].size.height);
        [self.titleScrollView scrollRectToVisible:titleRect animated:YES];
        
        // Scroll to content view
        [self.contentScrollView scrollRectToVisible:[self frameForContentControllerAtIndex:index] animated:YES];
        
        // Update seleted index
        _selectedIndex = index;
        
        // Indicate scroll after title button pressed begin
        _scrollingAfterTitleButtonPressed = YES;
    }
}

- (void)viewWillLayoutSubviews {
    
    // Update title scroll view content size
    [_titleScrollView updateContentSize];
    
    CGFloat contentView_width = self.view.bounds.size.width;
    
    // Update title scroll view frame
    _titleScrollView.frame = CGRectMake(0, [self.topLayoutGuide length], contentView_width, _titleScrollView.contentSize.height);
    
    // Update title button frame
    NSArray <UIButton *> *buttons = self.titleButtons;
    CGFloat maxWidth = 0;
    for (UIButton *button in buttons) {
        CGRect rect = [button.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : button.titleLabel.font } context:nil];
        maxWidth = MAX(maxWidth, rect.size.width);
    }
    CGFloat minWidth = (contentView_width - buttons.count * BUTTONS_SPACE) / buttons.count; // all buttons are visible in view
    maxWidth = MAX(maxWidth, minWidth);
    
    CGFloat x = 0.5f * BUTTONS_SPACE;
    for (UIButton *button in buttons) {
        button.frame = CGRectMake(x, 0, maxWidth, button.frame.size.height);
        x += maxWidth + BUTTONS_SPACE;
    }
    
    // Update mark line frame
    self.markLine.frame = CGRectMake((maxWidth + BUTTONS_SPACE) * _selectedIndex, CGRectGetMinY(self.markLine.frame), maxWidth + BUTTONS_SPACE, CGRectGetHeight(self.markLine.frame));
    [self.titleScrollView scrollRectToVisible:self.markLine.frame animated:NO];
    
    // Update content scoll view frame
    CGFloat contentView_y = [self contentScrollViewY];
    CGFloat contentView_height = [self contentScrollViewHeight];
    
    self.contentScrollView.frame = CGRectMake(0, contentView_y, contentView_width, contentView_height);
    
    // Update content scroll view content size and content offset
    NSUInteger i = 0;
    for (UIViewController *vc in _viewControllers) {
        
        vc.view.frame = [self frameForContentControllerAtIndex:i++];
    }
    self.contentScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * i, contentView_height);
    self.contentScrollView.contentOffset = CGPointMake(_selectedIndex * contentView_width, 0);
}

- (CGFloat)contentScrollViewY {
    CGFloat y = [self.topLayoutGuide length];
    if (_titleScrollView) {
        y = CGRectGetMaxY(_titleScrollView.frame);
    }
    return y;
}

- (CGFloat)contentScrollViewHeight {
    
    return self.view.bounds.size.height - [self.bottomLayoutGuide length] - [self contentScrollViewY];
}

#pragma mark - Manage view controllers

- (void)displayViewControllers {
    
    NSUInteger i = 0;
    for (UIViewController *vc in _viewControllers) {
        
        [self addChildViewController:vc];
        
        vc.view.frame = [self frameForContentControllerAtIndex:i++];
        [self.contentScrollView addSubview:vc.view];
        
        [vc didMoveToParentViewController:self];
    }
    
    self.contentScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * i, [self contentScrollViewHeight]);
}

- (void)hideViewControllers {
    
    for (UIViewController *vc in _viewControllers) {
        
        [vc willMoveToParentViewController:nil];
        
        [vc.view removeFromSuperview];
        
        [vc removeFromParentViewController];
    }
    
    _selectedIndex = 0;
}

- (CGRect)frameForContentControllerAtIndex:(NSUInteger)index {
    
    return CGRectMake(self.contentScrollView.bounds.size.width * index, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.contentScrollView) {
        
        // Calculate mark line distination frame to move
        UIButton *button = self.titleButtons[_selectedIndex];
        CGFloat markLine_x = CGRectGetMinX(button.frame) - BUTTONS_SPACE * 0.5f;
        CGFloat markLine_y = CGRectGetMinY(self.markLine.frame);
        CGFloat markLine_width = CGRectGetWidth(button.frame) + BUTTONS_SPACE;
        CGFloat markLine_height = CGRectGetHeight(self.markLine.frame);
        
        CGFloat contentOffset_x = scrollView.contentOffset.x;
        CGFloat contentView_width = self.view.bounds.size.width;
        
        CGFloat contentViewMoveLength = _selectedIndex * contentView_width - contentOffset_x;
        CGFloat markLineMoveLength = contentViewMoveLength / contentView_width * markLine_width;
        markLine_x -= markLineMoveLength;
        
        // Move mark line
        self.markLine.frame = CGRectMake(markLine_x, markLine_y, markLine_width, markLine_height);
        
        // Make mark line visible when panning to scroll, not pressing title button to scroll
        if (!_scrollingAfterTitleButtonPressed) {
            [_titleScrollView scrollRectToVisible:self.markLine.frame animated:NO];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (scrollView == self.contentScrollView) {
        
        CGFloat x = targetContentOffset->x;
        CGFloat contentView_width = self.view.bounds.size.width;
        
        CGFloat contentViewMoveLength = x - _selectedIndex * contentView_width;
        
        if (contentViewMoveLength < - contentView_width * 0.5f) {
            // Move left
            --_selectedIndex;
        } else if (contentViewMoveLength > contentView_width * 0.5f) {
            // Move right
            ++_selectedIndex;
        }
        if (ABS(velocity.x) >= _minEndDraggingVelocity) {
            targetContentOffset->x = _selectedIndex * contentView_width;
        } else {
            // Too slow
            targetContentOffset->x = scrollView.contentOffset.x; // Stop
            [scrollView setContentOffset:CGPointMake(_selectedIndex * contentView_width, scrollView.contentOffset.y) animated:true]; // Animate to destination with default velocity
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // Indicate scroll after title button pressed end
    _scrollingAfterTitleButtonPressed = NO;
}

@end

#pragma mark - UIViewController + SWScrollViewItem category

@implementation UIViewController (SWScrollViewItem)

- (SWScrollViewController *)scrollViewController {
    id parentVC = self.parentViewController;
    while (YES) {
        if (parentVC == nil || [parentVC isKindOfClass:[SWScrollViewController class]]) {
            return parentVC;
        }
        parentVC = ((UIViewController *)parentVC).parentViewController;
    }
}

@end
