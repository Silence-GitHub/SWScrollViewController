//
//  SWTitleScrollView.m
//  SWScrollViewController
//
//  Created by Kaibo Lu on 16/5/7.
//  Copyright © 2016年 Kaibo Lu. All rights reserved.
//

#import "SWTitleScrollView.h"

@implementation SWTitleScrollView

const static CGFloat MARK_LINE_HEIGHT = 1.0f;

- (instancetype)initWithButtons:(NSArray<UIButton *> *)buttons {
    self = [super init];
    if (self) {
        CGFloat x = 0.5f * BUTTONS_SPACE;
        for (UIButton *button in buttons) {
            button.frame = CGRectMake(x, 0, button.bounds.size.width, button.bounds.size.height);
            x += button.bounds.size.width + BUTTONS_SPACE;
        }
        _titleButtons = buttons;
    }
    return self;
}

- (void)setup {
    
//    self.backgroundColor = [UIColor yellowColor];
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    [self setupTitleButtons];
    [self setupMarkLine];
    [self updateContentSize];
}

- (void)setupTitleButtons {
    for (UIButton *button in _titleButtons) {
        [self addSubview:button];
    }
}

- (void)setupMarkLine {
    
    UIButton *button = _titleButtons.firstObject;
    CGFloat y = CGRectGetMaxY(button.frame);
    CGFloat width = button.frame.size.width;
    _markLine = [[UIView alloc] initWithFrame:CGRectMake(0, y, width + BUTTONS_SPACE, MARK_LINE_HEIGHT)];
    _markLine.backgroundColor = [UIColor redColor];
    [self addSubview:_markLine];
}

- (void)updateContentSize {
    CGFloat width = CGRectGetMaxX(_titleButtons.lastObject.frame) + BUTTONS_SPACE * 0.5f;
    CGFloat height = CGRectGetMaxY(_markLine.frame);
    self.contentSize = CGSizeMake(width, height);
}

@end
