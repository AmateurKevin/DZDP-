//
//  DPBaseTabBarController.m
//  DZDP
//
//  Created by nickchen on 15/10/18.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseTabBarController.h"
#import "DPVoiceSearchController.h"
#import "DPSearchResultsViewController.h"
#import "DPSearchResultsViewController.h"
#import "DPNavSearchController.h"

@interface DPBaseTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate,DPVoiceSearchControllerDeletage,DPNavSearchControllerDelegate,DPNavSearchControllerDelegate>

@property(nonatomic,strong) UINavigationController *navController;

@end

@implementation DPBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self initTabbar];
    
    //当前的navController
    _navController = self.viewControllers.firstObject;
    
    // 成为语音控制器的代理
    [DPVoiceSearchController sharedInstance].delegate = self;
    
    //  导航栏搜索控制器代理
    [DPNavSearchController sharedInstance].proxy = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- initTabbar
- (void)initTabbar{
    
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }

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
    [_navController pushViewController:vc animated:YES];
    
}

#pragma mark -- DPNavSearchControllerDelegate
- (void)navSearchControllerGetkeyword:(NSString *)keyword{
    
    DPSearchResultsViewController *vc = [[DPSearchResultsViewController alloc] init];
    
    vc.shopsParam.keyword = keyword;
    
    [_navController pushViewController:vc animated:YES];
    
}


#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
