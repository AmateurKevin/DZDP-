//
//  DPDetailHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/7/7.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "DPArrowRotateTipView.h"
#import "DPDeal.h"
#import "DPCircleLabel.h"
#define screenW [UIScreen mainScreen].bounds.size.width
@interface DPDetailHeaderView ()<UIScrollViewDelegate>

@property(nonatomic,strong) DPArrowRotateTipView *tipView;

@property (weak, nonatomic)  UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *dealTitle;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet DPCircleLabel *pageLabel;

@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;

@property (weak, nonatomic) IBOutlet UIView *gradientView;

@end

@implementation DPDetailHeaderView

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
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    
    self.scrollView = scrollView;
}

+ (instancetype)detailHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPDetailHeaderView" owner:nil options:nil] lastObject];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _gradientView.bounds;
    
    UIColor *opaqueBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    UIColor *transparentBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    gradient.colors = [NSArray arrayWithObjects:(id)opaqueBlackColor.CGColor,(id)transparentBlackColor.CGColor, nil];
    [_gradientView.layer insertSublayer:gradient atIndex:0];
    
    self.scrollView.frame = CGRectMake(0, 0, screenW, self.frame.size.height);
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    
    self.scrollView.contentSize = CGSizeMake(imageURLs.count * screenW + 1, 0);
   
    for (NSInteger i = 0; i < imageURLs.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * screenW, 0, screenW, self.frame.size.height)];
        [self.scrollView addSubview:imageView];
        
    [imageView sd_setImageWithURL:imageURLs[i] placeholderImage:[UIImage imageNamed:@"common_loading_big"]];

        
    }
    
    DPArrowRotateTipView *tipView = [DPArrowRotateTipView arrowRotateTipView];
    tipView.frame = CGRectMake(imageURLs.count * screenW, 0, screenW, self.frame.size.height);
    [self.scrollView addSubview:tipView];
    self.tipView = tipView;
    [self bringSubviewToFront:self.dealTitle];
    [self bringSubviewToFront:self.descLabel];
    [self bringSubviewToFront:self.pageLabel];
    [self bringSubviewToFront:self.gradientView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / screenW + 1.5;
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",page,self.imageURLs.count];
    CGFloat beginX = (self.imageURLs.count - 1) * screenW + 30;
   
    CGFloat endX =  (self.imageURLs.count - 1) * screenW + 60;
    if (offsetX <= beginX) {
        self.tipView.angle = 0;
    }else if(offsetX > endX){
        self.tipView.angle = M_PI;
    }else{
        self.tipView.angle = M_PI * (offsetX - beginX)/30;
    }
}

- (void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    self.dealTitle.text = deal.min_title;
    self.descLabel.text = deal.desc;
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",1,self.imageURLs.count];
    self.saleNumLabel.text = [NSString stringWithFormat:@"已售%d",deal.sale_num.intValue];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.contentOffset.x > (self.imageURLs.count - 1) * screenW + 60){
        if ([self.delegate respondsToSelector:@selector(detailHeaderViewPushOtherController)]) {
            [self.delegate detailHeaderViewPushOtherController];
        }
    }
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef maskedImageRef = CGImageCreateWithMask([image CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    
    CGImageRelease(mask);
    CGImageRelease(maskedImageRef);
    
    // returns new image with mask applied
    return maskedImage;
}


@end
