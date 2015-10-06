//
//  DPDistrict.h
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPDistrict : MTLModel<MTLJSONSerializing>
/**
 *  行政区名
 */
@property (nonatomic,copy) NSString *district_name;
/**
 *  行政区id
 */
@property (nonatomic,copy) NSNumber *district_id;

/// 商业区
@property(nonatomic,strong) NSArray *biz_areas;

@end
