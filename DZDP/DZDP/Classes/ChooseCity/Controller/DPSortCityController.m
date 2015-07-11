//
//  DPSortCityController.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPSortCityController.h"
#import "DPCityGroup.h"
#import "DPMetaDataTool.h"
@interface DPSortCityController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *cityGroups;

- (IBAction)close:(id)sender;

@end

@implementation DPSortCityController

-(NSArray *)cityGroups
{
    if (_cityGroups == nil) {
        _cityGroups = [DPMetaDataTool cityGroups];
    }
    return _cityGroups;
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DPCityGroup *cityGroup = self.cityGroups[section];
    
    return cityGroup.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"city" forIndexPath:indexPath];
    DPCityGroup *cityGroup = self.cityGroups[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
    DPCityGroup *cityGroup = self.cityGroups[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    DPCity *city = [DPMetaDataTool cityWithName:cityName];
    
    if ([cityName isEqualToString:UserDefaulsCityName]) {
        // 与沙盒中存的城市名字一样，什么也不用做
        return;
    }else{
        // 将选择的城市存入偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:cityNameKEY];
        
        // 发出城市选择通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DPCityDidSelectNotification object:nil userInfo:@{DPSelectedCity:city}];
    }
    
}

@end
