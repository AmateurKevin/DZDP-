//
//  DPDetailPriceCell.h
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailBaseCell.h"
@class DPDeal;
@interface DPDetailPriceCell :DPDetailBaseCell
@property(nonatomic,strong) DPDeal *deal;
+ (instancetype)detailPriceCell;
@end
