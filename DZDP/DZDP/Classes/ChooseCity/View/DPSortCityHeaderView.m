//
//  DPSortCityHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/10/1.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPSortCityHeaderView.h"
#import "DPSortCityCell.h"
#import "DPSortCitySectionSupplementView.h"
#import "DPCity.h"
#import "DPMetaDataTool.h"
#import <INTULocationManager.h>
#import "DPGeocoderTool.h"
static NSString * const CityReuseIdentifier = @"city";
static NSString * const supplementCityReuseIdentifier = @"supplement";
static NSTimeInterval  const LocationTimeOut = 10;

@interface DPSortCityHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
// 当前城市
@property(nonatomic,strong) DPCity *locationCity;
// 最近访问城市数组,最多只存三个
@property(nonatomic,strong) NSMutableArray *recentCities;
// 热门城市
@property(nonatomic,strong) NSArray *hotCities;

@end

@implementation DPSortCityHeaderView


- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, DPScreenWidth, 290) collectionViewLayout:self.layout]) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        
        [self registerClass:[DPSortCityCell class] forCellWithReuseIdentifier:CityReuseIdentifier];
       
        [self registerNib:[UINib nibWithNibName:@"DPSortCitySectionSupplementView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:supplementCityReuseIdentifier];
        
        [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood timeout:LocationTimeOut block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            
            [DPGeocoderTool getCityFromLocation:currentLocation andExecuteBlock:^(DPCity *city) {
                _locationCity =city;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
                    
                });

            } ];
            
            
        }];
      

        
    }
    return self;
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  
    return self.recentCities.count > 0 ? 3 : 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.recentCities.count > 0 ? self.recentCities.count : self.hotCities.count;
    }
    
    return self.hotCities.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DPSortCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CityReuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.label.text = self.locationCity ? self.locationCity.city_name :@"正在定位中...";
        
    }
    
    if (indexPath.section == 1) {
        if (self.recentCities.count > 0) {
            cell.label.text = [self.recentCities[indexPath.item] city_name];
        }else{
            DPCity *city = self.hotCities[indexPath.item];
            cell.label.text = city.city_name;
        }
    }
    
    if (indexPath.section == 2) {
        DPCity *city = self.hotCities[indexPath.row];
        cell.label.text = city.city_name;
    }
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqual: UICollectionElementKindSectionHeader]) {
        DPSortCitySectionSupplementView *supplementView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:supplementCityReuseIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            supplementView.cityLabel.text = @"已定位城市";
        }
        
        if (indexPath.section == 1) {
            if (self.recentCities.count > 0) {
                supplementView.cityLabel.text = @"最近访问城市";
            }else{
               supplementView.cityLabel.text = @"热门城市";
            }
        }
        
        if (indexPath.section == 2) {
            supplementView.cityLabel.text = @"热门城市";

        }
        
        return supplementView;
    }
    return nil;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DPCity *selectedCity = nil;
    
    if (indexPath.section == 0) {
        
        selectedCity = _locationCity;
        
    }
    
    if (indexPath.section == 1) {
        if (self.recentCities.count > 0) {
            
            selectedCity = self.recentCities[indexPath.row];
            
        }else{
            
            selectedCity = self.hotCities[indexPath.row];
            
        }
    }
    
    if (indexPath.section == 2) {
        
        selectedCity = self.hotCities[indexPath.row];
        
    }
 
    [self updateRecentCityWith:selectedCity];
    if ([self.proxy respondsToSelector:@selector(sortCityHeaderViewSelectCity:)]) {
        [self.proxy sortCityHeaderViewSelectCity:selectedCity];
    }
 
}

# pragma mark -- method

- (void)updateRecentCityWith:(DPCity *)selectedCity{
    
    if (self.recentCities.count <= 0) {
        if (selectedCity){
            [self.recentCities addObject:selectedCity];
        }
        
        [self reloadData];
        
        return;
        
    }
    
    [self.recentCities enumerateObjectsUsingBlock:^(DPCity*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([selectedCity.city_id isEqualToNumber:obj.city_id]) {
            
            [self.recentCities exchangeObjectAtIndex:0 withObjectAtIndex:idx];
            [self reloadData];
            *stop = YES;
            
        }else{
            
            [self.recentCities insertObject:selectedCity atIndex:0];
            
            if (self.recentCities.count > 3) {
                [self.recentCities removeLastObject];
                [self reloadData];
               *stop = YES;
            }else{
                [self reloadData];
                *stop = YES;
            }
        }
    }];
 
}

#pragma mark -- lazy load

- (NSArray *)hotCities{
    
    if (!_hotCities) {
        _hotCities = [DPMetaDataTool hotCities];
    }
    return _hotCities;
}

- (NSMutableArray *)recentCities{
    
    if (!_recentCities) {
        
        _recentCities = [DPMetaDataTool recentCities];
        
    }
    return _recentCities;

}

- (DPCity *)locationCity{
    if (!_locationCity) {
       
        _locationCity = [DPMetaDataTool cityWithName:UserDefaultlocationCityName];
    }
    return _locationCity;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((DPScreenWidth - 55) / 3 , 30);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 25);
        layout.headerReferenceSize = CGSizeMake(DPScreenWidth, 20);
        _layout = layout;
        
    }
    return _layout;
}

@end
