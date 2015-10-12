//
//  DPBaseTableViewController.m
//  DZDP
//
//  Created by nickchen on 15/10/12.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseTableViewController.h"
#import <MJRefresh.h>
@interface DPBaseTableViewController ()

{
    NSMutableArray *pullAnimationImages;
    NSMutableArray *shakeAnimationImages;
}

@property(nonatomic,strong) UIImageView *FullScreenImageView;


@end

@implementation DPBaseTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    pullAnimationImages = [NSMutableArray array];
    shakeAnimationImages = [NSMutableArray array];
    
    NSMutableArray *pullAnimationName = [NSMutableArray array];
    for (int i = 1; i <= 60 ; i++) {
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
    
    _FullScreenImageView.size = CGSizeMake(90, 90);
    _FullScreenImageView.center = self.view.center;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
