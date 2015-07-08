//
//  DPDetailController.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPDetailController.h"
#import "DPDetailHeaderView.h"
#import "DPDeal.h"
#import "DPDealTool.h"
#import "DPMoreDetailController.h"
@interface DPDetailController ()<DPDetailHeaderViewDelegate>
@property(nonatomic,strong) DPDetailHeaderView *headerView;
@end

@implementation DPDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    DPDetailHeaderView *headerView = [DPDetailHeaderView detailHeaderView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    headerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
    headerView.delegate = self;
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    DPGetSingleDealParam *param = [[DPGetSingleDealParam alloc] init];
    param.deal_id = self.deal.deal_id;
    [DPDealTool getSingleDealWith:param success:^(DPGetSingleDealResult *result) {
        self.deal = result.deals.firstObject;
        self.headerView.imageURLs = self.deal.more_s_image_urls;
        self.headerView.deal = self.deal;
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- DPDetailHeaderViewDelegate
- (void)detailHeaderViewPushOtherController
{
    DPMoreDetailController *moreDetailVc = [[DPMoreDetailController alloc] init];
    moreDetailVc.deal = self.deal;
    [self.navigationController pushViewController:moreDetailVc animated:YES];
}
@end
