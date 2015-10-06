//
//  DPBuyDetailCell.m
//  DZDP
//
//  Created by nickchen on 15/10/5.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPBuyDetailCell.h"

@interface DPBuyDetailCell ()<UIWebViewDelegate>



@end

@implementation DPBuyDetailCell

+ (instancetype)buyDetailCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPBuyDetailCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    self.webView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    webView.hidden = NO;
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    //self.heightConstraint = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:webView.height];
}

@end
