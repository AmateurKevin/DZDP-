//
//  DPSort.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DPSortValue) {
    DPSortValueDefault = 0, // 综合排序
    DPSortValueLowPrice, // 价格最低
    DPSortValueHighPrice, // 价格最高
    DPSortValueHighDiscount,// 折扣高优先
    DPSortValueSales, // 销量优先
    DPSortValueClosest, // 离我最近
    DPSortValueLatest, // 最新发布
    DPSortValueScore, // 即将结束
  
} ;

@interface DPSort : MTLModel<MTLJSONSerializing>
@property (assign, nonatomic) NSNumber *value;
@property (copy, nonatomic) NSString *label;
@end
