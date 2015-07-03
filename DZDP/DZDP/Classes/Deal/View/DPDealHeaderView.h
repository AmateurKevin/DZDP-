//
//  DPDealHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/7/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDealHeaderView;
@protocol DealHeaderViewDelegate <NSObject>

@optional
-(void)dealHeaderView:(DPDealHeaderView *)dealHeaderView buttonClicked:(UIButton *)button;

@end

@interface DPDealHeaderView : UIView

+ (instancetype)DealHeaderViewWith:(NSArray *)items;

@property(nonatomic,weak) id<DealHeaderViewDelegate> delegate;

@end
