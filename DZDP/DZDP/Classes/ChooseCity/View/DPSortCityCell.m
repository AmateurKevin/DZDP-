//
//  DPSortCityCell.m
//  DZDP
//
//  Created by nickchen on 15/10/1.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPSortCityCell.h"

@implementation DPSortCityCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.cornerRadius = 4;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.masksToBounds = YES;
        [self.contentView addSubview:label];
        self.label = label;
        //self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = self.contentView.frame;
}

@end
