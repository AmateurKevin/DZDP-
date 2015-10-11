//
//  DPDetailShopAPI.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailShopAPI.h"
#import "DPShop.h"
@implementation DPDetailShopAPI
{
    NSNumber *_shop_id;
}

- (id)initWithShopID:(NSNumber *)shop_id{
    self = [super init];
    if (self) {
        _shop_id = shop_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/shopinfo";
}

- (id)requestArgument {
    return @{
             @"shop_id": _shop_id
             };
}

+ (void)getDetailShopWithID:(NSNumber *)shopID success:(void(^)(DPShop * shop))success failure:(void(^)(YTKBaseRequest *request))failure{
    [[[self alloc] initWithShopID:shopID] startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if (success) {
            DPShop *shop = [MTLJSONAdapter modelOfClass:[DPShop class] fromJSONDictionary:request.responseJSONObject[@"shop"] error:nil];
            success(shop);
        }
    } failure:^(YTKBaseRequest *request) {
        
        if (![request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            if (failure) failure(request);
            
        }

        
    }];
}

@end
