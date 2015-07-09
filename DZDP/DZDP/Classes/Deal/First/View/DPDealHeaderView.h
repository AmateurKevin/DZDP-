//
//  DPDealHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDealHeaderView;
@protocol DealHeaderViewDelegate <NSObject>

@optional
-(void)dealHeaderView:(DPDealHeaderView *)dealHeaderView buttonClicked:(UIButton *)button;

@end

@interface DPDealHeaderView : UIView

@property(nonatomic,strong) NSArray *items;

+ (instancetype)DealHeaderViewWith:(NSArray *)items;

@property(nonatomic,weak) id<DealHeaderViewDelegate> delegate;

@end
