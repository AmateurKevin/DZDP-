//
//  DPDealCell.m
//  DZDP
//
//  Created by nickchen on 15/6/29.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDealCell.h"
#import "DPDeal.h"
#import "UIImageView+WebCache.h"
@interface DPDealCell ()

@property (weak, nonatomic) IBOutlet UIImageView *dealImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaceCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reservationImage;

@end

@implementation DPDealCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    [self.dealImage sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"default_loading_bigicon"]];
    
    if (deal.restrictions.is_reservation_required == 0) {
        self.reservationImage.hidden = NO;
        
    }else{
        self.reservationImage.hidden = YES;
    }
    
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@",deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥%@",deal.list_price];
    self.purchaceCountLabel.text = [NSString stringWithFormat:@"已售%d",deal.purchase_count];
}

@end
