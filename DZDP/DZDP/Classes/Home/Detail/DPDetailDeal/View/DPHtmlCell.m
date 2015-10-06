//
//  DPWebViewCell.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPHtmlCell.h"

@implementation DPHtmlCell

+ (instancetype)htmlCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPHtmlCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
