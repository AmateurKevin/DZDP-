//
//  DPDeal.m
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPDeal.h"
#import "DPBusiness.h"

@implementation DPDeal

+ (NSDictionary*)objectClassInArray
{
    return @{@"businesses":[DPBusiness class]};
}

+ (NSDictionary*)replacedKeyFromPropertyName
{
    return @{@"desc":@"description"};
}

- (BOOL)isEqual:(DPDeal *)other
{
    return [self.deal_id isEqualToString:other.deal_id];
}

MJCodingImplementation

@end
