//
//  DPMetaDataTool.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>
@class DPCity;
@interface DPMetaDataTool : NSObject

+ (NSArray *)categories;

+ (NSArray *)sorts;

+ (NSArray *)cityGroups;

+ (NSArray *)cities;

/// 热门城市
+ (NSArray *)hotCities;
/**
 *  @return 最近城市
 */
+ (NSMutableArray *)recentCities;

+ (NSArray *)searchRadius;

/// 更新最近城市
+ (void)updateRecentCityWith:(NSArray *)cityArray;

+ (DPCity *)cityWithID:(NSNumber *)city_id;

+ (DPCity *)cityWithName:(NSString *)name;

@end
