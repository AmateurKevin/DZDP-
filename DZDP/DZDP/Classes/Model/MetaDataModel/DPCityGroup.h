//
//  DPCityGroup.h
//  searchBarTest
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//



@interface DPCityGroup : MTLModel<MTLJSONSerializing>

@property(nonatomic,strong) NSArray  *cities;

// 组标题
@property (nonatomic,copy) NSString *title;

@end
