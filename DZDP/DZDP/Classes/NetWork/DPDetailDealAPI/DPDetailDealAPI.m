//
//  DPDetailDealAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailDealAPI.h"
#import <SVProgressHUD.h>
@implementation DPDetailDealAPI{
    NSNumber *_deal_id;
}

- (id)initWithDealID:(NSNumber *)deal_id{
    self = [super init];
    if (self) {
        _deal_id = deal_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/dealdetail";
}

- (id)requestArgument {
    return @{
             @"deal_id": _deal_id
             };
}

+ (void)getDetailDealWithID:(NSNumber *)dealID success:(void(^)(DPDeal *deal))success failure:(void(^)(YTKBaseRequest *request))failure{
    
    [[[self alloc] initWithDealID:dealID] startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if ([request.responseJSONObject[@"errno"] isEqualToNumber:@(1005)]) {
            
            [SVProgressHUD showSuccessWithStatus:@"没有获取到数据" maskType:SVProgressHUDMaskTypeBlack];
            
        }

        if ([request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]){
            
            if (success) {
                DPDeal *deal = [MTLJSONAdapter modelOfClass:[DPDeal class] fromJSONDictionary:request.responseJSONObject[@"deal"] error:nil];
                success(deal);
            }

            
        }
            } failure:^(YTKBaseRequest *request) {
        
        if (![request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            if (failure) failure(request);
            
        }
        
    }];
}
@end
