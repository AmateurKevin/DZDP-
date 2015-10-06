//
//  DPDistrict.m
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDistrict.h"
#import "DPBiz_area.h"
@implementation DPDistrict

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"district_name"      :@"district_name",
             @"district_id"        :@"district_id",
             @"biz_areas"          :@"biz_areas"
             };
}

+ (NSValueTransformer *)biz_areasJSONTransformer{
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DPBiz_area class]];
}


@end
