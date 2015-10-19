//
//  DPDealAPI.h
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseAPI.h"
#import "DPFindDealsParam.h"

@class DPDeal;
@interface DPDealAPI : DPBaseAPI

- (id)initWithDealParam:(DPFindDealsParam *)param;

- (void)getDealsIfsuccess:(void (^)(NSArray *))success failure:(void (^)())failure;

@end
