//
//  DPHomeHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPHomeHeaderView;
@protocol HomeHeaderViewDelegate <NSObject>

@optional
- (void)homeHeaderView:(DPHomeHeaderView *)view didSelectCatID:(NSNumber *)catID orSubCatID:(NSNumber *)subCatID;

@end

@interface DPHomeHeaderView : UIView

+ (instancetype)homeHeaderView;

@property(nonatomic,strong) NSArray *homeCategoryModels;




@property(nonatomic,weak) id<HomeHeaderViewDelegate> delegate;

@end
