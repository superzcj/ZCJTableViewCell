//
//  ZCJTableViewCell.h
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCJTableViewCell;

typedef enum {
    ZCJCellStateCenter,
    ZCJCellStateRight
}ZCJCellState;

@protocol ZCJTableViewCellDelegate <NSObject>

- (void)swippableTableViewCell:(ZCJTableViewCell *)cell didTriggerRightButtonViewWithIndex:(NSInteger)index;

@end

@interface ZCJTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *rightButtons;

@property (nonatomic, strong) UITableView *parentTableView;

@property (nonatomic, assign) id<ZCJTableViewCellDelegate> delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parentTableView:(UITableView *)parentTableView rightButtons:(NSArray *)rightButtons;

@end
