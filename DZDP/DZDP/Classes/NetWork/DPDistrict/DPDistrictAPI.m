//
//  DPDistrictAPI.m
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDistrictAPI.h"

@implementation DPDistrictAPI{
    NSNumber *_city_id;
}

- (instancetype)initWithCityID:(NSNumber *)city_id{
    self = [super init];
    if (self) {
        _city_id = city_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/districts";
}

- (id)requestArgument {
    return @{
             @"city_id": _city_id
             };
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}
@end
