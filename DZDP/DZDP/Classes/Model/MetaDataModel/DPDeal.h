//
//  DPDeal.h
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//


@interface DPDeal : MTLModel <MTLJSONSerializing>

/// 商品id
@property (nonatomic, assign,readonly) NSNumber *deal_id;

/// 商品所在全部城市id
@property (nonatomic, strong,readonly) NSArray *city_ids;

/// 商品标题
@property (nonatomic, copy,readonly) NSString *title;

// 商品wap标题
@property (nonatomic, copy,readonly) NSString *min_title;

/// 商品描述
@property (nonatomic, copy) NSString *desc;

/// 长标题
@property (nonatomic, copy) NSString *long_title;

/// 一级分类的id
@property (nonatomic, assign,readonly) NSNumber *cat_id;

/// 二级分类的id列表，一个商品可能属于多个二级分类	list
@property (nonatomic, strong,readonly) NSArray *subcat_ids;

/// 商品发布时间
@property (nonatomic, assign) NSDate *publish_time;

/// 商品购买的截止时间
@property (nonatomic, assign) NSDate *purchase_deadline;

/// 券有效开始时间
@property (nonatomic, assign) NSDate *coupon_start_time;

/// 券有效截止时间
@property (nonatomic, assign) NSDate *coupon_end_time;

/// 商品原价，单位是分
@property (nonatomic, assign) NSNumber *market_price;

/// 团购价，单位是分
@property (nonatomic, assign) NSNumber *current_price;

/// 商品购买数量
@property (nonatomic, assign) NSNumber *sale_num;

/// 是否要求预约
@property (nonatomic, assign) BOOL is_reservation_required;

/// 商品小图
@property (nonatomic, copy,readonly) NSURL *tiny_image;

/// 商品中图
@property (nonatomic, copy,readonly) NSURL *mid_image;

/// 商品大图
@property (nonatomic, copy,readonly) NSURL *image;

/// pc的落地页
@property (nonatomic, copy,readonly) NSURL *deal_url;

/// wap的落地页
@property (nonatomic, copy,readonly) NSURL *deal_murl;

/// 购买内容
@property (nonatomic, copy) NSString *buy_contents;

/// 消费提示
@property (nonatomic, copy) NSString *consumer_tips;

/// 购买详情
@property (nonatomic, copy) NSString *buy_details;

/// 商户环境
@property (nonatomic, copy) NSString *shop_description;

#pragma mark -- 数组中是基本类型,不需要告诉Mantle怎么转换
/// 商户列表
@property (nonatomic, strong,readonly) NSArray *shop_ids;

/// 更新时间
@property (nonatomic, assign,readonly) NSDate *update_time;

///
@property(nonatomic,strong) NSArray *shops;

#warning -- 通过团单详情请求回来此字段是个数组，通过其他途径请求回来是个Number类型
/// 团单的促销价格，如果没有促销，价格是当前的团购价格，单位分
@property (nonatomic,copy) NSNumber *promotion_price;

///
@property (nonatomic,copy) NSNumber *shop_num;

/// 当前距离与商户之间的距离，没有传递longitude，latitude字段会                                           返回-1
@property (nonatomic,copy) NSNumber *distance;

/// 评论数
@property (nonatomic,copy) NSNumber *comment_num;

/// 用户评分
@property (nonatomic,copy) NSNumber *score;



@end
