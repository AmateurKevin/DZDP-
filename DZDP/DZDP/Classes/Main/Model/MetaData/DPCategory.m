//
//  DPCategory.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPCategory.h"

@implementation DPCategory
- (NSString *)title
{
    return self.name;
}

- (NSArray *)subTitles
{
    return self.subcategories;
}
@end
