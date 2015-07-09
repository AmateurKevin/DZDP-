//
//  DPGetSingleDealResult.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPGetSingleDealResult : NSObject

/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;

@end
