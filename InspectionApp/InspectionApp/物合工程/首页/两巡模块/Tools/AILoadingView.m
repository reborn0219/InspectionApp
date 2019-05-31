//
//  AILoading.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 2017/8/5.
//  Copyright © 2017年 艾泽鑫. All rights reserved.
//

#import "AILoadingView.h"

@interface AILoadingView ()<CAAnimationDelegate>

@property(nonatomic,strong)CAShapeLayer *loadingLayer;
/** 当前的index*/
@property(nonatomic,assign)NSInteger index;
/** 是否能用*/
@property(nonatomic,assign,getter=isEnable)BOOL enable;
@end
@implementation AILoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _index    = 0;
        _enable   = YES;
        _duration = 2.;
        [self createUI];
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path      = [self cycleBezierPathIndex:_index];
    self.loadingLayer.path  = path.CGPath;
}

- (UIBezierPath*)cycleBezierPathIndex:(NSInteger)index {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height *0.5) radius:CGRectGetWidth(self.bounds) * 0.5 startAngle:index * (M_PI* 2)/3  endAngle:index * (M_PI* 2)/3 + 2*M_PI * 4/3 clockwise:YES];
    return path;
}
- (void)createUI {
    self.loadingLayer             = [CAShapeLayer layer];
    self.loadingLayer.lineWidth   = 2.;
    self.loadingLayer.fillColor   = [UIColor clearColor].CGColor;
    self.loadingLayer.strokeColor = HexRGB(0x46CCD9).CGColor;
    
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    UIBezierPath *path      = [self cycleBezierPathIndex:_index];
    lineLayer.path  = path.CGPath;
    lineLayer.shadowColor = SHADOW_COLOR.CGColor;
    lineLayer.shadowOffset = CGSizeMake(0,0);
    lineLayer.shadowOpacity = 0.2;
    lineLayer.shadowRadius = 2;
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    lineLayer.fillColor   = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:lineLayer];
    [self.layer addSublayer:self.loadingLayer];
    self.loadingLayer.lineCap     = kCALineCapRound;
}
- (void)loadingAnimation {
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue         = @0;
    strokeStartAnimation.toValue           = @1.;
    strokeStartAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *strokeEndAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue           = @.0;
    strokeEndAnimation.toValue             = @1.;
    strokeEndAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.duration            = self.duration * 0.5;
    
    CAAnimationGroup *strokeAniamtionGroup = [CAAnimationGroup animation];
    strokeAniamtionGroup.duration          = self.duration;
    strokeAniamtionGroup.fillMode          = kCAFillModeForwards;
    strokeAniamtionGroup.removedOnCompletion = NO;
    
    strokeAniamtionGroup.delegate          = self;
    strokeAniamtionGroup.animations        = @[strokeEndAnimation,strokeStartAnimation];
    [self.loadingLayer addAnimation:strokeAniamtionGroup forKey:@"strokeAniamtionGroup"];
}

#pragma mark -CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!self.isEnable) {
        return;
    }
    _index++;
//    AILog(@"---用于测试是否循环调用----");
    self.loadingLayer.path                 = [self cycleBezierPathIndex:_index %3].CGPath;
    [self loadingAnimation];
}

#pragma mark -public
- (void)starAnimation {
    if (self.loadingLayer.animationKeys.count > 0) {
        return;
    }
    self.enable = YES;
    [self loadingAnimation];
}
- (void)stopAnimation {
    [self.loadingLayer removeAllAnimations];
    self.enable = NO;
}
- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor                   = strokeColor;
    self.loadingLayer.strokeColor  = strokeColor.CGColor;
}


@end
