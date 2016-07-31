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
        
        self.scrollsToTop = NO;
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
    CGRect lastButtonFrame = _titleButtons.lastObject.frame;
    CGFloat markLine_height = CGRectGetHeight(_markLine.frame);
    CGFloat content_width = CGRectGetMaxX(lastButtonFrame) + BUTTONS_SPACE * 0.5f;
    CGFloat content_height = CGRectGetHeight(lastButtonFrame) + markLine_height;
    self.contentSize = CGSizeMake(content_width, content_height);
    
    // Update mark line frame
    // Mark line always in the bottom
    CGFloat markLine_x = _markLine.frame.origin.x;
    CGFloat markLine_y = content_height - markLine_height;
    CGFloat markLine_width = _markLine.frame.size.width;
    
    _markLine.frame = CGRectMake(markLine_x, markLine_y, markLine_width, markLine_height);
}

@end
