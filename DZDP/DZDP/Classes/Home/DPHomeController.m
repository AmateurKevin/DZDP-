//
//  DPDealController.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPHomeController.h"
#import "DPDealCell.h"
#import "DPCity.h"
#import "DPHomeHeaderView.h"
#import "DPSortCityController.h"
#import "DPDealAPI.h"
#import "DPCategoryMenuController.h"
#import "DPDealMainController.h"
#import "DPRightImageButton.h"
#import "DPHomeCategoryModel.h"
#import "DPFindShopsParam.h"
#import <SVProgressHUD.h>
#import "DPDetailController.h"
#import "DPCategoryMenuController.h"
@interface DPHomeController ()<UITableViewDataSource,UITableViewDelegate,HomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

/** 选中的状态 */
@property (nonatomic, strong) DPCity *selectedCity;

@property(nonatomic,strong) NSMutableArray *deals;

- (IBAction)sortCityClicked:(id)sender;
@property (weak, nonatomic) IBOutlet DPRightImageButton *leftBtn;

@end

@implementation DPHomeController

// 弹出城市选择控制器
- (IBAction)sortCityClicked:(id)sender {
    
    DPSortCityController *sortCityVc = [DPSortCityController sortCityController];
    [self presentViewController:sortCityVc animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftBtn setTitle:UserDefaulsCityName forState:UIControlStateNormal];
   
    // 获取header数据
    // 加载主页分类模型
    DPHomeHeaderView *headView = [DPHomeHeaderView homeHeaderView];
    headView.homeCategoryModels = [DPHomeCategoryModel HomeCategoryModelFromJsonFile];
    headView.delegate = self;
    self.tableview.tableHeaderView = headView;
    
    // 添加监听城市选择的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:DPCityDidSelectNotification object:nil];
    [self loadNewDeals];
}

- (void)citySelect:(NSNotification *)note
{
    self.selectedCity = note.userInfo[DPSelectedCity];
    [self.leftBtn setTitle:self.selectedCity.short_name forState:UIControlStateNormal];
    [self loadNewDeals];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadNewDeals{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    DPFindDealsParam *param = [[DPFindDealsParam alloc] init];
    param.city_id = UserDefaultCityID;
    
    [[[DPDealAPI alloc] initWithDealParam:param] getDealsIfsuccess:^(NSArray *deals) {
        [SVProgressHUD dismiss];
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:deals];
        [self.tableview reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络不好,没有得到团购数据"];
    }];

}

#pragma mark -- HomeHeaderViewDelegate
- (void)homeHeaderView:(DPHomeHeaderView *)view didSelectCatID:(NSNumber *)catID orSubCatID:(NSNumber *)subCatID{
    
    DPFindShopsParam *param = [[DPFindShopsParam alloc] init];
    
    if (catID) {
        param.cat_ids = catID.description;
    }
    if (subCatID) {
        param.subcat_ids = subCatID.description;
    }
    
    // 全部分类页面
    if ([catID  isEqual: @(-1)]) {
        
        DPCategoryMenuController *vc = [[DPCategoryMenuController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    DPDealMainController *vc = [[DPDealMainController alloc] init];
    vc.shopsParam = param;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DPDealCell *cell = [DPDealCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.deal = self.deals[indexPath.row];
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //DPDetailController *detailVc = [DPDetailController detailController];
    DPDetailController *detailVc = [[DPDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    detailVc.deal = self.deals[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark --  lazyload
- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}



@end
