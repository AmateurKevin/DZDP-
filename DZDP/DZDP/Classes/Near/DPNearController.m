//
//  DPHomeViewController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPNearController.h"

#import "DOPDropDownMenu.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"
#import "DPCategory.h"
#import "DPDistrict.h"
#import "DPSort.h"
#import "DPDealAPI.h"
#import "DPShopsAPI.h"
#import "DPDealCell.h"
#import "DPDetailController.h"
#import "DPSubCategory.h"
#import "DPBiz_area.h"
#import <SVProgressHUD.h>
#import "DPShop.h"
#import "DPDealHeaderView.h"
#import "DPDealFooterCell.h"
#import "DPDeal.h"
#import "DPShopDetailController.h"
#import "DPNearLocationView.h"
#import "DPRadius.h"


static NSString * const reuseIdentifier = @"maincell";
static NSString * const headerReuseIdentifier = @"header";
static NSString * const footererCellReuseIdentifier = @"footerCell";
static NSString * const separatorCellReuseIdentifier = @"separator";

@interface DPNearController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,DPDealHeaderViewDelegate,DPNearLocationViewDelegate>
@property(nonatomic,strong) NSArray *categories;
@property(nonatomic,strong) NSArray *searchRadius;
@property(nonatomic,strong) NSArray *sorts;

@property(nonatomic,strong) NSMutableArray *shops;

@property(nonatomic,strong) NSMutableArray *sectionShops;

@property (weak, nonatomic) UITableView *tableView;
// 顶部显示位置信息的view
@property(nonatomic,weak) UIView *locationView;
// 顶部多选菜单
@property(nonatomic,weak) DOPDropDownMenu *menu;


@end

@implementation DPNearController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self inittopMenu];
    [self initlocationView];
    [self initTableView];
 
}

#pragma mark -- init


- (void)inittopMenu{
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.dataSource = self;
    menu.delegate = self;
    // 有二级列表时，点击第一级列表不做响应
    menu.isClickHaveItemValid = NO;
    [self.view addSubview:menu];
    self.menu = menu;

}

- (void)initlocationView{
    DPNearLocationView *locationView = [DPNearLocationView nearLocationView];
    locationView.delegate = self;
    locationView.right = self.view.right;
    locationView.left = self.view.left;
    locationView.top = self.menu.bottom;
    locationView.height = 30;
    [self.view addSubview:locationView];

}

- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,138,DPScreenWidth,DPScreenHeight - 44) style:UITableViewStylePlain];
   
    [tableView registerClass:[DPDealHeaderView class] forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:separatorCellReuseIdentifier];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -- netWork
- (void)loadNewShops:(DPFindShopsParam *)param{
    
    if (param.location.length <= 0) {
        
        [SVProgressHUD showErrorWithStatus:@"定位未成功"];
        
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[[DPShopsAPI alloc] initWithShopsParam:param] getShopsIfsuccess:^(NSArray *Shops) {
        
        [SVProgressHUD dismiss];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:Shops];
        
        [self.sectionShops removeAllObjects];
        [self updateSectionShops];
        [self.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"网络不好"];
    }];
    
}

- (void)loadMoreDeals:(DPFindDealsParam *)param{
    
}

#pragma mark -- tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionShops.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sectionShops[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.sectionShops[indexPath.section];
    
    // 正常cell部分
    if ([array[indexPath.row] isKindOfClass:[DPDeal class]]) {
        
        DPDealCell *cell = [DPDealCell cellWithTableView:tableView];
        cell.deal = array[indexPath.row];
        return cell;
        
    }
    // 其他更多团购部分
    if ([array[indexPath.row] isKindOfClass:[NSNumber class]])
    {
        
        DPDealFooterCell *cell = [DPDealFooterCell cellWithTableView:tableView];
        NSNumber *count = array[indexPath.row];
        cell.countLabel.text = [NSString stringWithFormat:@"其他%lu个团购",count.integerValue];
        return cell;
        
    }
    // 阴影部分
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:separatorCellReuseIdentifier];
    cell.contentView.backgroundColor = DPBgGrayColor;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.sectionShops[indexPath.section];
    
    if ([array[indexPath.row] isKindOfClass:[DPDeal class]]) {
        // 正常的团购cell
        return 100;
        
    }
    if ([array[indexPath.row] isKindOfClass:[NSNumber class]]){
        // 每组下方的footer,显示“其他多少条团购”
        return 24;
        
    }
    // 每组间的阴影,r如果阴影是footer的一部分，产生的效果是footer把header顶上去
    return 10;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DPShop *shop = self.shops[section];
    
    DPDealHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    headerView.delegate = self;
    headerView.shop = shop;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark -- DPDealHeaderViewDelegate
- (void)dealHeaderViewTapped:(DPShop *)shop{
    
    DPLog(@"%@",shop);
    DPShopDetailController *vc = [[DPShopDetailController alloc] init];
    vc.shop = shop;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.sectionShops[indexPath.section];
    
    if ([array[indexPath.row] isKindOfClass:[DPDeal class]]) {
        
        DPDetailController *detailVc = [[DPDetailController alloc] init];
        detailVc.deal = array[indexPath.row];
        detailVc.shop = _shops[indexPath.row];
        [self.navigationController pushViewController:detailVc animated:YES];
        
    }else{
        
        
        [self.sectionShops replaceObjectAtIndex:indexPath.section withObject:[self.shops[indexPath.section] deals]];
        [self.sectionShops[indexPath.section] addObject:separatorCellReuseIdentifier];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}

#pragma mark -- lazy load

- (NSArray *)categories{
    if (!_categories) {
        _categories = [DPMetaDataTool categories];
    }
    return _categories;
}

- (NSArray *)searchRadius{
    if (!_searchRadius) {
        _searchRadius = [DPMetaDataTool searchRadius];
    }
    return _searchRadius;
}

- (NSArray *)sorts
{
    if (!_sorts) {
        _sorts = [DPMetaDataTool sorts];
    }
    return _sorts;
}

#pragma mark -- DOPDropDownMenuDataSource

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.categories.count;
    }else if(column == 1){
        return self.searchRadius.count;
    }else{
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return [self.categories[indexPath.row] cat_name];
    }else if(indexPath.column == 1){
        return [self.searchRadius[indexPath.row] radiusTip];
    }else{
        return [self.sorts[indexPath.row] label];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        return [self.categories[row] subcategories].count;
    }else if(column == 1){
        return 0;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return [[self.categories[indexPath.row] subcategories][indexPath.item] subcat_name];
    }else if(indexPath.column == 1){
        return nil;
    }
    return nil;
}

#pragma mark -- DOPDropDownMenuDelegate
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.item >= 0) {
            NSNumber *subCatID = [[self.categories[indexPath.row] subcategories][indexPath.item] subcat_id];
            self.shopsParam.subcat_ids = subCatID.description;
        }else{
            NSNumber *catID = [self.categories[indexPath.row] cat_id];
            self.shopsParam.cat_ids = catID.description;
        }
    }
    if (indexPath.column == 1) {
        DPRadius *r = self.searchRadius[indexPath.row];
       
        self.shopsParam.radius = r.radius;
    }
    if (indexPath.column == 2) {
        //        DPSort *sort = self.sorts[indexPath.row];
        //        self.param.sort = sort.value;
    }
    [self loadNewShops:self.shopsParam];
}

#pragma mark -- DPNearLocationViewDelegate
- (void)nearLocationViewRefreshLocation:(NSString *)Location{
    
    self.shopsParam.location = Location;
    [self loadNewShops:self.shopsParam];

}

#pragma mark -- lazy load

- (DPFindShopsParam *)shopsParam{
    
    if (_shopsParam == nil) {
        _shopsParam = [[DPFindShopsParam alloc] init];
    }
    
    return _shopsParam;
    
}

- (NSMutableArray *)shops{
    
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    
    return _shops;
    
}

- (NSMutableArray *)sectionShops{
    
    if (!_sectionShops) {
        _sectionShops = [NSMutableArray array];
    }
    return _sectionShops;
    
}

- (void)updateSectionShops{
    [self.shops enumerateObjectsUsingBlock:^(DPShop*  _Nonnull shop, NSUInteger section, BOOL * _Nonnull stop) {
        
        
        NSMutableArray *arr = [NSMutableArray array];
        
        if (shop.deals.count <= 0)  return ;
        
        if (shop.deals.count > 2) {
            
            [arr addObject:shop.deals[0]];
            [arr addObject:shop.deals[1]];
            [arr addObject:@(shop.deals.count - 2)];
            [arr addObject:separatorCellReuseIdentifier];
            [self.sectionShops addObject:arr];
            
        }else{
            
            [arr addObjectsFromArray:shop.deals];
            [arr addObject:separatorCellReuseIdentifier];
            
            [self.sectionShops addObject:arr];
            
        }
        
    }];
}

@end

