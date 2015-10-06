//
//  DPCity.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCity.h"

@implementation DPCity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"short_name"              :@"short_name",
             @"city_pinyin"             :@"city_pinyin",
             @"city_name"               :@"city_name",
             @"short_pinyin"            :@"short_pinyin",
             @"city_id"                 :@"city_id"
             };
}

@end
