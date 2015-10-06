//
//  DPDealHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/9/30.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

static CGFloat const kMargin = 10;

#import "DPDealHeaderView.h"
#import "DPShop.h"

@interface DPDealHeaderView()

@property(nonatomic,weak) UILabel *nameLabel;

@property(nonatomic,weak) UILabel *scoreLabel;

@property(nonatomic,weak) UILabel *distanceLabel;

@property(nonatomic,weak) UIView *bottomLineView;

@property(nonatomic,weak) UIView *topLineView;

@end
@implementation DPDealHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:topLineView];
        
        self.topLineView = topLineView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.font = [UIFont systemFontOfSize:12];
        scoreLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:scoreLabel];
        self.scoreLabel = scoreLabel;
        
        UILabel *distanceLabel = [[UILabel alloc] init];
        distanceLabel.textAlignment = NSTextAlignmentRight;
        distanceLabel.font = [UIFont systemFontOfSize:12];
        //distanceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:distanceLabel];
        self.distanceLabel = distanceLabel;
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:bottomLineView];

        self.bottomLineView = bottomLineView;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTaped)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews]; // 必须先调用父类的方法
    
    self.topLineView.frame = CGRectMake(0, -0.5, self.width, 1);
    
    self.nameLabel.left = kMargin;
    self.nameLabel.top = kMargin;
    [self.nameLabel sizeToFit];
    
    self.scoreLabel.left = kMargin;
    self.scoreLabel.bottom = self.height - kMargin / 2;
    [self.scoreLabel sizeToFit];
    
    self.distanceLabel.right = self.width - kMargin;
    self.distanceLabel.bottom = self.scoreLabel.bottom;
    [self.distanceLabel sizeToFit];
    
    self.bottomLineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
}

- (void)setShop:(DPShop *)shop{
    _shop = shop;
    self.nameLabel.text = shop.shop_name;
    self.scoreLabel.text = @"4.7";
    self.distanceLabel.text = @"100m";
}

- (void)headerTaped{
    if ([self.delegate respondsToSelector:@selector(dealHeaderViewTapped:)]) {
        [self.delegate dealHeaderViewTapped:self.shop];
    }
}

@end
