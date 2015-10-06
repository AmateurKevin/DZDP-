//
//  DPCity.h
//  DZDP
//
//  Created by nickchen on 15/9/26.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//



@interface DPCity : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *short_name;

@property (nonatomic, copy) NSString *city_pinyin;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *short_pinyin;

@property (nonatomic, copy) NSNumber *city_id;
@end
