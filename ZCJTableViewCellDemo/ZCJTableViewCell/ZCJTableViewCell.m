//
//  ZCJTableViewCell.m
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "ZCJTableViewCell.h"
#import "ZCJButtonView.h"

static NSString * const kTableViewCellContentView = @"UITableViewCellContentView";

@interface ZCJTableViewCell()<UIScrollViewDelegate>
@property (nonatomic) CGFloat height;
@property (nonatomic, strong) ZCJButtonView *rightButtonView;
@property (nonatomic, strong) UIScrollView *cellScrollView;
@property (nonatomic, strong) UIView *cellContentView;
@property (nonatomic) ZCJCellState state;
@end

@implementation ZCJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parentTableView:(UITableView *)parentTableView rightButtons:(NSArray *)rightButtons {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rightButtons = rightButtons;
        _parentTableView = parentTableView;
        _height = parentTableView.rowHeight;
        _state = ZCJCellStateCenter;
        [self initializar];
    }
    return self;
}

- (void)initializar {
    //右侧操作视图初始化
    ZCJButtonView *rightButtonView = [[ZCJButtonView alloc] initWithButtons:_rightButtons parentCell:self buttonSelector:@selector(buttonAction:)];
    rightButtonView.frame = CGRectMake(self.bounds.size.width, 0, [_rightButtonView getWidth], _height);
    [rightButtonView layoutButtons];
    _rightButtonView = rightButtonView;
    
    //滚动视图初始化
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _height)];
    scrollView.contentSize = CGSizeMake(self.bounds.size.width + [rightButtonView getWidth], self.height);
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    _cellScrollView = scrollView;
    
    [_cellScrollView addSubview:_rightButtonView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _height)];
    contentView.backgroundColor = [UIColor whiteColor];
    [_cellScrollView addSubview:contentView];
    _cellContentView = contentView;
    
    //将原来cell上的内容添加到滚动视图上
    UIView *contentViewParent = self;
    if (![NSStringFromClass([[self.subviews objectAtIndex:0] class]) isEqualToString:kTableViewCellContentView]) {
        // iOS 7
        contentViewParent = [self.subviews objectAtIndex:0];
    }
    NSArray *cellSubviews = [contentViewParent subviews];
    [self insertSubview:_cellScrollView atIndex:0];
    for (UIView *subview in cellSubviews) {
        [_cellContentView addSubview:subview];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _cellScrollView.frame = CGRectMake(0, 0, self.bounds.size.width, _height);
    _cellScrollView.contentSize = CGSizeMake(self.bounds.size.width + [_rightButtonView getWidth], self.height);
    
    _rightButtonView.frame = CGRectMake(self.bounds.size.width, 0, [_rightButtonView getWidth], _height);
    _cellContentView.frame = CGRectMake(0, 0, self.bounds.size.width, _height);
}

- (void)buttonAction:(id)sender {
    UIButton *btn = sender;
    NSInteger index = btn.tag - 1000;
    if ([self.delegate respondsToSelector:@selector(swippableTableViewCell:didTriggerRightButtonViewWithIndex:)]) {
        [self.delegate swippableTableViewCell:self didTriggerRightButtonViewWithIndex:index];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 0) {
        self.rightButtonView.frame = CGRectMake(scrollView.contentOffset.x + self.bounds.size.width - [self.rightButtonView getWidth], 0, [self.rightButtonView getWidth], _height);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    switch (_state) {
        case ZCJCellStateCenter:
            if (velocity.x >= 0.5) {
                [self scrollToRight:targetContentOffset];
            }
            else {
                if (targetContentOffset->x >= [self.rightButtonView getWidth] / 2) {
                    [self scrollToRight:targetContentOffset];
                }
                else {
                    [self scrollToCenter:targetContentOffset];
                }
            }
            break;
            
        case ZCJCellStateRight:
            if (velocity.x >= 0.5) {
                
            }
            else if (velocity.x <= -0.5) {
                [self scrollToCenter:targetContentOffset];
            }
            else {
                if (targetContentOffset->x <= [self.rightButtonView getWidth] / 2) {
                    [self scrollToCenter:targetContentOffset];
                }
                else {
                    [self scrollToRight:targetContentOffset];
                }
            }
            break;
            
        default:
            break;
    }
}

- (void)scrollToRight:(inout CGPoint *)targetContentOffset {
    targetContentOffset->x = [self.rightButtonView getWidth];
    self.state = ZCJCellStateRight;
}

- (void)scrollToCenter:(inout CGPoint *)targetContentOffset {
    targetContentOffset->x = 0;
    self.state = ZCJCellStateCenter;
}
@end
