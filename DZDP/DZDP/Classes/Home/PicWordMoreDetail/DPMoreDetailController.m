//
//  DPMoreDetailController.m
//  DZDP
//
//  Created by nickchen on 15/7/8.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPMoreDetailController.h"
#import "DPDeal.h"
#import "DPBuyDetailCell.h"
#import "UILabel+Html.h"
@interface DPMoreDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview1;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, assign)CGFloat height;

@end

@implementation DPMoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webview1 loadHTMLString:_detailDeal.buy_details baseURL:nil];
    [self.webView2 loadHTMLString:_detailDeal.shop_description baseURL:nil];
 
}









@end
