//
//  XNToolsLogo.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/27.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNToolsLogo.h"

@interface XNToolsLogo() {
    CAShapeLayer *layer;
}
@end

@implementation XNToolsLogo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
    
- (instancetype)initWithFrame:(CGRect)frame {
    if(!(self = [super initWithFrame:frame])) return nil;
    self.backgroundColor = [UIColor blackColor];

    return self;
}

- (void)addMaskView {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    [path appendPath:circlePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    //   self.layer.mask = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    self.backgroundColor = [UIColor clearColor];

}

@end
