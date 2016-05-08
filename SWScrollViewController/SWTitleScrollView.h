//
//  SWTitleScrollView.h
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/7.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTONS_SPACE 8.0f // Space between buttons

@interface SWTitleScrollView : UIScrollView

@property (nonatomic, strong, readonly) NSArray <UIButton *> *titleButtons;
@property (nonatomic, strong, readonly) UIView *markLine; // to mark the title

- (instancetype)initWithButtons:(NSArray <UIButton *> *)buttons;

/**
 Setup this view.
 Call this method ONLY after initWithButtons: method
 */
- (void)setup;

/**
 Update content size after update buttons, mark line
 */
- (void)updateContentSize;

@end
