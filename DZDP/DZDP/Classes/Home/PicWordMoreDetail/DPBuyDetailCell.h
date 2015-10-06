//
//  DPBuyDetailCell.h
//  DZDP
//
//  Created by nickchen on 15/10/5.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPBuyDetailCell : UITableViewCell

+ (instancetype)buyDetailCell;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *buyDetailLabel;


@end
