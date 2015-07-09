//
//  DPGetSingleDealResult.m
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPGetSingleDealResult.h"
#import "DPDeal.h"
@implementation DPGetSingleDealResult

+ (NSDictionary*)objectClassInArray
{
    return @{@"deals":[DPDeal class]};
}

@end
