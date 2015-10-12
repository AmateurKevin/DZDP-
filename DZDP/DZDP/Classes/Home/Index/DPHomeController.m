//
//  DPHomeController.m
//  DZDP
//
//  Created by nickchen on 15/10/11.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPHomeController.h"
#import "DPFindDealsParam.h"
#import "DPDealAPI.h"
#import "DPRushBuyCell.h"
#import "DPMetaDataTool.h"
#import "DPSortCityController.h"
#import "DPQRCodeController.h"
#import "DPDealCell.h"
#import "DPDetailController.h"
static NSString * const kRushBuyIdentifier = @"rushBuyCell";

@interface DPHomeController ()

/** 选中的城市 */
@property (nonatomic, strong) DPCity *selectedCity;

/** 抢购模型 */
@property(nonatomic,strong) NSArray *rushDeals;

// 猜你喜欢deals
@property(nonatomic,strong) NSMutableArray *deals;

@property(nonatomic,strong) DPFindDealsParam *findDealsParam;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@end

@implementation DPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航栏
    [self initNav];
    
    // 抢购cell
    [self initRushBuyCell];

    //
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    [self initAttributes];
    
    // 处理定位
    [self judgeLocateService];
    
    // 添加监听城市选择的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:DPCityDidSelectNotification object:nil];
    
    [self shouldPullDownRefresh:YES];
    [self shouldPullUpRefresh:YES];
    
}

// 弹出城市选择控制器
- (IBAction)sortCityClicked:(id)sender {
    
    DPSortCityController *sortCityVc = [DPSortCityController sortCityController];
    [self presentViewController:sortCityVc animated:YES completion:nil];
}

- (IBAction)QRCodeBtnClicked:(id)sender {
    
    DPQRCodeController *vc = [DPQRCodeController QRCodeController];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark -- NSNotificationCenter handler
- (void)citySelect:(NSNotification *)note
{
    self.selectedCity = note.userInfo[DPSelectedCity];
    [self.cityBtn setTitle:self.selectedCity.short_name forState:UIControlStateNormal];
    [self loadNewDeals];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- init

- (void)initNav{
    if (UserDefaulsCityName) {
        [self.cityBtn setTitle:UserDefaulsCityName forState:UIControlStateNormal];
    }else{
        [self.cityBtn setTitle:@"北京市" forState:UIControlStateNormal];
    }
    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.placeholder = @"搜索商家或地点";
//    self.searchBar = searchBar;
//    searchBar.delegate = self;
//    self.navigationItem.titleView = searchBar;
    
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
                    
                    // 定位名称与当前使用城市不符合,弹出切换城市的提醒
                    if (![UserDefaulsCityName isEqualToString:city.city_name]) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self popTipAlertWithcurrentCityName:city.city_name andlocation:location];
                        });
                        
                    }
                    
                }];
                
            }
            
        }];
        
    }
    
    // 没开定位或者开了定位但城市一致都需要根据现有的城市直接刷新数据
    [self loadNewDeals];
    
}


- (void)initRushBuyCell{

    DPFindDealsParam *param = [[DPFindDealsParam alloc] init];
    param.city_id = @(1800080000);
    param.cat_ids = (@326).description;
    param.page_size = @3;
    [[[DPDealAPI alloc] initWithDealParam:param] getDealsIfsuccess:^(NSArray *deals) {
        
        _rushDeals = deals;
        
        [self.tableView reloadData];
        
    } failure:nil];
    
}

- (void)loadNewDeals{
 
    _findDealsParam.city_id = UserDefaultCityID;
    
    // 当前城市与定位城市一致再传入坐标值,否则不传
    if ([UserDefaulsCityName isEqualToString:UserDefaultlocationCityName]) {
        if (LocationCoordinate) {
            _findDealsParam.location = LocationCoordinate;
        }
    }
    
    
    [[[DPDealAPI alloc] initWithDealParam:_findDealsParam] getDealsIfsuccess:^(NSArray *deals) {
        
        
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:deals];
        [self.tableView reloadData];
        
    } failure:nil];
    
}

- (void)loadMoreData{
    
    [self loadMoreDeals];
    
}

- (void)loadMoreDeals{
        
        _findDealsParam.page = @(_findDealsParam.page.integerValue + 1);
        
        [[[DPDealAPI alloc] initWithDealParam:_findDealsParam] getDealsIfsuccess:^(NSArray *deals) {
            
            [self.deals addObjectsFromArray:deals];
            [self endFooterRefreshing];
            [self.tableView reloadData];
        } failure:^(YTKBaseRequest *request) {
            [self endFooterRefreshing];
        }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    
    return self.deals.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DPRushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:kRushBuyIdentifier];
        
        cell.rushModels = _rushDeals;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        DPDealCell *cell = [DPDealCell cellWithTableView:tableView];
        cell.deal = self.deals[indexPath.row];
        return cell;
    }
   
    return nil;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DPDetailController *detailVc = [[DPDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    detailVc.deal = self.deals[indexPath.row];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 100;
    }
    else{
        return 100;
    }

}

#pragma mark -- private method
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
        
        // 把坐标存起来
        [[NSUserDefaults standardUserDefaults] setObject:location forKey:LocationCoordinateKey];
        
        [self loadNewDeals];
        
        
    }];
    
    [ac addAction:cancelAction];
    
    [ac addAction:changeAction];
    
    [self presentViewController:ac animated:YES completion:nil];
    
}

@end
