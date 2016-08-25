//
//  NSMutableArray+ZCJButton.m
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "NSMutableArray+ZCJButton.h"

@implementation NSMutableArray (ZCJButton)

- (void)addButtonWithBackgroundColor:(UIColor *)color withTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:color];
    [self addObject:btn];
}

@end
