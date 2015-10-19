//
//  DPBaseViewController.m
//  DZDP
//
//  Created by nickchen on 15/10/7.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseViewController.h"

#import <MJRefresh.h>

@interface DPBaseViewController ()

{
    NSMutableArray *pullAnimationImages;
    NSMutableArray *shakeAnimationImages;
}

@property(nonatomic,strong) UIImageView *FullScreenImageView;


@end

@implementation DPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pullAnimationImages = [NSMutableArray array];
    shakeAnimationImages = [NSMutableArray array];

    NSMutableArray *pullAnimationName = [NSMutableArray array];
    for (int i = 1; i <=60 ; i++) {
        [pullAnimationName addObject:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
    }
    
    NSArray *shakeAnimationName =
  @[@"dropdown_loading_01",@"dropdown_loading_02",@"dropdown_loading_03"];
    for (NSString *str in pullAnimationName) {
        UIImage *image = [UIImage imageNamed:str];
        [pullAnimationImages addObject:image];
    }
    
    for (NSString *str in shakeAnimationName) {
        UIImage *image = [UIImage imageNamed:str];
        [shakeAnimationImages addObject:image];
    }
    
    [self shouldPullDownRefresh:_shouldInitPullToRefresh];
    
}

- (void)beginFullScreenAnimation{

    // Load images
    NSArray *fullscreenImageNames = @[@"loading_fullscreen_anim_01",
                                      @"loading_fullscreen_anim_02",
                                      @"loading_fullscreen_anim_03"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < fullscreenImageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[fullscreenImageNames objectAtIndex:i]]];
    }
    //
    
    // Normal Animation
    _FullScreenImageView = [[UIImageView alloc] init];
    _FullScreenImageView.frame = self.view.frame;
    _FullScreenImageView.contentMode = UIViewContentModeCenter;
    
    _FullScreenImageView.backgroundColor = DPBgColor;
    _FullScreenImageView.center =  CGPointMake(DPScreenWidth * 0.5, DPScreenHeight * 0.5 );
    _FullScreenImageView.animationImages = images;
    _FullScreenImageView.animationDuration = 0.5;
    
    [self.view addSubview:_FullScreenImageView];
    [_FullScreenImageView startAnimating];

    
}

- (void)stopFullScreenAnimation{

     [_FullScreenImageView stopAnimating];
     [_FullScreenImageView removeFromSuperview];
}

- (void)shouldPullDownRefresh:(BOOL)isAdd
{
    if (isAdd) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // 设置普通状态的动画图片
        //[header setImages:@[[UIImage imageNamed:@"icon_transform_animation"]] forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:pullAnimationImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:shakeAnimationImages forState:MJRefreshStateRefreshing];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        
        self.tableView.header = header;
    }else{
        self.tableView.header = nil;
    }
}

- (void)shouldPullUpRefresh:(BOOL)isAdd{
    
    if (isAdd) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.footer = footer;
  
    }else{
        self.tableView.footer = nil;
    }
    
}

- (void)loadNewData{
    
    [self.tableView.header beginRefreshing];
    // fake
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self endHeaderRefreshing];
        
    });
    
}

- (void)loadMoreData{
    
}

- (void)endHeaderRefreshing{
    
    [self.tableView.header endRefreshing];

}

- (void)endFooterRefreshing{
    [self.tableView.footer endRefreshing];
}

- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}


@end
