//
//  ZCJButtonView.m
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "ZCJButtonView.h"

#define KButtonWidthMax 270
#define KButtonWidthDefault 90

@interface ZCJButtonView()

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) ZCJTableViewCell *parentCell;
@property (nonatomic) SEL buttonSelector;
@end

@implementation ZCJButtonView

- (id)initWithButtons:(NSArray *)buttons parentCell:(ZCJTableViewCell *)parentCell buttonSelector:(SEL)buttonSelector{
    return [self initWithFrame:CGRectZero Buttons:buttons parentCell:parentCell buttonSelector:buttonSelector];
}


- (id)initWithFrame:(CGRect)frame Buttons:(NSArray *)buttons parentCell:(ZCJTableViewCell *)parentCell buttonSelector:(SEL)buttonSelector{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = buttons;
        _parentCell = parentCell;
        _buttonSelector = buttonSelector;
    }
    return self;
}

- (CGFloat)getWidth {
    return KButtonWidthDefault * _buttons.count;
}

- (void)layoutButtons {
    NSInteger buttonCount = 1000;
    for (UIButton *button in _buttons) {
        button.frame = CGRectMake((buttonCount-1000)*KButtonWidthDefault, 0, KButtonWidthDefault, self.bounds.size.height);
        button.tag = buttonCount;
        [button addTarget:_parentCell action:_buttonSelector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        buttonCount++;
    }
}

@end
