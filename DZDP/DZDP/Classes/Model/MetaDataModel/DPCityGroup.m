//
//  DPCityGroup.m
//  searchBarTest
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCityGroup.h"
#import "DPCity.h"
@implementation DPCityGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title"             :@"title",
             @"cities"            :@"cities"
             };
}

+ (NSValueTransformer *)citiesJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DPCity class]];
}

@end
