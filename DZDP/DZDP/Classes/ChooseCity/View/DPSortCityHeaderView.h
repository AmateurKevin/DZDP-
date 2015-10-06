//
//  DPSortCityHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/10/1.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPCity;
@protocol DPSortCityHeaderViewProxy <NSObject>

- (void)sortCityHeaderViewSelectCity:(DPCity*)city;

@end

@interface DPSortCityHeaderView : UICollectionView

@property(nonatomic,weak) id<DPSortCityHeaderViewProxy> proxy;

@end
