//
//  ZCJButtonView.h
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCJTableViewCell;
@interface ZCJButtonView : UIView

- (id)initWithButtons:(NSArray *)buttons parentCell:(ZCJTableViewCell *)parentCell buttonSelector:(SEL)buttonSelector;

- (id)initWithFrame:(CGRect)frame Buttons:(NSArray *)buttons parentCell:(ZCJTableViewCell *)parentCell buttonSelector:(SEL)buttonSelector;

- (CGFloat)getWidth;
- (void)layoutButtons;

@end
