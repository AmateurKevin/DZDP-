//
//  DPCategory.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
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
