//
//  DPBaseNavigationController.m
//  DZDP
//
//  Created by nickchen on 15/10/18.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseNavigationController.h"

@interface DPBaseNavigationController ()

@end

@implementation DPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:78/255.0 blue:30/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

@end
