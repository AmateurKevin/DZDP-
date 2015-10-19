//
//  DPCircleButton.m
//  DZDP
//
//  Created by nickchen on 15/10/18.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCircleButton.h"

@interface DPCircleButton ()

@property(nonatomic,strong) CAShapeLayer *spinerLayer;

@end

@implementation DPCircleButton


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
    [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    //[self setFrame:CGRectMake(160-54, 50, 54, 54)];
    self.height = 54;
    self.width = 54;
    //[self setBackgroundImage:[UIImage imageNamed:@"] forState:UIControlStateNormal];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 27;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)clicked:(UIButton *)button{
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.cornerRadius = self.height / 2;
        [self startSpinerAnimation];
    } completion:^(BOOL finished) {
        
    }];
}

- (CAShapeLayer *)spinerLayer{
    if (!_spinerLayer) {
        _spinerLayer = [CAShapeLayer layer];
        CGFloat radius = 100;//(self.height / 2) * 0.5;
       
        _spinerLayer.frame = CGRectMake(0, 0, self.height, self.height);
        CGPoint center = self.center;
        CGFloat startAngle = 0 - M_PI_2;
        CGFloat endAngle = M_PI * 2 - M_PI_2;
        
        _spinerLayer.path = (__bridge CGPathRef _Nullable)([UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:true]);
        
        
        _spinerLayer.fillColor = nil;
        _spinerLayer.strokeColor = [UIColor redColor].CGColor;
        _spinerLayer.lineWidth = 1;
        
        _spinerLayer.strokeEnd = 0.4;
        _spinerLayer.hidden = true;
        [self.layer addSublayer:_spinerLayer];

    }
    return _spinerLayer;
}

- (void)startSpinerAnimation{
//    self.spinerLayer.hidden = false;
//    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotate.fromValue = @0;
//    rotate.toValue = @(M_PI * 2);
//    rotate.duration = 0.4;
//    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    rotate.repeatCount = HUGE;
//    rotate.fillMode = kCAFillModeForwards;
//    rotate.removedOnCompletion = false;
//    [_spinerLayer addAnimation:rotate forKey:rotate.keyPath];
}

@end
