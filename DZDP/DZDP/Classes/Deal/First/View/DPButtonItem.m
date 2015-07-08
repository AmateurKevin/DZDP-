//
//  DPButtonItem.m
//  DZDP
//
//  Created by nickchen on 15/7/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPButtonItem.h"

@implementation DPButtonItem

+ (instancetype)buttonItemWith:(NSDictionary *)dict{
    DPButtonItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
