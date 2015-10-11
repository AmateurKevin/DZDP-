//
//  YQTabBarController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "YQTabBarController.h"
#import "DPVoiceSearchController.h"
#import "DPSearchResultsViewController.h"
#import "DPSearchResultsViewController.h"
#import "DPNavSearchController.h"

@interface YQTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate,DPVoiceSearchControllerDeletage,DPNavSearchControllerDelegate,DPNavSearchControllerDelegate>

@property(nonatomic,strong) UINavigationController *navController;


@end

@implementation YQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self initTabbar];
    
    _navController = self.viewControllers.firstObject;
    
    // 成为语音控制器的代理
    [DPVoiceSearchController sharedInstance].delegate = self;
    
    //  导航栏搜索控制器代理
    [DPNavSearchController sharedInstance].proxy = self;
    
}

#pragma mark -- initTabbar
- (void)initTabbar{

    NSMutableDictionary *dictionary = @{}.mutableCopy;
    dictionary[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBar *tabbar = self.tabBar;
    UITabBarItem *tabBarItem0 = [tabbar.items objectAtIndex:0];
    tabBarItem0.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_dianping_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem0 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem1 = [tabbar.items objectAtIndex:1];
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_found_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem1 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem2 = [tabbar.items objectAtIndex:2];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_found_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem2 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItem3 = [tabbar.items objectAtIndex:3];
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"home_footbar_icon_my_pressed"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem3 setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    self.delegate = self;

    
}

#pragma mark -- UITabBarControllerDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // 让系统原有的中间控制器失效，显示modal出的控制器
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]){
        
        DPVoiceSearchController *voiceSearchVc = [DPVoiceSearchController sharedInstance];
        
        [viewController presentViewController:voiceSearchVc animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (viewController == [tabBarController.viewControllers objectAtIndex:2])return;
    
    if (viewController)
        _navController = viewController;
}


#pragma mark -- DPVoiceSearchControllerDeletage

- (void)voiceSearchControllerGetResult:(NSString *)result{
    
    DPSearchResultsViewController *vc =[[DPSearchResultsViewController alloc] init];
    vc.shopsParam.keyword = result;
    vc.hidesBottomBarWhenPushed = YES;
    [_navController pushViewController:vc animated:YES];
    
}

#pragma mark -- DPNavSearchControllerDelegate
- (void)navSearchControllerGetkeyword:(NSString *)keyword{

    DPSearchResultsViewController *vc = [[DPSearchResultsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.shopsParam.keyword = keyword;
    
    [_navController pushViewController:vc animated:YES];

}



@end
