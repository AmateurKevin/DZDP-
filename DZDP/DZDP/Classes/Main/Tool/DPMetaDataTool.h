//
//  DPMetaDataTool.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPCity.h"
@interface DPMetaDataTool : NSObject

+ (NSArray *)categories;

+ (NSArray *)sorts;

+ (NSArray *)cityGroups;

+ (NSArray *)cities;

+ (DPCity *)cityWithName:(NSString *)name;

@end
