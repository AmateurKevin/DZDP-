//
//  DPCategroryMenuCell.m
//  DZDP
//
//  Created by nickchen on 15/7/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPCategroryMenuCell.h"

@interface DPCategroryMenuCell ()

@end

@implementation DPCategroryMenuCell

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
    [self.Label setTextColor:[UIColor blackColor]];
    [self.Label setTextAlignment:NSTextAlignmentCenter];
    [self.Label setFont:[UIFont systemFontOfSize:12]];
    self.Label.backgroundColor = [UIColor whiteColor];
}

- (UILabel *)Label
{
    if (_Label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 1, self.bounds.size.height -1)];
        _Label = label;
        [self.contentView addSubview:label];
    }
    return _Label;
}

@end
