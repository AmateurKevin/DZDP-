//
//  DPCity.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPCity.h"
#import "DPRegion.h"
@implementation DPCity

+ (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [DPRegion class]};
}

@end
