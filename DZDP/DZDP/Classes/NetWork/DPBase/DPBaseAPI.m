//
//  DPBaseAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseAPI.h"

@implementation DPBaseAPI

- (NSDictionary *)requestHeaderFieldValueDictionary{
    return @{@"apikey":@"972c070425838a9eee65ceb7fd352115"};
}

/**
 *  所有请求缓存三分钟
 *
 *  @return 缓存时长
 */
- (NSInteger)cacheTimeInSeconds{
    return 3 * 60;
}

@end
