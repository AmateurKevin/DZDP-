//
//  DPFindDealsParam.h
//  DZDP
//
//  Created by nickchen on 15/6/28.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPFindDealsParam : NSObject

@property (nonatomic,assign) NSNumber *city_id;

@property (nonatomic,copy) NSString *cat_ids;

@property (nonatomic,copy) NSString *subcat_ids;

@property (nonatomic,copy) NSString *district_ids;

@property (nonatomic,copy) NSString *bizarea_ids;

@property (nonatomic,copy) NSString *location;

@property (nonatomic,copy) NSString *keyword;

@property (nonatomic,assign) NSNumber *radius;

@property (nonatomic,assign) NSNumber *sort;

@property (nonatomic,assign) NSNumber *page;

@property (nonatomic,assign) NSNumber *page_size;

@property (nonatomic,assign) NSNumber *is_reservation_required;
@end
