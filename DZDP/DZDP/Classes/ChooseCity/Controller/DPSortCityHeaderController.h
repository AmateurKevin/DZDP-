//
//  DPSortCityHeaderController.h
//  DZDP
//
//  Created by nickchen on 15/10/12.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPSortCityHeaderControllerProxy <NSObject>

- (void)sortCityHeaderViewSelectCity:(DPCity*)city;

@end

@interface DPSortCityHeaderController : UICollectionViewController


@property(nonatomic,weak) id<DPSortCityHeaderControllerProxy> proxy;


@end
