//
//  DPMoreDetailController.h
//  DZDP
//
//  Created by nickchen on 15/7/8.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDeal;
@interface DPPicWordController : UIViewController

+ (instancetype)picWordController;

@property(nonatomic,strong) DPDeal *detailDeal;

@end
