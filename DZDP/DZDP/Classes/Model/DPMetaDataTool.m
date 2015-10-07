//
//  DPMetaDataTool.m
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPMetaDataTool.h"
#import "DPCity.h"
#import "DPCityGroup.h"
#import "DPSort.h"
#import "DPCategory.h"
#import "DPRadius.h"
static NSArray *_categories;
static NSArray *_sorts;
static NSArray *_cityGroups;
static NSArray *_cities;
static NSArray *_hotCities;
static NSMutableArray *_recentCities;
static NSArray *_searchRadius;
@implementation DPMetaDataTool

+ (NSArray *)searchRadius{
    if (!_searchRadius) {
        
        NSArray *jsonArray = [self jsonArrayOfResource:@"SearchRadius"];
        _searchRadius = [MTLJSONAdapter modelsOfClass:[DPRadius class] fromJSONArray:jsonArray error:nil];
        
    }
    return _searchRadius;
}

+ (NSArray *)categories
{
    if (!_categories) {
        
        NSArray *jsonArray = [self jsonArrayOfResource:@"categories"];
        _categories = [MTLJSONAdapter modelsOfClass:[DPCategory class] fromJSONArray:jsonArray error:nil];
    }
    return _categories;
}

+ (NSArray *)sorts
{
    if (!_sorts) {
        NSArray *jsonArray = [self jsonArrayOfResource:@"sorts"];
        _sorts = [MTLJSONAdapter modelsOfClass:[DPSort class] fromJSONArray:jsonArray error:nil];
    }
    return _sorts;
}


+ (NSArray *)cityGroups
{
    if (!_cityGroups) {
        NSArray *jsonArray = [self jsonArrayOfResource:@"cityGroup"];
        _cityGroups = [MTLJSONAdapter modelsOfClass:[DPCityGroup class] fromJSONArray:jsonArray error:nil];
    }
    return _cityGroups;
}

+ (NSArray *)cities
{
    if (!_cities) {
        
        NSArray *jsonArray = [self jsonArrayOfResource:@"cities"];
        
        _cities = [MTLJSONAdapter modelsOfClass:[DPCity class] fromJSONArray:jsonArray error:nil];
    }
    return _cities;
}

// 热门城市
+ (NSArray *)hotCities{
    
    if (!_hotCities) {
        
        NSArray *jsonArray = [self jsonArrayOfResource:@"hotCity"];
        _hotCities = [MTLJSONAdapter modelsOfClass:[DPCity class] fromJSONArray:jsonArray error:nil];
    }
    return _hotCities;
    
}

+ (NSMutableArray *)recentCities{
    
    if (!_recentCities) {
        
        NSArray *cityArray = [NSArray arrayWithContentsOfFile:DPRecentCityPlist];
        
        if (cityArray) {
            
            NSData *json_data = [NSJSONSerialization dataWithJSONObject:cityArray options:0 error:nil];
            
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
            
            _recentCities =  [MTLJSONAdapter modelsOfClass:[DPCity class] fromJSONArray:jsonArray error:nil].mutableCopy;
            
        }else{
            
            _recentCities = @[].mutableCopy;
            
        }
    }
    return _recentCities;
    
}
/**
 *   更新最近城市
 *
 *  @param cityArray 最近访问城市
 */
+ (void)updateRecentCityWith:(NSArray *)cityArray{
    [cityArray writeToFile:DPRecentCityPlist atomically:YES];
}

+ (DPCity *)cityWithName:(NSString *)name{
    if (name.length <= 0)return nil;
    
    for (DPCity *city in [self cities]) {
        if ([city.city_name isEqualToString:name] || [city.short_name isEqualToString:name])
            return city;
    }
    return nil;
}

+ (DPCity *)cityWithID:(NSNumber *)city_id{
    if (city_id == nil)return nil;
    
    for (DPCity *city in [self cities]) {
        if ([city.city_id isEqual:city_id])
            return city;
    }
    return nil;
}
#pragma mark -- private jsonArray
+ (NSArray *)jsonArrayOfResource:(NSString *)resourceName{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"plist"];
    
    NSArray *cityArray = [NSArray arrayWithContentsOfFile:filePath];
    NSData *json_data = [NSJSONSerialization dataWithJSONObject:cityArray options:0 error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
}

@end
