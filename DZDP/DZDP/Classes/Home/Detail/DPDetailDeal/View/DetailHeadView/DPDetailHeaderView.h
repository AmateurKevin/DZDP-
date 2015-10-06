//
//  DPDetailHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDeal;

@protocol DPDetailHeaderViewDelegate <NSObject>

@optional
- (void)detailHeaderViewPushOtherController;
@end

@interface DPDetailHeaderView : UIView

@property(nonatomic,strong) NSArray *imageURLs;

+ (instancetype)detailHeaderView;

@property(nonatomic,strong) DPDeal *deal;

@property(nonatomic,weak) id<DPDetailHeaderViewDelegate> delegate;

@end
