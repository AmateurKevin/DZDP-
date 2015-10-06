//
//  DPDeal.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDeal.h"
#import "DPShop.h"
@implementation DPDeal
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"deal_id"             :@"deal_id",
             @"city_ids"            :@"city_ids",
             @"title"               :@"title",
             @"min_title"           :@"min_title",
             @"desc"         :@"description",
             @"long_title"          :@"long_title",
             @"cat_id"              :@"cat_id",
             @"subcat_ids"          :@"subcat_ids",
             @"publish_time"        :@"publish_time",
             @"purchase_deadline"   :@"purchase_deadline",
             @"coupon_start_time"   :@"coupon_start_time",
             @"coupon_end_time"     :@"coupon_end_time",
             @"market_price"        :@"market_price",
             @"current_price"       :@"current_price",
             @"promotion_price"     :@"promotion_price",
             @"sale_num"            : @"sale_num",
             @"is_reservation_required":@"is_reservation_required",
             @"image"               :@"image",
             @"mid_image"           :@"mid_image",
             @"tiny_image"          :@"tiny_image",
             @"deal_url"            :@"deal_url",
             @"deal_murl"           :@"deal_murl",
             @"buy_contents"        :@"buy_contents",
             @"consumer_tips"       :@"consumer_tips",
             @"buy_details"         :@"buy_details",
             @"shop_description"    :@"shop_description",
             @"shop_ids"            :@"shop_ids",
             @"update_time"         :@"update_time",
             @"shops"               :@"shops",
             @"distance"            :@"distance",
             @"shop_num"            :@"shop_num",
             @"score"               :@"score",
             @"comment_num"         :@"comment_num"
             };
}

//+ (NSValueTransformer *)city_idsJSONTransformer
//{
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[NSNumber class]];
//}
//+ (NSValueTransformer *)subcat_idsJSONTransformer
//{
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[NSNumber class]];
//}
//+ (NSValueTransformer *)shop_idsJSONTransformer
//{
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[NSNumber class]];
//}

+ (NSValueTransformer *)shopsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DPShop class]];
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"update_time"] ||
        [key isEqualToString:@"publish_time"]||
        [key isEqualToString:@"purchase_deadline"]||
        [key isEqualToString:@"coupon_start_time"]||
        [key isEqualToString:@"coupon_end_time"]
        ) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
            //return [[self dateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:value.integerValue]];
            return [NSDate dateWithTimeIntervalSince1970:value.integerValue];
        }];
    }
    
    if ([key isEqualToString:@"deal_url"]  ||
        [key isEqualToString:@"deal_murl"] ||
        [key isEqualToString:@"image"]     ||
        [key isEqualToString:@"mid_image"] ||
        [key isEqualToString:@"tiny_image"]) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    }
    
    return nil;
}

//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
//    self = [super initWithDictionary:dictionaryValue error:error];
//    if (self == nil) return nil;
//    return self;
//}

@end
