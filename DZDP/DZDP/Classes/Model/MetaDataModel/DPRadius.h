//
//  DPRadius.h
//  DZDP
//
//  Created by nickchen on 15/10/6.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPRadius : MTLModel<MTLJSONSerializing>

@property (assign, nonatomic) NSNumber *radius;
@property (copy, nonatomic) NSString *radiusTip;
@end
