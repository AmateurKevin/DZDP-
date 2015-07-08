//
//  DPAllDealViewController.m
//  DZDP
//
//  Created by nickchen on 15/7/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPAllDealViewController.h"
#import "DPCity.h"
#import "DPRegion.h"
#import "DPCategory.h"
#import "DPDealCell.h"
#import "DPDealTool.h"
#import "UIView+Frame.h"
#import "DPChooseCategoryViewController.h"
#import "DPChooseRegionViewController.h"
#import "DPChooseSortController.h"
#import "DPSiftController.h"
#import "DPDetailController.h"
@interface DPAllDealViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


/** 选中的状态 */
@property (nonatomic, strong) DPCity *selectedCity;
/** 当前选中的区域 */
@property (strong, nonatomic) DPRegion *selectedRegion;

/** 当前选中的分类 */
@property (strong, nonatomic) DPCategory *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;

@property(nonatomic,strong) NSMutableArray *deals;

@property(nonatomic,strong) DPChooseCategoryViewController *categoryVc;
@property(nonatomic,strong) DPChooseRegionViewController *regionVc;
@property(nonatomic,strong) DPSiftController *siftVc;


/** 正在显示的控制器 */
@property (nonatomic, weak) UIViewController *showingVc;
/** 用来存放子控制器的view */
@property (nonatomic, weak) UIView *contentView;

@end

@implementation DPAllDealViewController
- (IBAction)btnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    
        // 获得控制器的位置（索引）
        NSUInteger index = btn.tag;
        
        // 当前控制器的索引
        NSUInteger oldIndex = [self.childViewControllers indexOfObject:self.showingVc];
        if (oldIndex == index) {
            // 移除其他控制器的view
            [self.showingVc.view removeFromSuperview];
            self.showingVc = nil;
            return;
        }
        // 移除其他控制器的view
        [self.showingVc.view removeFromSuperview];
        
        // 添加控制器的view
        self.showingVc = self.childViewControllers[index];
        self.showingVc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:self.showingVc.view];
        
        // 动画
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionMoveIn;
        animation.subtype =  kCATransitionFromBottom;
        animation.duration = 0.3;
        [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewDeals:self.param];
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 250);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    // 添加选择类别控制器
    [self addChildViewController:[[DPChooseCategoryViewController alloc] init]];
    // 添加选择区域控制器
    DPChooseRegionViewController *cityVc = [[DPChooseRegionViewController alloc] init];
    cityVc.cityName = self.param.city;
    [self addChildViewController:cityVc];
    // 添加排序控制器
    [self addChildViewController:[[DPChooseSortController alloc]init]];
    // 添加筛选控制器
    [self addChildViewController:[[DPSiftController alloc] init]];
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

@end
