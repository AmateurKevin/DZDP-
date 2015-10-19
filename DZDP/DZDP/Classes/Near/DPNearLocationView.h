//
//  DPNearLocationView.h
//  DZDP
//
//  Created by nickchen on 15/10/6.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation;
@protocol DPNearLocationViewDelegate  <NSObject>
@optional
- (void)nearLocationViewRefreshLocation:(NSString *)Location With:(DPCity *)city;

@end

@interface DPNearLocationView : UIView

+ (instancetype)nearLocationView;

@property(nonatomic,weak) id<DPNearLocationViewDelegate> delegate;

@end
