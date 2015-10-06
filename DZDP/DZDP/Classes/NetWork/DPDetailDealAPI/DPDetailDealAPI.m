//
//  DPDetailDealAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailDealAPI.h"

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
        if (success) {
            DPDeal *deal = [MTLJSONAdapter modelOfClass:[DPDeal class] fromJSONDictionary:request.responseJSONObject[@"deal"] error:nil];
            success(deal);
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}
@end
