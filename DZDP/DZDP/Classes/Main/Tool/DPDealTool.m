//
//  DPDealTool.m
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDealTool.h"

@implementation DPDealTool

+ (void)getDealsWith:(DPFindDealsParam*)params success:(void(^)(DPFindDealsResult* result))success failure:(void(^)(NSError *error))failure
{
    [[DPAPITool sharedAPITool] request:@"v1/deal/find_deals" params:params.keyValues success:^(id json) {
        if (success) {
            DPFindDealsResult *obj = [DPFindDealsResult objectWithKeyValues:json];
            success(obj);
        }
    } failure:failure];
}

+ (void)getSingleDealWith:(DPGetSingleDealParam *)params success: (void(^)(DPGetSingleDealResult *result))success failure:(void(^)(NSError *error))failure
{
    [[DPAPITool sharedAPITool] request:@"v1/deal/get_single_deal" params:params.keyValues success:^(id json) {
        if (success) {
            DPGetSingleDealResult *obj = [DPGetSingleDealResult objectWithKeyValues:json];
            success(obj);
        }
    } failure:failure];
}

// v1/deal/get_daily_new_id_list
+ (void)getDailyNewDealWith:(DPGetNewDailyDealParam *)params success:(void(^)(DPGetNewDailyDealResult *result))success failure:(void(^)(NSError *error))failure
{
    [[DPAPITool sharedAPITool] request:@"v1/deal/get_daily_new_id_list" params:params.keyValues success:^(id json) {
        if (success) {
            DPGetNewDailyDealResult *obj = [DPGetNewDailyDealResult objectWithKeyValues:json];
            success(obj);
        }
    } failure:failure];
}

+ (void)getBatchDealsWith:(DPGetNewDailyDealParam *)params success:(void(^)(DPFindDealsResult *result))success failure:(void(^)(NSError *error))failure
{
    
    [[DPAPITool sharedAPITool] request:@"v1/deal/get_daily_new_id_list" params:params.keyValues success:^(id json) {
        
            DPGetNewDailyDealResult *idListResult = [DPGetNewDailyDealResult objectWithKeyValues:json];
            
            if (idListResult.id_list.count < 1) {
                return ;
            }
        
            DPGetBatchDealsParam *batchParams = [[DPGetBatchDealsParam alloc] init];
            if (idListResult.id_list.count >= 1) {
                NSString *string = idListResult.id_list[0];
                for (int i = 1; i < 10; i++) {
                    string = [string stringByAppendingFormat:@",%@",idListResult.id_list[i]];
                }
            batchParams.deal_ids = string;
            [[DPAPITool sharedAPITool] request:@"v1/deal/get_batch_deals_by_id" params:batchParams.keyValues success:^(id json) {
                if (success) {
                    DPFindDealsResult *obj = [DPFindDealsResult objectWithKeyValues:json];
                    success(obj);
                }
            } failure:failure];
        }
    } failure:failure];
}

@end
