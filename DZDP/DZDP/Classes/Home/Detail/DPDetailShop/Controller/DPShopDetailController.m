//
//  DPShopDetailController.m
//  DZDP
//
//  Created by nickchen on 15/10/5.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPShopDetailController.h"
#import "DPShop.h"
#import "DPDeal.h"
#import "DPShopInfoCell.h"
#import "DPDetailShopAPI.h"
#import "DPDealCell.h"
#import "DPMapController.h"
@interface DPShopDetailController ()<UITableViewDataSource,UITableViewDelegate,DPShopInfoCellDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) DPShop *shopInfo;

@property(nonatomic,strong) NSArray *shopDeals;

@end

@implementation DPShopDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, DPScreenWidth, DPScreenHeight) style:UITableViewStyleGrouped];
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;

    self.navigationItem.title = @"商家详情";
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 商铺信息
    if (section == 0) {
        return 1;
    }
    // 此商店的团购
    return self.shopDeals.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DPShopInfoCell *cell = [DPShopInfoCell shopInfoCell];
        cell.shopInfo = _shopInfo;
        cell.deal = _shopDeals.firstObject;
        cell.delegate = self;
        return cell;

    }
    
    DPDealCell *cell = [DPDealCell dealCell];
    DPDeal *deal = self.shopDeals[indexPath.row];
    cell.deal = deal;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    else return 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 8;
}
- (void)setShop:(DPShop *)shop{
    _shop = shop;
   
    self.shopDeals = shop.deals;
    [DPDetailShopAPI getDetailShopWithID:shop.shop_id success:^(DPShop *returnshop) {
        
        _shopInfo = returnshop;
        [self.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

#pragma mark -- DPShopInfoCellDelegate

// 去地图
- (void)goToMap{
    DPLog(@"去地图");
    DPMapController *mapVc = [[DPMapController alloc] init];
    mapVc.shop = _shopInfo;
    [self.navigationController pushViewController:mapVc animated:YES];
}

- (void)callShop{
    
    if ([_shopInfo.phone containsString:@"|"]) {
        
        NSArray *phoneArray = [_shopInfo.phone componentsSeparatedByString:@"|"];
         UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"呼叫" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [phoneArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
             UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 NSString * str=[NSString stringWithFormat:@"telprompt://%@",obj];
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
             }];
            
            [ac addAction:action];
        }];
        
        UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];

        [self presentViewController:ac animated:YES completion:nil];
        
    }else{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"电话" message:_shopInfo.phone preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *callAction =[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString * str=[NSString stringWithFormat:@"telprompt://%@",_shopInfo.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }];
        [ac addAction:cancelAction];
        [ac addAction:callAction];
        [self presentViewController:ac animated:YES completion:nil];
    }
    
    }

#pragma mark -- lazy load

- (NSArray *)shopDeals{
    if (!_shopDeals) {
        _shopDeals = [NSArray array];
    }
    return _shopDeals;
}

@end
