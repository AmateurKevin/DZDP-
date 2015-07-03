//
//  DPMetaDataTool.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPMetaDataTool.h"
#import "DPCategory.h"
#import "DPCityGroup.h"
#import "DPCity.h"
#import "DPSort.h"

static NSArray *_categories;
static NSArray *_sorts;
static NSArray *_cityGroups;
static NSArray *_cities;
@implementation DPMetaDataTool

+ (NSArray *)categories
{
    if (!_categories) {
        _categories = [DPCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

+ (NSArray *)sorts
{
    if (!_sorts) {
        _sorts = [DPSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

+ (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [DPCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

+ (NSArray *)cities
{
    if (!_cities) {
        _cities = [DPCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

+ (DPCity *)cityWithName:(NSString *)name{
    if (name.length == 0)return nil;
    
    for (DPCity *city in [self cities]) {
        if ([city.name isEqualToString:name])return city;
    }
    return nil;
}

@end
