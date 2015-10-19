//
//  DPRushBuyCell.m
//  DZDP
//
//  Created by nickchen on 15/10/11.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPRushBuyCell.h"
#import "DPDeal.h"


@implementation DPRushBuyCell

//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        //
//        for (int i = 0; i < 3; ++i) {
//            //背景view
//            
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
//            
//            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*screen_width/3, 40, (screen_width-3)/3, 80)];
//            backView.tag = 100+i;
//            [backView addGestureRecognizer:tap];
//            [self addSubview:backView];
//            //
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (screen_width-3)/3, 50)];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            imageView.tag = i+20;
//            [backView addSubview:imageView];
//            //
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*screen_width/3-1, 45, 0.5, 65)];
//            lineView.backgroundColor = separaterColor;
//            [self addSubview:lineView];
//            
//            //
//            UILabel *newPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, backView.frame.size.width/2, 30)];
//            newPrice.tag = 50+i;
//            newPrice.textColor = RGB(245, 185, 98);
//            newPrice.textAlignment = NSTextAlignmentRight;
//            //            newPrice.font = [UIFont systemFontOfSize:17];
//            [backView addSubview:newPrice];
//            //
//            UILabel *oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width/2+5, 50, backView.frame.size.width/2-5, 30)];
//            oldPriceLabel.tag = 70+i;
//            oldPriceLabel.textColor = navigationBarColor;
//            oldPriceLabel.font = [UIFont systemFontOfSize:13];
//            [backView addSubview:oldPriceLabel];
//            
//            //名店抢购
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 40)];
//            titleLabel.text = @"名店抢购";
//            titleLabel.textColor = RGB(240, 110, 87);
//            //            [self addSubview:titleLabel];
//            //名店抢购图
//            UIImageView *mingdian = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 78, 25)];
//            [mingdian setImage:[UIImage imageNamed:@"todaySpecialHeaderTitleImage"]];
//            [self addSubview:mingdian];
//            
//        }
//    }
//    return self;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRushModels:(NSArray *)rushModels{

    _rushModels = rushModels;
   
//    self.rush1.deal = rushModels.firstObject;
//    self.rush2.deal = rushModels[1];
//    self.rush3.deal = rushModels.lastObject;
}



@end
