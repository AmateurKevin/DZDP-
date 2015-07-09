//
//  DPDealHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDealHeaderView.h"
#import "DPButtonItem.h"
#define DPCols 3

@interface DPDealHeaderView ()

@property(nonatomic,strong) NSMutableArray *buttons;

@end

@implementation DPDealHeaderView

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


+ (instancetype)DealHeaderViewWith:(NSArray *)items
{
    //NSUInteger count = items.count;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;

    DPDealHeaderView *headerView = [[self alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW * 0.4)];
    headerView.items = items;
    [headerView setupBtns];
    [headerView setupDivideLine];
    return headerView;
}

- (void)setupBtns
{
    for (int i = 0; i < _items.count; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        DPButtonItem  *item = _items[i];
        [button setTitle:[NSString stringWithFormat:@"%@",item.title] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        button.tag = i;
        
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}

- (void)btnClicked:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(dealHeaderView:buttonClicked:)]) {
        [self.delegate dealHeaderView:self buttonClicked:button];
    }
    
}

- (void)setupDivideLine
{
    NSInteger rows = self.items.count / DPCols;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonW = screenW / 3;
    CGFloat buttonH = buttonW * 0.4;
    CGFloat divideH = rows *buttonH;
    
    // 竖线
    for (int i = 1; i < DPCols;i++) {
        UIView *divide = [[UIView alloc] initWithFrame:CGRectMake(buttonW * i, 0, 1, divideH)];
        divide.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:divide];
    }
    
    // 横线
    for (int i =1 ; i < rows;i++ ) {
        UIView *divide = [[UIView alloc] initWithFrame:CGRectMake(0, buttonH * i, screenW, 1)];
        divide.backgroundColor  = [UIColor lightGrayColor];
        [self addSubview:divide];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < _items.count; i++) {
        
        int row =  i / DPCols;
        int col =  i % DPCols;
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat buttonW = screenW / 3;
        CGFloat buttonH = buttonW * 0.4;
        CGFloat buttonX = col * buttonW;
        CGFloat buttonY = row * buttonH;
        UIButton *button = self.buttons[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
    }
}


@end
