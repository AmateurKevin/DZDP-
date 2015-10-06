//
//  DPCircleLabel.m
//  DZDP
//
//  Created by nickchen on 15/7/8.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPCircleLabel.h"

@implementation DPCircleLabel

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
    self.backgroundColor = [UIColor lightGrayColor];
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.borderWidth = 1;
    [self setTextColor:[UIColor blackColor]];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:10];
    self.layer.masksToBounds = YES;
    //[self sizeToFit];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}


@end
