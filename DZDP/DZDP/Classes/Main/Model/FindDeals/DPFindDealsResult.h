//
//  DPFindDealsResult.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPGetSingleDealResult.h"

@interface DPFindDealsResult : DPGetSingleDealResult

/**团购总数量*/
@property(nonatomic,strong) NSNumber *total_count;

@end
