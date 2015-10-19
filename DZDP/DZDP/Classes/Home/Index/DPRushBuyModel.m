//
//  DPRushBuyModel.m
//  DZDP
//
//  Created by nickchen on 15/10/15.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPRushBuyModel.h"

@implementation DPRushBuyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"deal_id":        @"deal_id",
             @"brand":          @"brand",
             @"market_price":   @"market_price",
             @"current_price":  @"current_price",
             @"na_logo":        @"na_logo"

             };
    
}

+ (NSValueTransformer *)na_logoUrlJSONTransformer{
    
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    
}


@end
