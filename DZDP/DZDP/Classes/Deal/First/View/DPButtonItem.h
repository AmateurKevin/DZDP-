//
//  DPButtonItem.h
//  DZDP
//
//  Created by nickchen on 15/7/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPCategory.h"
@interface DPButtonItem : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *category;

+ (instancetype)buttonItemWith:(NSDictionary *)dict;

@end
