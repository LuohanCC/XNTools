//
//  UIViewController+XNExtension
//  XNTools
//
//  Created by 罗函 on 2018/1/6.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XNExtension)

#pragma mark - 【NavigationBar相关方法】
/**
 设置返回按钮：自定义图片+无文字显示, 由首个控制器设置
 
 @param backIndicatorImage 自定义图片
 @param backIndicatorTransitionMaskImage 转场遮罩图片
 @param tintColor 返回按钮的颜色
 */
- (void)setupBackBarButtonItemWithImage:(UIImage *)backIndicatorImage
       backIndicatorTransitionMaskImage:(UIImage *)backIndicatorTransitionMaskImage
                              tintColor:(UIColor *)tintColor;
/**
 设置返回按键颜色、标题颜色与字体
 
 @param tintColor 返回字体颜色
 @param titleColor 标题颜色
 @param titleFont 标题字体
 */
- (void)setupNavigationBarTintColor:(UIColor *)tintColor
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)titleFont;

/**
 设置导航栏右边的按钮：
 
 @param title 文字
 @param normalImage 默认状态下的图片
 @param selectImage 高亮状态下的图片
 @param sel 方法监听
 */
- (void)setupLeftBarButtonItemWithTitle:(NSString *)title
                             normalImage:(UIImage *)normalImage
                             selectImage:(UIImage *)selectImage
                                    sel:(SEL)sel;

/**
 设置导航栏右边的按钮：
 
 @param title 文字
 @param normalImage 默认状态下的图片
 @param selectImage 高亮状态下的图片
 @param sel 方法监听
 */
- (void)setupRightBarButtonItemWithTitle:(NSString *)title
                             normalImage:(UIImage *)normalImage
                             selectImage:(UIImage *)selectImage
                                     sel:(SEL)sel;

/**
 设置导航栏背景颜色
 
 @param backgroundColor barTintColor
 */
- (void)setupNavigationBarBackgroundColor:(UIColor *)backgroundColor;

/**
 设置导航栏主题文字颜色
 
 @param color color
 */
- (void)setupNaviTitleColor:(UIColor *)color;

#pragma mark - 【控制器屏幕旋转】
/**
 设置屏幕旋转。步骤如下：
 1.交换控制器旋转相关方法：[vc xn_initRotatingControl];
 2.开启旋转并、旋转方向：[vc setAllowRotate:YES orientation:UIInterfaceOrientationMaskAll];
 3.旋转后需要调整的视图代码
 4.关闭控制器旋转：[vc setAllowRotate:YES];
 
 @param allowRotate 设置当前控制器是否支持旋转
 @param orientation 屏幕旋转方向
 */
- (void)setAllowRotate:(BOOL)allowRotate orientation:(UIInterfaceOrientationMask)orientation;
- (void)setAllowRotate:(BOOL)allowRotate;

/**
 * 交换屏幕旋转相关方法
 */
- (BOOL)allowRotate;
- (UIInterfaceOrientationMask)orientation;
- (void)xn_initRotatingControl;

/**
 强制设置旋转
 
 @param interfaceOrientation 旋转方向
 */
- (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

#pragma mark -【控制器遮罩】

/**
 添加控制器遮罩
 
 @param rect 遮罩位置
 @param color 遮罩颜色
 @param duration 遮罩动画时长
 @param completeCall 遮罩消失后的回调
 */
- (void)addShadeViewWithRect:(CGRect)rect color:(UIColor *)color duration:(NSTimeInterval)duration completeCall:(void(^)(void))completeCall;

/**
 移除遮罩
 */
- (void)dismissShadeView;
@end
