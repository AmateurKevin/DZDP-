//
//  DPCenterLineLabel.m
//  DZDP
//
//  Created by nickchen on 15/6/30.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPCenterLineLabel.h"

@implementation DPCenterLineLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    [self.textColor set];
    
    CGFloat x = 0;
    CGFloat w = rect.size.width;
    CGFloat h = 1;
    CGFloat y = rect.size.height / 2;
    
    UIRectFill(CGRectMake(x, y, w, h));
    
}


@end
