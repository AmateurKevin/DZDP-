//
//  DPAPITool.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPAPITool : NSObject

+ (instancetype)sharedAPITool;

- (void)request:(NSString *)url params:(NSMutableDictionary*)params success: (void (^)(id))success failure:(void(^)(NSError *error))failure;

@end
