//
//  DPDealCell.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDealCell.h"
#import "DPDeal.h"
#import "DPShop.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DPDealCell ()

@property (weak, nonatomic) IBOutlet UIImageView *dealImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaceCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reservationImage;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation DPDealCell

- (void)awakeFromNib {
    // Initialization code
    self.dealImage.layer.cornerRadius = 5;
    self.dealImage.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)dealCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPDealCell" owner:nil options:nil] lastObject];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"deal";
    DPDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DPDealCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    [self.dealImage sd_setImageWithURL:deal.tiny_image placeholderImage:[UIImage imageNamed:@"default_loading_bigicon"]];
    
    if (deal.is_reservation_required == 0) {
        self.reservationImage.hidden = NO;
        
    }else{
        self.reservationImage.hidden = YES;
    }
    
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    if (deal.current_price) {
        self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%d",deal.current_price.intValue / 100];
    }
    if (deal.market_price) {
        self.listPriceLabel.text = [NSString stringWithFormat:@"¥%d",deal.market_price.intValue / 100];
    }
    
    if (deal.sale_num) {
        self.purchaceCountLabel.text = [NSString stringWithFormat:@"已售%d",deal.sale_num.intValue];
    }
    
    
}

- (void)setShop:(DPShop *)shop{

    _shop = shop;
    
    if (sameCity) {
        self.distanceLabel.hidden = NO;
        NSString *disStr = nil;
        int dis = shop.distance.intValue;
        if (dis <= 1000) {
            disStr = [NSString stringWithFormat:@"%dm",dis];
        }else{
            
            disStr = [NSString stringWithFormat:@"%.1fkm",dis / 1000.0];
        }
        
        self.distanceLabel.text = disStr;
        
    }else{
        self.distanceLabel.hidden = YES;
    }
    

    
}

@end
