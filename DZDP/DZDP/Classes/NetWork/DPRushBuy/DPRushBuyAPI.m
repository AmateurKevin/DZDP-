//
//  DPRushBuyAPI.m
//  DZDP
//
//  Created by nickchen on 15/10/15.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPRushBuyAPI.h"
#import "DPRushBuyModel.h"
@implementation DPRushBuyAPI

- (NSString *)requestUrl {
    return @"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=5XcUdpcURaMDFtcU80NTdxazBUNWpXekdVd1ZEOFRjV3cxcjBHV1V2R25CUzlXQVFBQUFBJCQAAAAAAAAAAAEAAADATA1XAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKd4B1aneAdWc0&channel=com_dot_apple&cityid=300110000&cuid=ea3e0f1e9811a658cf56b31b26ac9dae21327344&device=iPhone&ha=5&lbsidfa=91893E5B-DF12-4CBD-8B49-2FD78BC28C3C&location=23.140610%2C113.378310&net=wifi&os=9&page_type=component&sheight=2001&sign=4c6e8237067e4860d712803ca3b44cfe&swidth=1125&terminal_type=ios&timestamp=1444851662503&tn=ios&uuid=ea3e0f1e9811a658cf56b31b26ac9dae21327344&v=5.13.2";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (void)getRushBuysIfsuccess:(void (^)(NSArray *))success failure:(void (^)())failure{
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if ([request.responseJSONObject[@"errno"] isEqualToNumber:@(1005)]) {
            
            if (failure)  failure();
            
        }
        
        
        if ([request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            if (success) {
                
                if (request.responseJSONObject[@"data"][@"deals"] != [NSNull null]) {
                    
                    NSArray *deals = [MTLJSONAdapter modelsOfClass:[DPRushBuyModel class] fromJSONArray:request.responseJSONObject[@"data"][@"topten"][@"list"] error:nil];
                    
                    if (deals) {
                        
                        success(deals);
                    }
                }
                
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
        if (![request.responseJSONObject[@"errno"] isEqualToNumber: @(0)]) {
            
            
            
        }
        
        if(failure) failure();
        
    }];
    
    
}


@end
