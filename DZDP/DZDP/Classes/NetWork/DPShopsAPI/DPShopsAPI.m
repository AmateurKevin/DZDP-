//
//  DPShopsAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPShopsAPI.h"
#import "DPFindShopsParam.h"
#import "DPShop.h"
#import <SVProgressHUD.h>
@implementation DPShopsAPI{
    // 城市ID
    NSNumber *_city_id;
    // 分类的i,，支持多个category合
    NSString *_cat_ids;
    // 二级分类的id,支持多个subcat
    NSString *_subcat_ids;
    // 行政区id， 支持多个，多个区
    NSString *_district_ids;
    // 商圈id, 支持多个查询， 多个商圈
    NSString *_bizarea_ids;
    // WGS84坐标;用户所在位置longitude
    NSString *_location;
    // 关键词，搜索商户名
    NSString *_keyword;
    // 基于location,搜索的半径范围，单位是米。 可选（若传入该参数，必须同时传入合法的经纬度坐标， radius字段默认半径3000米）
    NSNumber *_radius;
    // 页码，如不传入默认为1，即第一页
    NSNumber *_page;
    // 每页返回的团单结果条目数上限，最小值1，最大值50，如不传入默认为10
    NSNumber *_page_size;
    // 每页返回的团单结果条目数上限，最小值1，最大值50，如不传入默认为10
    NSNumber *_deals_per_shop;

}

- (NSString *)requestUrl {
    return @"/searchshops";
}

- (id)requestArgument {
    return @{
             @"city_id"                 : _city_id,
             @"cat_ids"                 :_cat_ids,
             @"subcat_ids"              :_subcat_ids,
             @"district_ids"            :_district_ids,
             @"bizarea_ids"             :_bizarea_ids,
             @"location"                :_location,
             @"keyword"                 :_keyword,
             @"radius"                  :_radius,
             
             @"page"                    :_page,
             @"_page_size"              :_page_size,
             @"deals_per_shop"          :_deals_per_shop
             };
}

- (id)initWithShopsParam:(DPFindShopsParam *)param{
    self = [super init];
    if (self) {
        if (param.city_id == nil) {
            if (UserDefaulsCityName) {
                _city_id = UserDefaultCityID;
            }else{
                // 确保刚进入时候默认城市
                _city_id = @(100010000);
            }
            
        }else {
            _city_id = param.city_id;
        }
        
        _subcat_ids = param.subcat_ids ? param.subcat_ids : @"";
        _cat_ids = param.cat_ids ? param.cat_ids : @"";
        _district_ids = param.district_ids ? param.district_ids : @"";
        _bizarea_ids = param.bizarea_ids ? param.bizarea_ids : @"";
        _location = param.location ? param.location : @"";
        _keyword = param.keyword ? param.keyword : @"";
        _radius = param.radius ? param.radius : @(3000);
        
        _page = param.page ? param.page : @(1);
        _page_size = param.page_size ? param.page_size :@(10);
        _deals_per_shop = param.deals_per_shop ? param.page_size : @(10);
    }
    return self;
}



- (void)getShopsIfsuccess:(void(^)(NSArray* shops))success failure:(void (^)())failure{
   
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DPLog(@"%@",request.responseString);
        // 没有错误信息才开始解析 ,0代表成功
        
        // 没有错误信息才开始解析
        if ([request.responseJSONObject[@"errno"] isEqualToNumber:@(1005)]) {
            
            [SVProgressHUD showSuccessWithStatus:@"没有更多的数据了" maskType:SVProgressHUDMaskTypeBlack];
            if (failure)  failure();
            
        }
        
        if ([request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            if (success) {
                
                if (request.responseJSONObject[@"data"][@"shops"] != [NSNull null]) {
                     DPLog(@"%@",request.responseJSONObject[@"data"][@"shops"]);
                    NSArray *shops = [MTLJSONAdapter modelsOfClass:[DPShop class] fromJSONArray:request.responseJSONObject[@"data"][@"shops"] error:nil];
                    
                    if (shops) {
                        success(shops);
                    }
                }
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        if (![request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            [SVProgressHUD showErrorWithStatus:@"网络不好,请检查网络设置"];
            
        }
        
        if (failure) failure();
       
        
    }];

}

@end
