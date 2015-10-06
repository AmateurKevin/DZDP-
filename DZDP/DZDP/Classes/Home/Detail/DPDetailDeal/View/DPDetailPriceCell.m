//
//  DPDetailPriceCell.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailPriceCell.h"
#import "DPDeal.h"
@interface DPDetailPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end

@implementation DPDetailPriceCell

+ (instancetype)detailPriceCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPDetailPriceCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDeal:(DPDeal *)deal{
    _deal = deal;
    self.promotionLabel.text = [NSString stringWithFormat:@"%ld",deal.promotion_price.integerValue / 100];
   
    self.currentLabel.text = [NSString stringWithFormat:@"%ld",deal.current_price.integerValue / 100];
    self.marketLabel.text =[NSString stringWithFormat:@"%ld",deal.market_price.integerValue / 100];
}

@end
