//
//  DPRushModel.m
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPRushModel.h"
#import "DPDealAPI.h"
#import "DPFindDealsParam.h"
@implementation DPRushModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"iconUrl"              :@"iconUrl",
             @"name"                 :@"name"
             };
    
}
+ (NSValueTransformer *)iconUrlJSONTransformer{
    
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    
}



@end
