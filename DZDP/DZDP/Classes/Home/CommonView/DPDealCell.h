//
//  DPDealCell.h
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDeal;
@interface DPDealCell : UITableViewCell

@property(nonatomic,strong) DPDeal *deal;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)dealCell;

@end