//
//  XNProgressAnimatedView.h
//  XNHUD, https://github.com/XNHUD/XNHUD
//
//  Copyright (c) 2016 Tobias Tiemerding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNProgressAnimatedView : UIView

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeEnd;

@end
