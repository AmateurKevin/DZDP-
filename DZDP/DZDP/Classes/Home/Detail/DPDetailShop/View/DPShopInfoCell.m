//
//  DPShopInfoCell.m
//  DZDP
//
//  Created by nickchen on 15/10/5.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPShopInfoCell.h"
#import "DPShop.h"
#import "DPDeal.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DPShopInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *shopIconView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAdrressLabel;

@end

@implementation DPShopInfoCell

+ (instancetype)shopInfoCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPShopInfoCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTaped)];
    
    [self.shopAdrressLabel addGestureRecognizer:recognizer];
    self.shopAdrressLabel.userInteractionEnabled = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)phoneButtonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(callShop)]) {
        [self.delegate callShop];
    }
}

- (void)addressTaped{
    
    if ([self.delegate respondsToSelector:@selector(goToMap)]) {
        [self.delegate goToMap];
    }
 
}

- (void)setDeal:(DPDeal *)deal{
    
    [self.shopIconView sd_setImageWithURL:deal.tiny_image];
    //[self.bgImageView sd_setImageWithURL:deal.image];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%.2f分",deal.score.floatValue];
    
    int num = floor(deal.score.floatValue * 2) * 5;
    
    NSString *imageName = [NSString stringWithFormat:@"ShopStar%d",num];
    self.scoreImage.image = [UIImage imageNamed:imageName];

}

- (void)setShopInfo:(DPShop *)shopInfo{
    
    _shopInfo = shopInfo;
    self.shopName.text = shopInfo.shop_name;
    self.shopAdrressLabel.text = shopInfo.address;
  
}

@end
