//
//  DPDetailShopAPI.h
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseAPI.h"
@class DPShop;
@interface DPDetailShopAPI : DPBaseAPI

- (id)initWithShopID:(NSNumber *)shop_id;

+ (void)getDetailShopWithID:(NSNumber *)shopID success:(void(^)(DPShop * shop))success failure:(void(^)(YTKBaseRequest *request))failure;

@end
