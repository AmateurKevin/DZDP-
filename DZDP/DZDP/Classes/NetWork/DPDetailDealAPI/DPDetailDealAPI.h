//
//  DPDetailDealAPI.h
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseAPI.h"
#import "DPDeal.h"
@interface DPDetailDealAPI : DPBaseAPI

- (id)initWithDealID:(NSNumber *)deal_id;

- (void)getDetailDealIfsuccess:(void(^)(DPDeal *deal))success failure:(void (^)())failure;

@end
