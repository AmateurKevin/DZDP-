//
//  DPShop.m
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPShop.h"
#import "DPDeal.h"

@implementation DPShop

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"shop_id"             :@"shop_id",
             @"shop_name"           :@"shop_name",
             @"longitude"           :@"longitude",
             @"latitude"            :@"latitude",
             @"distance"            :@"distance",
             @"deal_num"            :@"deal_num",
             @"shop_url"            :@"shop_url",
             @"shop_murl"           :@"shop_murl",
             
             @"address"             :@"address",
             @"city_id"             :@"shop_murl",
             @"district_id"         :@"district_id",
             @"bizarea_id"          :@"bizarea_id",
             @"phone"               :@"phone",
             @"open_time"           :@"open_time",
             @"traffic_info"        :@"traffic_info",
          
             @"deals"               :@"deals"
             };
}

+ (NSValueTransformer *)dealsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DPDeal class]];
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    
    if ([key isEqualToString:@"shop_url"]  ||
        [key isEqualToString:@"shop_murl"] ) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    }
    
    return nil;
}

@end
