//
//  DPDealAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDealAPI.h"
#import "DPDeal.h"
#import <SVProgressHUD.h>
@implementation DPDealAPI{
    NSNumber *_city_id;
    NSString *_cat_ids;
    NSString *_subcat_ids;
    NSString *_district_ids;
    // 商圈id, 支持多个查询， 多个商圈
    NSString *_bizarea_ids;
    // WGS84坐标;用户所在位置longitude
    NSString *_location;
    NSString *_keyword;
    NSNumber *_radius;
    NSNumber *_sort;
    NSNumber *_page;
    NSNumber *_page_size;
    NSNumber *_is_reservation_required;

}



- (id)initWithDealParam:(DPFindDealsParam *)param{
    self = [super init];
    if (self) {
        if (param.city_id == nil) {
            if (UserDefaulsCityName) {
                _city_id = UserDefaultCityID;
            }else{
                // 确保刚进入时候默认城市 北京
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
        _sort = param.sort ? param.sort : @(0);
        _page = param.page ? param.page : @(1);
        _page_size = param.page_size ? param.page_size :@(10);
        //_is_reservation_required = param.is_reservation_required ?param.is_reservation_required :@(0);
    }
    return self;

}

- (NSString *)requestUrl {
    return @"/searchdeals";
}

- (id)requestArgument {
    return @{
             @"city_id": _city_id,
             @"cat_ids":_cat_ids,
             @"subcat_ids":_subcat_ids,
             @"district_ids":_district_ids,
             @"bizarea_ids":_bizarea_ids,
             @"location":_location,
             @"keyword":_keyword,
             @"radius" :_radius,
             @"sort":_sort,
             @"page":_page,
             @"page_size":_page_size
             //@"is_reservation_required":_is_reservation_required
             };
}

- (void)getDealsIfsuccess:(void(^)(NSArray* deals))success failure:(void(^)(YTKBaseRequest *request))failure{
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        //DPLog(@"%@",request.responseString);
        // 没有错误信息才开始解析
        if ([request.responseJSONObject[@"errno"] isEqualToNumber:@(1005)]) {
            
            [SVProgressHUD showSuccessWithStatus:@"没有获取到数据" maskType:SVProgressHUDMaskTypeBlack];
            
        }
        
        
        if ([request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            if (success) {
                
                if (request.responseJSONObject[@"data"][@"deals"] != [NSNull null]) {
                  
                    NSArray *deals = [MTLJSONAdapter modelsOfClass:[DPDeal class] fromJSONArray:request.responseJSONObject[@"data"][@"deals"] error:nil];
                    
                    if (deals) {
                        
                        [SVProgressHUD dismiss];

                        success(deals);
                    }
                }

        }
    }
    } failure:^(YTKBaseRequest *request) {
        
        if (![request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            [SVProgressHUD showErrorWithStatus:@"网络不好,请检查网络设置"];

        }
        
        if(failure) failure(request);
        
    }];
}


@end
