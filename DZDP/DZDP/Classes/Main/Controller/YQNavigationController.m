//
//  YQNavigationController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "YQNavigationController.h"

@interface YQNavigationController ()

@end

@implementation YQNavigationController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
