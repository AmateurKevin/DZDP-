//
//  DPSubCategory.m
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPSubCategory.h"

@implementation DPSubCategory
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"subcat_id"             :@"subcat_id",
             @"subcat_name"           :@"subcat_name"
             };
}
@end
