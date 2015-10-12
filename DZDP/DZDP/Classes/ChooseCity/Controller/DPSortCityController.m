//
//  DPSortCityController.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPSortCityController.h"
#import "DPMetaDataTool.h"
#import "DPCityGroup.h"
#import "DPCity.h"
#import "DPDistrictAPI.h"
#import "DPSortCityHeaderController.h"
#import "DPCitySearchResultsController.h"

static NSString *const kCellIndentifier = @"city";

@interface DPSortCityController ()<DPSortCityHeaderControllerProxy,UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
@property(nonatomic,strong) NSArray *cities;

@property(nonatomic,strong) NSArray *cityGroups;

@property(nonatomic,strong) NSMutableArray *recentCities;
// 搜索控制器
@property (nonatomic, strong) UISearchController *searchController;

// 搜索结果控制器
@property (nonatomic, strong) DPCitySearchResultsController *resultsTableController;

- (IBAction)close:(id)sender;

@end

@implementation DPSortCityController

+ (instancetype)sortCityController{
    
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"DPSortCityController" bundle:nil];
    return [stroryBoard instantiateInitialViewController];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"sortcityHeader"]) {
        
        DPSortCityHeaderController *header = segue.destinationViewController;
        header.proxy = self;
    }
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSearchController];

}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cityGroups.count ;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        DPCityGroup *cityGroup = self.cityGroups[section];
        
        return cityGroup.cities.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier forIndexPath:indexPath];
    
    DPCityGroup *cityGroup = self.cityGroups[indexPath.section];
    DPCity *city = cityGroup.cities[indexPath.row];
    cell.textLabel.text = city.short_name;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    DPCityGroup *cityGroup = self.cityGroups[section];
    return cityGroup.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (DPCityGroup *cityGroup in self.cityGroups) {
        [muArray addObject:cityGroup.title];
    }
    return muArray;
}
#pragma mark --  UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DPCity *selectedCity = nil;
    
    if (tableView == self.tableView) {
        
        DPCityGroup *cityGroup = self.cityGroups[indexPath.section];
        selectedCity = cityGroup.cities[indexPath.row];
        
    }else{
        
        selectedCity = _resultsTableController.filteredCities[indexPath.row];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self selectAcity:selectedCity];
    
    
}

#pragma mark -- DPSortCityHeaderViewProxy

- (void)sortCityHeaderViewSelectCity:(DPCity *)city{
    [self selectAcity:city];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.cities mutableCopy];
    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"SELF.short_pinyin beginswith[cd] %@ OR SELF.short_name contains[cd] %@ OR SELF.city_name contains[cd] %@",searchText,searchText,searchText];
    
    searchResults = [[searchResults filteredArrayUsingPredicate:titlePredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
     DPCitySearchResultsController *tableController = (DPCitySearchResultsController *)self.searchController.searchResultsController;
    tableController.filteredCities = searchResults;
    [tableController.tableView reloadData];
}


#pragma mark -- private method
- (void)selectAcity:(DPCity *)city{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateRecentCityWith:city];
    
    NSArray *array = [MTLJSONAdapter JSONArrayFromModels:self.recentCities error:nil];
    
    [array writeToFile:DPRecentCityPlist atomically:NO];
    
    
    DPLog(@"%@",DPRecentCityPlist);
    NSString *cityName = city.short_name;
    NSNumber *cityID = city.city_id;
    
    if ([cityName isEqualToString:UserDefaulsCityName]) {
        // 与沙盒中存的城市名字一样，什么也不用做
        return;
    }else{
        // 下载这个城市的区域，并将其存入文件
        
        
        [[[DPDistrictAPI alloc] initWithCityID:cityID] startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            NSData *jsonData = [request.responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                 
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            
            [dic[@"districts"] writeToFile:DPDistricPlist atomically:YES];
            
        } failure:^(YTKBaseRequest *request) {
            
        }];
        
        // 将选择的城市存入偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:cityNameKEY];
        [[NSUserDefaults standardUserDefaults] setObject:cityID forKey:cityIDKEY];
        
        // 发出城市选择通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DPCityDidSelectNotification object:nil userInfo:@{DPSelectedCity:city}];
    }

}


- (void)updateRecentCityWith:(DPCity *)selectedCity{
    
    if (self.recentCities.count <= 0) {
        
        [self.recentCities addObject:selectedCity];
        
        return;
        
    }
    
    [self.recentCities enumerateObjectsUsingBlock:^(DPCity*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([selectedCity.city_id isEqualToNumber:obj.city_id]) {
            
            [self.recentCities exchangeObjectAtIndex:0 withObjectAtIndex:idx];
            *stop = YES;
            
        }else{
            
            [self.recentCities insertObject:selectedCity atIndex:0];
            
            if (self.recentCities.count > 3) {
                [self.recentCities removeLastObject];
                *stop = YES;
            }else{
                *stop = YES;
            }
        }
    }];
    
}

- (void)configureSearchController{
    
    _resultsTableController = [[DPCitySearchResultsController alloc] init]; 
    
    // Init UISearchController with the search results controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultsTableController];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.searchController.searchBar.placeholder = @"请输入城市中文名称或拼音";

    self.navigationItem.titleView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
  
    _resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.searchBar.delegate = self;
}

#pragma mark -- lazy load
- (NSArray *)cityGroups
{
    if (_cityGroups == nil) {
        _cityGroups = [DPMetaDataTool cityGroups];
    }
    return _cityGroups;
}

- (NSArray *)cities{
    if (_cities == nil) {
        _cities = [DPMetaDataTool cities];
    }
    return _cities;

}

- (NSMutableArray *)recentCities{
    
    if (!_recentCities) {
        
        _recentCities = [DPMetaDataTool recentCities];
        
    }
    return _recentCities;
    
}

@end
