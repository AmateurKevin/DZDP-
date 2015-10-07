//
//  DPLocationTool.m
//  DZDP
//
//  Created by nickchen on 15/10/6.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPGeocoderTool.h"
#import "DPMetaDataTool.h"
@implementation  DPGeocoderTool

+ (NSString *)getCityNameFromLocation:(CLLocation *)currentLocation {

    __block NSString *name = nil;
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
    
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *test = [placemark addressDictionary];
            
            NSString *stateName = [test objectForKey:@"State"];
            NSString *cityName = [test objectForKey:@"City"];
            
            if ([stateName isEqualToString:@"北京市"]||
                [stateName isEqualToString:@"天津市"]||
                [stateName isEqualToString:@"重庆市"]||
                [stateName isEqualToString:@"上海市"]) {
                
                name = stateName;
                
            }else{
                
                name = cityName;
                
            }
        }
    }];
    return name;
}

+ (void)getCityFromLocation:(CLLocation *)currentLocation andExecuteBlock:(void(^)(DPCity *city))block{
    
    __block DPCity *city = nil;
    
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
            //DPLog(@"%@", [test objectForKey:@"State"]);
            
            [[NSUserDefaults standardUserDefaults] setObject:[test objectForKey:@"State"] forKey:locationCityNameKEY];
            
            NSString *stateName = [test objectForKey:@"State"];
            NSString *cityName = [test objectForKey:@"City"];
            
            if ([stateName isEqualToString:@"北京市"]||
                [stateName isEqualToString:@"天津市"]||
                [stateName isEqualToString:@"重庆市"]||
                [stateName isEqualToString:@"上海市"]) {
                [[NSUserDefaults standardUserDefaults] setObject:stateName forKey:locationCityNameKEY];
                city =  [DPMetaDataTool cityWithName:stateName];
                
                if (block) {
                     block(city);
                }
               
                
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:locationCityNameKEY];
                
                city = [DPMetaDataTool cityWithName:cityName];
                block(city);
            }
        }

    }];
   
}
// 获得地址全称
+ (void)getFullAddressFromLocation:(CLLocation *)currentLocation andExecute:(void(^)(NSString *address))block{
    
   __block NSString *fullAddress = nil;
    
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
        
            fullAddress = [test objectForKey:@"Name"];
            
            block(fullAddress);
            
        }
        
    }];
    

    
}

// 返回数据后更新第一组label,即定位到的城市
//                    DPLog(@"%@",[test objectForKey:@"State"]);
//                    DPLog(@"%@",[test objectForKey:@"City"]);
//                     DPLog(@"%@",[test objectForKey:@"Street"]);
//                    DPLog(@"%@",[test objectForKey:@"FormattedAddressLines"]);

//                    DPLog(@"%@",[test objectForKey:@"Name"]); //  地址全称
//                    DPLog(@"%@",[test objectForKey:@"SubLocality"]);
//                    DPLog(@"%@",[test objectForKey:@"Thoroughfare"]);
@end
