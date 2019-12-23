//
//  HBButton.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/27.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "HBButton.h"

//圆圈的起始和终点
static const CGFloat HBArcMenuStart = 0.4f;//动画开始时的第一个path点
static const CGFloat HBArcMenuEnd   = 1.0f;//动画结束时，path的点
//线条的起始和终点
static const CGFloat HBArcLineStart = 0.017f;
static const CGFloat HBArcLineEnd   = 0.128f;

@interface HBButton()
@property (nonatomic, strong) CAShapeLayer *topLine;
@property (nonatomic, strong) CAShapeLayer *midLine;
@property (nonatomic, strong) CAShapeLayer *bottomLine;
@property (nonatomic, assign) NSUInteger marginLeftAndRight; //左右边距
@end


@implementation HBButton


- (void)addThreeLayer {
    // 上下两条线
    self.topLine = [self createLineLayer];
    self.bottomLine = [self createLineLayer];
    // 中间的path
    self.midLine = [self createArcPath];
    // 添加属性
    for (CAShapeLayer *layer in @[self.topLine, self.midLine, self.bottomLine]) {
        // 设置基本属性
        layer.fillColor = nil;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = self.lineHeight;
        layer.lineCap = kCALineCapRound; //path两端结尾处绘制半圆
        layer.masksToBounds = YES;
        // 创建一个共享的路径
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapRound,kCGLineJoinMiter, 0);
        layer.bounds = CGPathGetPathBoundingBox(strokingPath);
        layer.actions = @{@"strokeStart":[NSNull null], @"strokeEnd":[NSNull null], @"transform":[NSNull null]};
        // 添加到 layer 上
        [self.layer addSublayer:layer];
        
    }
    
    self.topLine.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - self.distanceFromTheCenter);
    self.bottomLine.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + self.distanceFromTheCenter);
    
    self.midLine.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.midLine.strokeStart = HBArcLineStart;
    self.midLine.strokeEnd = HBArcLineEnd;
}

- (void)setShowsMenu:(BOOL)showsMenu {
    //中间的那条线
    CABasicAnimation *line = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *arc = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    if (showsMenu) {
        //line和arc前半部分动画是重复的，所以为其设置的贝塞尔弹性为一致(0.5,-0.4)
        line.toValue = @(HBArcMenuStart);
        line.duration = self.duration - 0.2;
        line.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.4 :0.5 :1];
        
        arc.toValue = @(HBArcMenuEnd);
        arc.duration = self.duration;
        arc.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.4 :0.5 :1];
    }else {
        line.toValue = @(HBArcLineStart);
        line.duration = self.duration;
        line.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.74 : 0.06 : 0.0 : 1];
        line.beginTime = CACurrentMediaTime() + 0.1;
        line.fillMode = kCAFillModeBackwards;
        
        arc.toValue = @(HBArcLineEnd);
        arc.duration = self.duration;
        arc.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.74 : 0.06 : 0.0 : 1];
    }
    [self addAnimationAtCenterLayer:self.midLine animation:line];
    [self addAnimationAtCenterLayer:self.midLine animation:arc];
    
    //上下两条线
    CATransform3D topTransfrom, bottomTransfrom;
    CGPoint topPosition, bottomPosition;
    CATransform3D translation = CATransform3DMakeTranslation(0, 0, 0);
    if(showsMenu) {
        topPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        topTransfrom = CATransform3DRotate(translation, -M_PI_4, 0, 0, 1);
        bottomPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        bottomTransfrom = CATransform3DRotate(translation, M_PI_4, 0, 0, 1);
    }else{
        topPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - self.distanceFromTheCenter);
        topTransfrom = CATransform3DRotate(translation, 0, 0, 0, 1);
        bottomPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + self.distanceFromTheCenter);
        bottomTransfrom = CATransform3DRotate(translation, 0, 0, 0, 1);
    }
    
    [self addAnimationAtTBLayer:self.topLine transform:topTransfrom position:topPosition];
    [self addAnimationAtTBLayer:self.bottomLine transform:bottomTransfrom position:bottomPosition];

}

- (void)addAnimationAtTBLayer:(CAShapeLayer *)layer transform:(CATransform3D)transform position:(CGPoint)position {
    NSTimeInterval transformDuration = self.duration * 0.7;
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.duration = transformDuration;
    transformAnimation.beginTime = CACurrentMediaTime();
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-1.55 :0.5 :1];
    transformAnimation.toValue = [NSValue valueWithCATransform3D: transform];
    transformAnimation.repeatCount = 1;
    transformAnimation.autoreverses = NO;
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = transformDuration / 2;
    positionAnimation.beginTime = CACurrentMediaTime() + transformDuration /2;
    positionAnimation.toValue   = [NSValue valueWithCGPoint:position];
    positionAnimation.repeatCount = 1;
    positionAnimation.autoreverses = NO;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:transformAnimation forKey:nil];
    [layer addAnimation:positionAnimation forKey:nil];
    
    //动画组无法分别设置动画时间
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration - 0.2;
    group.beginTime = CACurrentMediaTime() + 0.2;
    group.repeatCount = 1;
    group.autoreverses = NO;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[transformAnimation, positionAnimation];
//    [layer addAnimation:group forKey:nil];
}

- (void)addAnimationAtCenterLayer:(CAShapeLayer *)layer animation:(CABasicAnimation *)animation{
    
    if (animation.fromValue == nil) {
        animation.fromValue = [layer.presentationLayer valueForKeyPath:animation.keyPath];
    }
    [layer addAnimation:animation forKey:animation.keyPath];
    // 记住需要重新设置一下，让其达到实现效果
    [layer setValue:animation.toValue forKey:animation.keyPath];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addThreeLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(NSUInteger)lineWidth lineHeight:(NSUInteger)lineHeight distanceFromTheCenter:(NSUInteger)distanceFromTheCenter {
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        _lineHeight = lineHeight;
        _distanceFromTheCenter = distanceFromTheCenter;
        NSLog(@"width:%lu  height:%lu  m:%lu", lineWidth, lineHeight, _distanceFromTheCenter);
        [self addThreeLayer];
    }
    return self;
}

- (NSUInteger)lineWidth {
    return _lineWidth ? _lineWidth : self.bounds.size.width * 0.7;
}

- (NSUInteger)lineHeight {
    return _lineHeight ? _lineHeight : 3;
}

- (NSUInteger)marginLeftAndRight {
    if(!_marginLeftAndRight) {
        _marginLeftAndRight = (self.bounds.size.width - self.lineWidth) / 2;
    }
    return _marginLeftAndRight;
}

- (NSUInteger)distanceFromTheCenter {
    return _distanceFromTheCenter ? _distanceFromTheCenter : 10;
}

- (NSTimeInterval)duration {
    return _duration ? _duration : 0.8;
}

- (CAShapeLayer *)createLineLayer {
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(self.marginLeftAndRight, 0)];
    [path addLineToPoint: CGPointMake(self.lineWidth, 0)];
    CAShapeLayer *line = [CAShapeLayer layer];
    line.path = path.CGPath;
    return line;
}

- (CAShapeLayer *)createArcPath {
    UIBezierPath* arcPath = [UIBezierPath bezierPath];
    [arcPath moveToPoint: CGPointMake(7, 27)];
    [arcPath addLineToPoint: CGPointMake(47, 27)];
    [arcPath addCurveToPoint: CGPointMake(50.19, 25.25) controlPoint1: CGPointMake(48.33, 26.96) controlPoint2: CGPointMake(49.4, 26.38)];
    [arcPath addCurveToPoint: CGPointMake(51.06, 20.38) controlPoint1: CGPointMake(50.98, 24.12) controlPoint2: CGPointMake(51.27, 22.5)];
    [arcPath addCurveToPoint: CGPointMake(44.62, 9.25) controlPoint1: CGPointMake(50.15, 16.5) controlPoint2: CGPointMake(48, 12.79)];
    [arcPath addCurveToPoint: CGPointMake(27, 2) controlPoint1: CGPointMake(39.44, 4) controlPoint2: CGPointMake(32.54, 2)];
    [arcPath addCurveToPoint: CGPointMake(2, 27) controlPoint1: CGPointMake(13.19, 2) controlPoint2: CGPointMake(2, 13.19)];
    [arcPath addCurveToPoint: CGPointMake(27, 52) controlPoint1: CGPointMake(2, 40.81) controlPoint2: CGPointMake(13.19, 52)];
    [arcPath addCurveToPoint: CGPointMake(52, 27) controlPoint1: CGPointMake(40.81, 52) controlPoint2: CGPointMake(52, 40.81)];
    [arcPath addCurveToPoint: CGPointMake(44.62, 9.25) controlPoint1: CGPointMake(52, 21.46) controlPoint2: CGPointMake(50.12, 14.75)];
    [arcPath addCurveToPoint: CGPointMake(27, 2) controlPoint1: CGPointMake(39.54, 4.42) controlPoint2: CGPointMake(33.67, 2)];
    [arcPath addCurveToPoint: CGPointMake(9.38, 9.25) controlPoint1: CGPointMake(20.38, 2) controlPoint2: CGPointMake(14.5, 4.42)];
    [arcPath addCurveToPoint: CGPointMake(2, 27) controlPoint1: CGPointMake(4.46, 14.38) controlPoint2: CGPointMake(2, 20.29)];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.path = arcPath.CGPath;
    return line;
}

@end
