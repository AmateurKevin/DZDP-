//
//  DPDealFooterCell.m
//  DZDP
//
//  Created by nickchen on 15/9/30.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDealFooterCell.h"

@implementation DPDealFooterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"footerCell";
    DPDealFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DPDealFooterCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


@end
