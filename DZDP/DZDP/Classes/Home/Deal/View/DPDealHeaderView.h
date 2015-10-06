//
//  DPDealHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/9/30.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPShop;

@protocol  DPDealHeaderViewDelegate<NSObject>

- (void)dealHeaderViewTapped:(DPShop *)shop;

@end

@interface DPDealHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong) DPShop *shop;

@property(nonatomic,weak) id delegate;

@end
