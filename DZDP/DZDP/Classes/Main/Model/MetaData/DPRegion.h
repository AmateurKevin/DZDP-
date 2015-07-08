//
//  DPRegion.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPDropdownMenu.h"
@interface DPRegion : NSObject<DPDropdownMenuItemDelegate>
/** 区域名称 */
@property (copy, nonatomic) NSString *name;
/** 子区域 */
@property (strong, nonatomic) NSArray *subregions;
@end
