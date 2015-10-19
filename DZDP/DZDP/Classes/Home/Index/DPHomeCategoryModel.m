//
//  DPHomeHeaderModel.m
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPHomeCategoryModel.h"

@implementation DPHomeCategoryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"cat_id"               :@"cat_id",
             @"subcat_id"            :@"subcat_id",
             @"iconUrl"              :@"iconUrl",
             @"name"                 :@"name"
             };
    
}

+ (NSValueTransformer *)iconUrlJSONTransformer{
    
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    
}

+ (NSArray *)HomeCategoryModelFromJsonFile{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homeCategory.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *jsonDict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:jsonDict[@"homepage"] error:nil];
    
}

@end
