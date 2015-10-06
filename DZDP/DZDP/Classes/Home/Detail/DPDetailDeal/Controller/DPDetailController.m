//
//  DPDetailController.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDetailController.h"
#import "DPDetailHeaderView.h"
#import "DPDeal.h"
#import "DPMoreDetailController.h"
#import "DPDetailDealAPI.h"
#import "DPDetailPriceCell.h"
#import "DPDetailBaseCell.h"
#import "DPScoreCell.h"
#import "DPShopTelCell.h"
#import "DPHtmlCell.h"
#import "UILabel+Html.h"
#import "DPShop.h"
#import "DPDetailShopAPI.h"

@interface DPDetailController ()<DPDetailHeaderViewDelegate,UITableViewDataSource,UIWebViewDelegate,DPShopTelCellDelegate>
@property(nonatomic,strong) DPDetailHeaderView *headerView;



@property(nonatomic,strong) DPDeal *detailDeal;


@end

@implementation DPDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    DPDetailHeaderView *headerView = [DPDetailHeaderView detailHeaderView];
   // self.automaticallyAdjustsScrollViewInsets = NO;
    headerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
    headerView.delegate = self;
//    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
   
    
    
    [DPDetailDealAPI getDetailDealWithID:_deal.deal_id success:^(DPDeal *deal) {
        // 为了产生多张图片的效果
        self.headerView.imageURLs = @[deal.image,deal.image,deal.image];
        self.headerView.deal = deal;
        _detailDeal = deal;
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
    
}

#pragma mark -- DPDetailHeaderViewDelegate
- (void)detailHeaderViewPushOtherController
{
    DPMoreDetailController *moreDetailVc = [[DPMoreDetailController alloc] init];
    moreDetailVc.detailDeal = _detailDeal;
    [self.navigationController pushViewController:moreDetailVc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
       return 1;
    }
    
    if (section == 2) {
      return 1;
    }
    
    if (section == 3) {
       return 3;
    }

    if (section == 4) {
        return 2;
    }
    return 0;
}


#pragma mark -- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DPDetailPriceCell *cell = [DPDetailPriceCell detailPriceCell];
            // 此处不用_detailDeal,因为promotion
            cell.deal = _deal;
            return cell;
        }else{
            
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DPScoreCell *cell = [DPScoreCell scoreCell];
            cell.deal = _deal;
            return cell;
        }else{
            
        }
    }
    // shop的详情
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            DPShopTelCell *cell =[DPShopTelCell shopTelCell];
            cell.shop = self.shop;
            cell.delegate = self;
            return cell;
        }else{
        
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            DPDetailBaseCell *cell = [[DPDetailBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"content"];
            cell.textLabel.text = @"套餐内容";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            return cell;
        }
        
        if (indexPath.row == 1) {
            DPHtmlCell *cell = [DPHtmlCell htmlCell];
            
            [cell.htmlLabel setHtml:_detailDeal.buy_contents];
            

            return cell;
        }
        if (indexPath.row == 2) {
             DPDetailBaseCell*cell = [[DPDetailBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picWord"];
            cell.textLabel.text = @"图文详情";
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
           
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else{
            
        }
    }
    
    if (indexPath.section == 4) {
        
        if (indexPath.row == 0) {
            DPDetailBaseCell *cell = [[DPDetailBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tip"];
            cell.textLabel.text = @"消费提示";
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            return cell;
        }
        
        if (indexPath.row == 1) {
            DPHtmlCell *cell = [DPHtmlCell htmlCell];
                        [cell.htmlLabel setHtml:_detailDeal.consumer_tips];
            return cell;
        }
        else{
            
        }

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark -- lazy load
- (DPShop *)shop{
    if (!_shop) {
        
        [DPDetailShopAPI getDetailShopWithID:[_deal.shops[0] shop_id] success:^(DPShop *shop) {
            _shop = shop;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(YTKBaseRequest *request) {
            
        }];
        
    }
    return  _shop;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 图文详情
    if (indexPath.section == 3 && indexPath.row == 2) {
        
        DPMoreDetailController *moreDetailVc = [[DPMoreDetailController alloc] init];
        moreDetailVc.detailDeal = _detailDeal;
        [self.navigationController pushViewController:moreDetailVc animated:YES];
        
    }
    
}

#pragma mark -- DPShopTelCellDelegate

- (void)shopTelBtnClicked{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"电话" message:_shop.phone preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *callAction =[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString * str=[NSString stringWithFormat:@"telprompt://%@",_shop.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }];
    [ac addAction:cancelAction];
    [ac addAction:callAction];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
