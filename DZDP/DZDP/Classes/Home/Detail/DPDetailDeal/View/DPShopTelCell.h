//
//  DPShopTelCell.h
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailBaseCell.h"

@protocol DPShopTelCellDelegate <NSObject>

- (void)shopTelBtnClicked;

@end

@class DPShop;
@interface DPShopTelCell : DPDetailBaseCell

+ (instancetype)shopTelCell;

@property(nonatomic,strong) DPShop *shop;

@property(nonatomic,weak) id<DPShopTelCellDelegate> delegate;

@end
