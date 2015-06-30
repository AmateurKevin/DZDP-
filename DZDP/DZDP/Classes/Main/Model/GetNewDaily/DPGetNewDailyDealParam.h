//
//  DPGetNewDailyDealParam.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPGetNewDailyDealParam : NSObject

/**
 *  包含团购信息的城市名称
 */

@property (nonatomic,copy) NSString* city;


/**date	string	查询日期，格式为“YYYY-MM-DD” */

@property (nonatomic,copy) NSString* date;


@end
