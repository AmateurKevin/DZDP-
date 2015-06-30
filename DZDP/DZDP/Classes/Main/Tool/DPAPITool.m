//
//  DPAPITool.m
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPAPITool.h"
#import "DPAPI.h"

@interface DPAPITool()<DPRequestDelegate>

@property(nonatomic,strong) DPAPI *api;

@property(nonatomic,strong) NSMutableDictionary *successBlock;

@property(nonatomic,strong) NSMutableDictionary *failureBlock;


@end


@implementation DPAPITool

-(DPAPI *)api
{
    if (_api == nil) {
        _api = [[DPAPI alloc] init];
    }
    return _api;
}

- (NSMutableDictionary *)successBlock
{
    if (!_successBlock) {
        _successBlock = @{}.mutableCopy;
    }
    return _successBlock;
}

- (NSMutableDictionary *)failureBlock
{
    if (!_failureBlock) {
        _failureBlock = @{}.mutableCopy;
    }
    return _failureBlock;
}

static id _instance = nil;

+ (instancetype)sharedAPITool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}



- (void)request:(NSString *)url params:(NSMutableDictionary*)params success: (void (^)(id))success failure:(void(^)(NSError *error))failure
{
    DPRequest *request = [self.api requestWithURL:url params:params  delegate:self];
    self.successBlock[request.description] = success;
    self.failureBlock[request.description] = failure;
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    void (^failure)(NSError* error) = self.failureBlock[request.description];
    if (failure) {
        failure(error);
    }
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    void (^success)(id) = self.successBlock[request.description];
    
    if (success) {
        success(result);
    }
}


@end
