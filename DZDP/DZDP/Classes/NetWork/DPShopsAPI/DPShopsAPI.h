//
//  DPShopsAPI.h
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBaseAPI.h"
@class DPFindShopsParam;

@interface DPShopsAPI : DPBaseAPI

- (id)initWithShopsParam:(DPFindShopsParam *)param;

- (void)getShopsIfsuccess:(void(^)(NSArray* Shops))success failure:(void(^)(YTKBaseRequest*request))failure;

@end
