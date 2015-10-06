//
//  DPFindShopsParam.h
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPFindShopsParam : NSObject
/// 城市ID
@property (nonatomic,copy) NSNumber *city_id;

/// 分类的i,，支持多个category合
@property (nonatomic,copy) NSString *cat_ids;

/// 二级分类的id,支持多个subcat
@property (nonatomic,copy) NSString *subcat_ids;

/// 行政区id， 支持多个，多个区
@property (nonatomic,copy) NSString *district_ids;

/// 商圈id, 支持多个查询， 多个商圈
@property (nonatomic,copy) NSString *bizarea_ids;

/// WGS84坐标;用户所在位置longitude
@property (nonatomic,copy) NSString *location;

/// 关键词，搜索商户名
@property (nonatomic,copy) NSString *keyword;

/// 基于location,搜索的半径范围，单位是米。 可选（若传入该参数，必须同时传入合法的经纬度坐标， radius字段默认半径3000米）
@property (nonatomic,assign) NSNumber *radius;

/// 页码，如不传入默认为1，即第一页
@property (nonatomic,assign) NSNumber *page;

/// 每页返回的团单结果条目数上限，最小值1，最大值50，如不传入默认为10
@property (nonatomic,assign) NSNumber *page_size;

/// 每页返回的团单结果条目数上限，最小值1，最大值50，如不传入默认为10
@property (nonatomic,assign) NSNumber *deals_per_shop;

@end
