//
//  DPDealTool.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPAPITool.h"
#import "DPFindDealsParam.h"
#import "DPFindDealsResult.h"
#import "DPGetSingleDealParam.h"
#import "DPGetSingleDealResult.h"
#import "DPGetNewDailyDealParam.h"
#import "DPGetNewDailyDealResult.h"
#import "DPGetBatchDealsParam.h"
@interface DPDealTool : NSObject

/**
 *  获得所有团购
 */
+ (void)getDealsWith:(DPFindDealsParam*)params success:(void(^)(DPFindDealsResult* result))success failure:(void(^)(NSError *error))failure;
/**
 *  获得单条详细团购
 */
+ (void)getSingleDealWith:(DPGetSingleDealParam *)params success: (void(^)(DPGetSingleDealResult *result))success failure:(void(^)(NSError *error))failure;

/**B
 *  每日新增团购id
 */

+ (void)getDailyNewDealWith:(DPGetNewDailyDealParam *)params success:(void(^)(DPGetNewDailyDealResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  每日新增团购
 */
+ (void)getBatchDealsWith:(DPGetNewDailyDealParam *)params success:(void(^)(DPFindDealsResult *result))success failure:(void(^)(NSError *error))failure;


@end
