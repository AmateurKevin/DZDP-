//
//  DPDealController.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDealController.h"
#import "DPDealCell.h"
#import "DPDealTool.h"
#import "DPGetNewDailyDealParam.h"
#import "DPDealHeaderView.h"
#import "DPSortCityController.h"
#import "DPCity.h"
#import "DPRegion.h"
#import "DPCategory.h"
#import "DPButtonItem.h"
#import "DPCategoryMenuController.h"
#import "DPAllDealViewController.h"

@interface DPDealController ()<UITableViewDataSource,UITableViewDelegate,DealHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarItem;

@property(nonatomic,strong) NSArray *ButtonItems;

/** 选中的状态 */
@property (nonatomic, strong) DPCity *selectedCity;
/** 当前选中的区域 */
@property (strong, nonatomic) DPRegion *selectedRegion;

/** 当前选中的分类 */
@property (strong, nonatomic) DPCategory *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;

@property(nonatomic,strong) NSMutableArray *deals;
- (IBAction)sortCityClicked:(id)sender;

@end

@implementation DPDealController

- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (IBAction)sortCityClicked:(id)sender {
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"ChooseCity" bundle:nil];
    DPSortCityController *sortCityVc = [stroryBoard instantiateInitialViewController];
    [self presentViewController:sortCityVc animated:YES completion:nil];

}

- (NSArray *)ButtonItems
{
    
    DPButtonItem *item0 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"美食",
                                                        @"category":@"美食"
                                                         }];
    
    DPButtonItem *item1 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"电影",
                                                        @"category":@"院线影院"
                                                         }];
    
    DPButtonItem *item2 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"酒店",
                                                        @"category":@"酒店"
                                                         }];
    
    DPButtonItem *item3 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"KTV",
                                                        @"category":@"KTV"
                                                         }];
    DPButtonItem *item4 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"足疗",
                                                        @"category":@"足疗按摩"}];
    DPButtonItem *item5 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"丽人",
                                                        @"category":@"丽人"
                                                         }];
    DPButtonItem *item6 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"购物",
                                                        @"category":@"购物"
                                                         }];
    DPButtonItem *item7 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"粤菜",
                                              @"category":@"粤菜"
                                                         }];
    DPButtonItem *item8 = [DPButtonItem buttonItemWith:@{
                                                         @"title":@"全部",
                                                        @"category":@""
                                                         }];
    return @[item0,item1,item2,item3,item4,item5,item6,item7,item8];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DPDealHeaderView *headView = [DPDealHeaderView DealHeaderViewWith:self.ButtonItems];
    headView.delegate = self;
    self.tableview.tableHeaderView = headView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:DPCityDidSelectNotification object:nil];
}

- (void)citySelect:(NSNotification *)note
{
    self.selectedCity = note.userInfo[DPSelectedCity];
    self.leftBarItem.title = self.selectedCity.name;
    
    [self loadNewDeals];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadNewDeals{
    DPGetNewDailyDealParam  *params = [[DPGetNewDailyDealParam alloc] init];
    params.city = self.selectedCity.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    params.date = [dateFormatter stringFromDate:[NSDate date]];
    
    [DPDealTool getBatchDealsWith:params success:^(DPFindDealsResult *result) {
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)dealHeaderView:(DPDealHeaderView *)dealHeaderView buttonClicked:(UIButton *)button
{
    if (button.tag == 8) {
        DPCategoryMenuController *vc = [[DPCategoryMenuController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"DPAllDealViewController" bundle:nil];
        DPAllDealViewController *allVc = [stroryBoard instantiateInitialViewController];
        allVc.param.city = self.selectedCity.name;
        DPButtonItem *buttonItem = self.ButtonItems[button.tag];
        allVc.param.category = buttonItem.category;
        [self.navigationController pushViewController:allVc animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DPDealCell *cell = [DPDealCell cellWithTableView:tableView];
    
    cell.deal = self.deals[indexPath.row];
    
    return cell;
}



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
