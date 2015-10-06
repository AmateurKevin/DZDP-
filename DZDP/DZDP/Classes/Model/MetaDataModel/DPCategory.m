//
//  DPCategory.m
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCategory.h"
#import "DPSubCategory.h"
@implementation DPCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cat_id"             :@"cat_id",
             @"cat_name"            :@"cat_name",
             @"subcategories"       :@"subcategories"
             };
}

+ (NSValueTransformer *)subcategoriesJSONTransformer{
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DPSubCategory class]];
}

@end
