//
//  DPDealMainController.h
//  DZDP
//
//  Created by nickchen on 15/7/11.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DPFindDealsParam.h"
#import "DPFindShopsParam.h"

@interface DPDealMainController : UIViewController

/// DPFindDealsParam团购参数
//@property(nonatomic,strong) DPFindDealsParam *param;

/// DPFindShopsParam商家参数
@property(nonatomic,strong) DPFindShopsParam *shopsParam;

@end