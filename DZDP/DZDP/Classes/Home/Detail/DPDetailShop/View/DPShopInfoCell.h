//
//  DPShopInfoCell.h
//  DZDP
//
//  Created by nickchen on 15/10/5.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPDetailBaseCell.h"
@class DPShop;
@class DPDeal;

@protocol DPShopInfoCellDelegate <NSObject>

@optional
- (void)callShop;

@optional
- (void)goToMap;

@end


@interface DPShopInfoCell : DPDetailBaseCell

+ (instancetype)shopInfoCell;

@property(nonatomic,weak) id <DPShopInfoCellDelegate> delegate;

@property(nonatomic,strong) DPShop *shopInfo;

@property(nonatomic,strong) DPDeal *deal;

@end
