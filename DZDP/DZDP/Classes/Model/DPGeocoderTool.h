//
//  DPLocationTool.h
//  DZDP
//
//  Created by nickchen on 15/10/6.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <INTULocationManager.h>
#import "DPCity.h"
@interface DPGeocoderTool : NSObject

// 获得城市名对应的Dpcity,
+ (void)getCityFromLocation:(CLLocation *)currentLocation andExecuteBlock:(void(^)(DPCity *city))block;

// 获得地址全称
+ (void)getFullAddressFromLocation:(CLLocation *)currentLocation andExecute:(void(^)(NSString *address))block;

@end
