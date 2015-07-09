//
//  DPMoreDetailController.m
//  DZDP
//
//  Created by nickchen on 15/7/8.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPMoreDetailController.h"
#import "DPDeal.h"
@interface DPMoreDetailController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DPMoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
}


@end
