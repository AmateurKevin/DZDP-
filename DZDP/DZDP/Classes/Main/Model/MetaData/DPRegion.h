//
//  DPRegion.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DPRegion : NSObject
/** 区域名称 */
@property (copy, nonatomic) NSString *name;
/** 子区域 */
@property (strong, nonatomic) NSArray *subregions;
@end
