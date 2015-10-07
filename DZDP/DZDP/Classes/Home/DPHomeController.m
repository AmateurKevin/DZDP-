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
#import "DPMetaDataTool.h"

@interface DPHomeController ()<UITableViewDataSource,UITableViewDelegate,HomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

/** 选中的状态 */
@property (nonatomic, strong) DPCity *selectedCity;

@property(nonatomic,strong) NSMutableArray *deals;

@property(nonatomic,strong) DPFindDealsParam *findDealsParam;

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
    
    // 初始化导航栏
    [self initNav];
 
    // 处理定位
    [self judgeLocateService];
    
    //
    [self initAttributes];
    
    // 获取header数据
    // 加载主页分类模型
    DPHomeHeaderView *headView = [DPHomeHeaderView homeHeaderView];
    headView.homeCategoryModels = [DPHomeCategoryModel HomeCategoryModelFromJsonFile];
    headView.delegate = self;
    self.tableview.tableHeaderView = headView;
    
    // 添加监听城市选择的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:DPCityDidSelectNotification object:nil];
    
}
#pragma mark -- NSNotificationCenter handler
- (void)citySelect:(NSNotification *)note
{
    self.selectedCity = note.userInfo[DPSelectedCity];
    [self.leftBtn setTitle:self.selectedCity.short_name forState:UIControlStateNormal];
    [self loadNewDeals];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- init

- (void)initNav{
    if (UserDefaulsCityName) {
        [self.leftBtn setTitle:UserDefaulsCityName forState:UIControlStateNormal];
    }else{
        [self.leftBtn setTitle:@"北京市" forState:UIControlStateNormal];
    }
}

- (void)initAttributes{
    
    _deals = [NSMutableArray array];
    _findDealsParam = [[DPFindDealsParam alloc] init];
    
}

//  处理定位
- (void)judgeLocateService{
    
    if ([INTULocationManager locationServicesState] == INTULocationServicesStateAvailable) {
        // 定位服务可用,定位城市
        
        [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:5.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            
            if (currentLocation) {
                
                NSString *location = [NSString stringWithFormat:@"%f,%f",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude];
                
                 [DPGeocoderTool getCityFromLocation:currentLocation andExecuteBlock:^(DPCity *city) {
                     
                     // 定位名称与当前使用城市不符合,弹出切换的提醒
                     if (![UserDefaulsCityName isEqualToString:city.city_name]) {
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             
                              [self popTipAlertWithcurrentCityName:city.city_name andlocation:location];
                         });
                        
                     }
                     
                 }];
                
            }
            
        }];
        
    }else{
        
        // 没开定位根据现有的城市直接刷新数据
        [self loadNewDeals];
        
    }
    
}

- (void)popTipAlertWithcurrentCityName:(NSString*)name andlocation:(NSString*)location{
    
     NSString *title = [NSString stringWithFormat:@"是否切换到当前定位到的城市%@",name];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
     UIAlertAction *changeAction = [UIAlertAction actionWithTitle:@"切换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
         DPCity *city = [DPMetaDataTool cityWithName:name];
         
         [[NSUserDefaults standardUserDefaults] setObject:name forKey:cityNameKEY];
         [[NSUserDefaults standardUserDefaults] setObject:city.city_id forKey:cityIDKEY];
         // 发出这个城市改变的通知的目的是让界面上其他用到城市的地方做出改变，比如左上角的按钮
         [[NSNotificationCenter defaultCenter] postNotificationName:DPCityDidSelectNotification object:nil userInfo:@{DPSelectedCity:city}];
         
         // 传入经纬度坐标
         _findDealsParam.location = location;
         [self loadNewDeals];

         
     }];
    
    [ac addAction:cancelAction];
    
    [ac addAction:changeAction];
    
    [self presentViewController:ac animated:YES completion:nil];

}



- (void)loadNewDeals{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    _findDealsParam.city_id = UserDefaultCityID;
    
    [[[DPDealAPI alloc] initWithDealParam:_findDealsParam] getDealsIfsuccess:^(NSArray *deals) {
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

@end
