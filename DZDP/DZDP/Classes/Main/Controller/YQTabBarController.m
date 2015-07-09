//
//  YQTabBarController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "YQTabBarController.h"

@interface YQTabBarController ()

@end

@implementation YQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dictionary = @{}.mutableCopy;
    dictionary[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBar *tabbar = self.tabBar;
    UITabBarItem *tabBarItem0 = [tabbar.items objectAtIndex:0];
    tabBarItem0.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_dianping_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem0 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem1 = [tabbar.items objectAtIndex:1];
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_group_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem1 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem2 = [tabbar.items objectAtIndex:2];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_found_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem2 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem3 = [tabbar.items objectAtIndex:3];
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_my_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem3 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
