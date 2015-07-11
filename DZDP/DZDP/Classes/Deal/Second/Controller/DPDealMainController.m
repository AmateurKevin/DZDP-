//
//  DPDealMainController.m
//  DZDP
//
//  Created by nickchen on 15/7/11.
//  Copyright (c) 2015年 https://github.com/nickqiao/ All rights reserved.
//

#import "DPDealMainController.h"
#import "DOPDropDownMenu.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"
#import "DPCategory.h"
#import "DPRegion.h"
#import "DPSort.h"
#import "DPDealTool.h"
#import "DPDealCell.h"
#import "DPDetailController.h"
@interface DPDealMainController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *categories;
@property(nonatomic,strong) NSArray *regions;
@property(nonatomic,strong) NSArray *sorts;
@property(nonatomic,strong) NSMutableArray *deals;
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation DPDealMainController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewDeals:self.param];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
   
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.dataSource = self;
    menu.delegate = self;
    // 有二级列表时，点击第一级列表不做响应
    menu.isClickHaveItemValid = NO;
    [self.view addSubview:menu];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,108,DPScreenWidth,DPScreenHeight - 44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 88;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSMutableArray *)deals
{
    if (_deals == nil) {
        _deals = @[].mutableCopy;
    }
    return _deals;
}

- (DPFindDealsParam *)param
{
    if (_param == nil) {
        _param = [[DPFindDealsParam alloc] init];
    }
    return _param;
}

- (void)loadNewDeals:(DPFindDealsParam *)param{
    
    [DPDealTool getDealsWith:param success:^(DPFindDealsResult *result) {
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadMoreDeals:(DPFindDealsParam *)param{
    
}

#pragma mark -- tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPDealCell *cell = [DPDealCell cellWithTableView:tableView];
    cell.deal = self.deals[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPDetailController *detailVc = [[DPDetailController alloc] init];
    detailVc.deal = self.deals[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark -- lazy load

- (NSArray *)categories{
    if (!_categories) {
        _categories = [DPMetaDataTool categories];
    }
    return _categories;
}

- (NSArray *)regions
{
    if (!_regions) {
        DPCity *city = [DPMetaDataTool cityWithName:UserDefaulsCityName];
        _regions = city.regions;
    }
    return _regions;
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
        return self.regions.count;
    }else{
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return [self.categories[indexPath.row] name];
    }else if(indexPath.column == 1){
        return [self.regions[indexPath.row] name];
    }else{
        return [self.sorts[indexPath.row] label];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        return [self.categories[row] subcategories].count;
    }else if(column == 1){
        return [self.regions[row] subregions].count;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return [self.categories[indexPath.row] subcategories][indexPath.item];
    }else if(indexPath.column == 1){
        return [self.regions[indexPath.row] subregions][indexPath.item];
    }
    return nil;
}

#pragma mark -- DOPDropDownMenuDelegate
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.item >= 0) {
            NSString *categ = [self.categories[indexPath.row] subcategories][indexPath.item];
            if (![categ isEqualToString:@"全部"]) {
                self.param.category = categ;
            }
        }else{
            NSString *cate = [self.categories[indexPath.row] name];
            if (![cate isEqualToString:@"全部分类"]) {
                self.param.category = cate;
            }
        }
    }
    if (indexPath.column == 1) {
        if (indexPath.item >= 0) {
            NSString *region = [self.regions[indexPath.row] subregions][indexPath.item];
            if (![region isEqualToString:@"全部"]) {
                self.param.region = region;
            }
        }else{
            NSString *region =[self.regions[indexPath.row] name];
            if (![region isEqualToString:@"全部"]) {
                self.param.region = region;
            }
        }
    }
    if (indexPath.column == 2) {
        DPSort *sort = self.sorts[indexPath.row];
        self.param.sort = @(sort.value);
    }
    [self loadNewDeals:self.param];
}
@end
