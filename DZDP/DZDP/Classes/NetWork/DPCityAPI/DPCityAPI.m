//
//  DPCityAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCityAPI.h"

@implementation DPCityAPI
- (NSString *)requestUrl {
    return @"/cities";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}
@end
