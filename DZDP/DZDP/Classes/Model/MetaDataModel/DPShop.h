//
//  DPShop.h
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPShop : MTLModel <MTLJSONSerializing>

/// 商户地址
@property (nonatomic,copy) NSString *address;

/// 城市id
@property (nonatomic,copy) NSNumber *city_id;

/// 行政区id
@property (nonatomic,copy) NSNumber *district_id;

/// 商圈id
@property (nonatomic,copy) NSNumber *bizarea_id;

/// 商户电话
@property (nonatomic,copy) NSString *phone;

/// 营业时间
@property (nonatomic,copy) NSString *open_time;

/// 交通信息
@property (nonatomic,copy) NSString* traffic_info;

/// 商户id
@property (nonatomic,copy) NSNumber *shop_id;

/// 商户名称
@property (nonatomic,copy) NSString* shop_name;

/// 经度
@property (nonatomic,copy) NSNumber *longitude;

/// 纬度
@property (nonatomic,copy) NSNumber *latitude;

/// 当前距离与商户之间的距离，没有传递longitude，latitude字段会                                           返回-1
@property (nonatomic,copy) NSNumber *distance;

///
@property (nonatomic,copy) NSNumber *deal_num;

/// 商户PC的url
@property(nonatomic,strong) NSURL *shop_url;

/// 商户移动端url
@property(nonatomic,strong) NSURL *shop_murl;

///
@property(nonatomic,strong) NSArray *deals;

@end
