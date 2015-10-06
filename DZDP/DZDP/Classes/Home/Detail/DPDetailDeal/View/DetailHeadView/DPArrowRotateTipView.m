//
//  DPArrowRotateTipView.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPArrowRotateTipView.h"

@interface DPArrowRotateTipView ()

@property (weak, nonatomic) IBOutlet UIImageView *detailArrowView;


@end

@implementation DPArrowRotateTipView

+ (instancetype)arrowRotateTipView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPArrowRotateTipView" owner:nil options:nil] lastObject];
}

- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    self.detailArrowView.transform = CGAffineTransformMakeRotation(angle);
}

@end
