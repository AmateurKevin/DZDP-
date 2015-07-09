//
//  DPOrangeBorderLabel.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPOrangeBorderLabel.h"

@implementation DPOrangeBorderLabel


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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    [self setTextColor:[UIColor orangeColor]];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:10];
    self.layer.masksToBounds = YES;
    [self sizeToFit];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

@end
