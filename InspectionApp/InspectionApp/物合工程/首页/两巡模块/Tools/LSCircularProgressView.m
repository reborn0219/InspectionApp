//
//  LSCircularProgressView.m
//  物联宝管家
//
//  Created by yang on 2019/4/4.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "LSCircularProgressView.h"
#define LineWith 8
#define RedStarColor HexRGB(0xE64929)
#define RedEndColor HexRGB(0xF48053)
#define BlueStarColor HexRGB(0x4EBEEE)
#define BlueEndColor HexRGB(0x39DEBD)

@interface LSCircularProgressView()
@property(nonatomic,retain)UILabel *numberLb;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,copy)NSString *abnormalTimerDevice;
@property(nonatomic,assign)NSInteger timerTemp;

@end
@implementation LSCircularProgressView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self drawBackGroundLine];
        
    }
    return self;
}

-(void)setProgress:(NSString *)allDevice
        Inspection:(NSString *)inspectionDevice
          Abnormal:(NSString *)abnormalDevice{
    
    _abnormalTimerDevice = inspectionDevice;
    _timerTemp = 0;
    CGFloat inspectionAngle = 2*M_PI*(inspectionDevice.doubleValue/allDevice.doubleValue);
    CGFloat abnormalAngle = 2*M_PI*(abnormalDevice.doubleValue/allDevice.doubleValue);
    
    [_numberLb removeFromSuperview];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    _numberLb = nil;
    [self drawBackGroundLine];
    [self drawInspectionArcInspectionAngle:inspectionAngle abnormalAngle:abnormalAngle];
    [_timer setFireDate:[NSDate distantPast]];  
    
}
-(void)timerAction{
    _timerTemp ++;
    _numberLb.text = [NSString stringWithFormat:@"%d",(int)_timerTemp++];
    if (_timerTemp>=_abnormalTimerDevice.integerValue) {
//        [_timer invalidate];
        _timerTemp = 0;
        _numberLb.text = _abnormalTimerDevice;
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
-(void)drawBackGroundLine{
    
    if (_numberLb==nil) {
        _numberLb = [[UILabel alloc]initWithFrame:self.bounds];
        [_numberLb setTextColor:BLUE_TITLE_COLOR];
        _numberLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLb];
    }
    if (_timer==nil) {
        _timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
  
    self.layer.allowsEdgeAntialiasing = YES;
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width * 0.5 - 15;
    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-2*M_PI endAngle:0 clockwise:YES];
    CAShapeLayer* shapelayer = [CAShapeLayer layer];
    shapelayer.allowsEdgeAntialiasing = YES;
    shapelayer.lineWidth = LineWith;
    shapelayer.strokeColor = HexRGB(0xE8E8E8).CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.path = arcPath.CGPath;
    [self.layer addSublayer:shapelayer];
}

-(void)drawInspectionArcInspectionAngle:(CGFloat)inspectionAngle abnormalAngle:(CGFloat)abnormalAngle
{
    
    [self strokeEndAbnormalAngle:inspectionAngle];
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width * 0.5 - 15;
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.allowsEdgeAntialiasing = YES;
    gradientLayer.frame = self.bounds;
    gradientLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:gradientLayer];
    
    
    
    CAGradientLayer* secondLayer = [CAGradientLayer layer];
    secondLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    secondLayer.colors = @[(id)RedStarColor.CGColor,(id)RedEndColor.CGColor];
//    secondLayer.locations = @[@0,@0.9];
    secondLayer.startPoint = CGPointMake(0.5,1);
    secondLayer.endPoint = CGPointMake(0.5, 0);
    [gradientLayer addSublayer:secondLayer];
    
    
    UIBezierPath* arcPath_1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:abnormalAngle clockwise:YES];
    
    CAShapeLayer* gressLayer = [CAShapeLayer layer];
    gressLayer.lineWidth = LineWith;
    gressLayer.strokeColor = [UIColor blueColor].CGColor;
    gressLayer.fillColor = [UIColor clearColor].CGColor;
    gressLayer.lineCap = @"round";
    gressLayer.path = arcPath_1.CGPath;
    gradientLayer.mask = gressLayer;
    
    
    
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.5;
    [gressLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    
}
-(void)strokeEndAbnormalAngle:(CGFloat)abnormalAngle{
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.allowsEdgeAntialiasing = YES;
    gradientLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:gradientLayer];
    
    CAGradientLayer* firstLayer = [CAGradientLayer layer];
    firstLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    firstLayer.colors = @[(id)BlueStarColor.CGColor,(id)BlueEndColor.CGColor];
//    firstLayer.locations = @[@0.1,@1.0];
    firstLayer.startPoint = CGPointMake(0.5, 1);
    firstLayer.endPoint = CGPointMake(0.5, 0);
    [gradientLayer addSublayer:firstLayer];
    
    
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width * 0.5 - 15;
    UIBezierPath* arcPath_1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle: 0 endAngle:abnormalAngle clockwise:YES];
    
    CAShapeLayer* gressLayer = [CAShapeLayer layer];
    gressLayer.lineWidth = LineWith;
    gressLayer.strokeColor = [UIColor blueColor].CGColor;
    gressLayer.fillColor = [UIColor clearColor].CGColor;
    gressLayer.lineCap = @"round";
    gressLayer.path = arcPath_1.CGPath;
    gradientLayer.mask = gressLayer;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.5;
    [gressLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    
}

@end
