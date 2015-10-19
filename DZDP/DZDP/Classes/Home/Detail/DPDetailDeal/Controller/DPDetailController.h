//
//  DPDetailController.h
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPBaseTableViewController.h"

@class DPDeal;
@class DPShop;
@interface DPDetailController : DPBaseTableViewController
@property(nonatomic,strong) DPDeal *deal;
@property(nonatomic,strong) DPShop *shop;
@end
