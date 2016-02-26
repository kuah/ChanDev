//
//  ChanPulseView.m
//  PulseLoader
//
//  Created by 陈世翰 on 16/2/25.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "ChanPulseView.h"
@interface ChanPulseView()
/**
 *   起始透明度
 */
@property (nonatomic,assign)CGFloat startAlpha;
/**
 *   结束的透明度
 */
@property (nonatomic,assign)CGFloat endAlpha;

/**
 *   类型
 */
@property (nonatomic,assign)ChanPurlseStyle style;
/**
 *   颜色
 */
@property (nonatomic,strong)UIColor *pulseColor;



@property(nonatomic,strong)CAShapeLayer *pulseLayer;
@end
@implementation ChanPulseView

-(id)initWithFrame:(CGRect)frame withColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        _pulseColor = color;
        [self setUpDefaultValue];
        [self setUp];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame TotalTime:(CGFloat)totalTime PulseCount:(NSInteger)pulseCount PulseCycle:(CGFloat)pulseCycle Mutiple:(CGFloat)multiple StartAlpha:(CGFloat)startAlpha EndtAlpha:(CGFloat)endAlpha Color:(UIColor *)color Style:(ChanPurlseStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        _pulseColor = color;
        _pulseCount = pulseCount;
        _pulseCycle = pulseCycle;
        _multiple = multiple;
        self.alpha = startAlpha;
        _endAlpha = endAlpha;
        _style = style;
        //剔除不正确参数
        [self filterIncorrectValue];
        [self setUp];
    }
    return self;
}

-(void)setUp {
    _isPulsing = NO;
    self.pulseLayer = [[CAShapeLayer alloc]init];
    self.pulseLayer.frame = self.bounds;
    UIBezierPath *pulsePath;
    if (self.style == ChanPurlseStyleRound) {
        pulsePath= [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    }else{
        pulsePath = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    self.pulseLayer.path = pulsePath.CGPath;
    self.pulseLayer.fillColor = _pulseColor.CGColor;
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc]init];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = self.pulseCount;
    replicatorLayer.instanceDelay = self.pulseCycle;
    [replicatorLayer addSublayer:self.pulseLayer];
    self.pulseLayer.opacity = 0.0;
    [self.layer addSublayer:replicatorLayer];
}
-(void)setAlpha:(CGFloat)alpha{
    [super setAlpha:alpha];
    _startAlpha = alpha;
}

-(void)startToPulse {
    _isPulsing = YES;
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[[self alphaAnimation],[self scaleAnimation]];
    groupAnimation.duration = self.totalTime;
    groupAnimation.autoreverses = false;
    groupAnimation.repeatCount = CGFLOAT_MAX;
    [self.pulseLayer addAnimation:groupAnimation forKey:@"pulseAnimation"];
}
-(void)stopPulsingAnimation{
    _isPulsing = NO;
    [self.pulseLayer removeAnimationForKey:@"pulseAnimation"];
}

-(CABasicAnimation *)alphaAnimation{
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(self.startAlpha);
    alphaAnimation.toValue = @(self.endAlpha);
    return alphaAnimation;
}

-(CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t1 = CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0);
    CATransform3D t2 = CATransform3DScale(CATransform3DIdentity, self.multiple, self.multiple, 0.0);
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:t1];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:t2];
    return scaleAnimation;
}
//剔除不正确的参数
-(void)filterIncorrectValue{
    if (_pulseCount<0) {
        _pulseCount = 4;
    }
    if (_pulseCycle<0) {
        _pulseCycle = 0.85;
    }
    if (_totalTime<0) {
        _totalTime = 3.4f;
    }
    if (_multiple<0) {
        _multiple = 8;
    }
    if (self.alpha<0 ||self.alpha>1) {
        self.alpha = 0.5;
    }
    if (_startAlpha<0 ||_startAlpha>1) {
        self.alpha = 0.5;
    }
    if (_endAlpha<0 || _endAlpha>1) {
        _endAlpha = 0;
    }
    
    
}
-(void)setUpDefaultValue{
    self.pulseCount = 4;
    self.pulseCycle = 0.85f;//人体每下心跳的时间
    self.totalTime = 3.4f;
    self.startAlpha = self.alpha;
    self.endAlpha = 0;
    self.multiple = 8;
    self.alpha = 0.5;
}

@end
