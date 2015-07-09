//
//  DPRightImageButton.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPRightImageButton.h"

static float const kImageToTextMargin = 7;

@implementation DPRightImageButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setImage: [UIImage imageNamed:@"tuangou_list_icon_arrow_down"]forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"tuangou_list_icon_arrow_up"] forState:UIControlStateSelected];

    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width - kImageToTextMargin, 0, self.imageView.frame.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
}

@end
