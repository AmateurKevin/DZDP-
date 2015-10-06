//
//  DPDealFooterCell.h
//  DZDP
//
//  Created by nickchen on 15/9/30.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDealFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
