//
//  DPShopTelCell.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPShopTelCell.h"
#import "DPShop.h"
#import "DPDetailShopAPI.h"

@interface DPShopTelCell ()

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopDescLabel;




@end

@implementation DPShopTelCell

+ (instancetype)shopTelCell{

    return [[[NSBundle mainBundle] loadNibNamed:@"DPShopTelCell" owner:nil options:nil] lastObject];
}

- (void)setShop:(DPShop *)shop{
    _shop =shop;
    //[self.telButton setTitle:shop.phone forState:UIControlStateNormal];

    self.shopNameLabel.text = shop.shop_name;
    
    self.shopDescLabel.text = shop.address;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.shopNameLabel.font = [UIFont boldSystemFontOfSize:14];
}

- (IBAction)buttonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(shopTelBtnClicked)]) {
        [self.delegate shopTelBtnClicked];
    }
    
}
@end
