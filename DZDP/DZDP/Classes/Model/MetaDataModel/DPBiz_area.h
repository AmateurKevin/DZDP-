//
//  DPBiz_area.h
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPBiz_area : MTLModel<MTLJSONSerializing>

/**
 *  商业区名称
 */
@property (nonatomic,copy) NSString *biz_area_name;
/**
 *  商业区id
 */
@property (nonatomic,copy) NSNumber *biz_area_id;

@end
