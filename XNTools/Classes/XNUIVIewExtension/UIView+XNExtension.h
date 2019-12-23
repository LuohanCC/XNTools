//
//  UIView+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2017/12/9.
//

#import <UIKit/UIKit.h>

@interface UIView (XNExtension)

/**
 设置frame、背景色
 
 @param frame frame
 @param backgroundColor backgroundColor
 */
- (void)setFrame:(CGRect)frame backgroundColor:(UIColor *_Nonnull)backgroundColor;

/**
 添加圆角 UIColor
 
 @param color color
 @param radius radius
 @param width width
 */
- (void)createBordersWithColor:(UIColor * _Nonnull)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width;

/**
 添加圆角 CGColor
 
 @param color color
 @param radius radius
 @param width width
 */
- (void)createBordersWithCGColor:(CGColorRef _Nonnull)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width;

/**
 如果不包含，则添加子控件
 
 @param view 子控件
 */
- (void)addSubviewIfNotContain:(UIView * _Nonnull)view;

/**
 从父控件移除并置空
 
 @param view view
 */
+ (void)removeFromSuperviewAndSetItNil:(UIView *_Nullable)view;

/**
 如果不为空才从父控件移除并置空
 
 @param view view
 @return result
 */
+ (BOOL)removeFromSuperview:(UIView *_Nullable)view;
@end

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end

typedef struct {
    CGFloat top;
    CGFloat bottom;
    CGFloat left;
    CGFloat right;
}XNPadding;

CG_INLINE XNPadding
XNPaddingMake(CGFloat top, CGFloat bottom, CGFloat left, CGFloat right) {
    XNPadding padding = {top, bottom, left, right};
    return padding;
}
CG_INLINE XNPadding
XNPaddingZero() {
    XNPadding padding = {0, 0, 0, 0};
    return padding;
}
