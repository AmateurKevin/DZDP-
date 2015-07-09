//
//  DPSort.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DPSortValue) {
    DPSortValueDefault = 1, // 默认排序
    DPSortValueLowPrice, // 价格最低
    DPSortValueHighPrice, // 价格最高
    DPSortValuePopular, // 人气最高
    DPSortValueLatest, // 最新发布
    DPSortValueOver, // 即将结束
    DPSortValueClosest // 离我最近
} ;

@interface DPSort : NSObject
@property (assign, nonatomic) int value;
@property (copy, nonatomic) NSString *label;
@end
