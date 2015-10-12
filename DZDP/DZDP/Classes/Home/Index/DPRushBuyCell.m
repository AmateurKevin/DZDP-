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
