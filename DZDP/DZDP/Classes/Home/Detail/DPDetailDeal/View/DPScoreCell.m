//
//  DPScoreCell.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPScoreCell.h"
#import "DPDeal.h"
@interface DPScoreCell()
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
@implementation DPScoreCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)scoreCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPScoreCell" owner:nil options:nil] lastObject];
}

- (void)setDeal:(DPDeal *)deal{
    _deal = deal;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.2f分",deal.score.floatValue];
    
   int num = floor(deal.score.floatValue * 2) * 5;
    
    NSString *imageName = [NSString stringWithFormat:@"ShopStar%d",num];
    self.scoreImage.image = [UIImage imageNamed:imageName];
}

@end
