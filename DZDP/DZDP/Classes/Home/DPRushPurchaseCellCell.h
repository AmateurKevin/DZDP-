//
//  DPRushPurchaseCellCell.h
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPCenterLineLabel.h"
@interface DPRushPurchaseCellCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet DPCenterLineLabel *marketPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;


@end
