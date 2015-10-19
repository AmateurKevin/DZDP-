//
//  DPSearchResultsViewController.h
//  DZDP
//
//  Created by nickchen on 15/10/9.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPFindShopsParam.h"
#import "DPBaseViewController.h"
@interface DPSearchResultsViewController : DPBaseViewController

/// DPFindShopsParam商家参数
@property(nonatomic,strong) DPFindShopsParam *shopsParam;

@end
