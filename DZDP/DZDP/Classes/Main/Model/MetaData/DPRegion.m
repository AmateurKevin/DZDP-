//
//  DPRegion.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPRegion.h"

@implementation DPRegion

- (NSString *)title
{
    return self.name;
}

- (NSArray *)subTitles
{
    return self.subregions;
}

@end
