//
//  DPBaseViewController.h
//  DZDP
//
//  Created by nickchen on 15/10/7.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPBaseViewController : UIViewController

@property (weak, nonatomic) UITableView *tableView;

@property (nonatomic, assign) BOOL shouldInitPullToRefresh;


/**
 *  下拉刷新
 *
 *  @param isAdd
 */
- (void)shouldPullDownRefresh:(BOOL)isAdd;

/**
 *  上拉加载更多
 *
 *  @param isAdd
 */
- (void)shouldPullUpRefresh:(BOOL)isAdd;

/**
 *  开始进入界面时候的全屏加载动画
 */
- (void)beginFullScreenAnimation;

/**
 *  结束全屏加载动画
 */
- (void)stopFullScreenAnimation;

- (void)loadNewData;
- (void)loadMoreData;

- (void)endHeaderRefreshing;
- (void)endFooterRefreshing;

@end
