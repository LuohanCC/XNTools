//
//  UIViewController+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/1/6.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "UIViewController+XNExtension.h"
#import <objc/runtime.h>


@implementation UIViewController (XNExtension)

#pragma mark - 【NavigationBar相关方法】
/**
 设置返回按钮：自定义图片+无文字显示, 由首个控制器设置
 
 @param backIndicatorImage 自定义图片
 @param backIndicatorTransitionMaskImage 转场遮罩图片
 @param tintColor 返回按钮的颜色
 */
- (void)setupBackBarButtonItemWithImage:(UIImage *)backIndicatorImage
       backIndicatorTransitionMaskImage:(UIImage *)backIndicatorTransitionMaskImage
                              tintColor:(UIColor *)tintColor {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = tintColor;
    self.navigationController.navigationBar.backIndicatorImage = backIndicatorImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage;
    self.navigationItem.backBarButtonItem = backItem;
}

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
                                     sel:(SEL)sel {
    UIBarButtonItem *leftButton = title ? [[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStylePlain) target:self action:sel] :
    [[UIBarButtonItem alloc] initWithImage:normalImage style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem = leftButton;
}

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
                                     sel:(SEL)sel {
    UIBarButtonItem *rightButton = title ? [[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStylePlain) target:self action:sel] :
    [[UIBarButtonItem alloc] initWithImage:normalImage style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.rightBarButtonItem = rightButton;
}

/**
 设置返回按键颜色、标题颜色与字体
 
 @param tintColor 返回字体颜色
 @param titleColor 标题颜色
 @param titleFont 标题字体
 */
- (void)setupNavigationBarTintColor:(UIColor *)tintColor
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)titleFont {
    self.navigationController.navigationBar.tintColor = tintColor;
    NSDictionary *dic = @{NSFontAttributeName:titleFont, NSForegroundColorAttributeName:titleColor};
    self.navigationController.navigationBar.titleTextAttributes = dic;
}

/**
 设置导航栏背景颜色
 
 @param backgroundColor barTintColor
 */
- (void)setupNavigationBarBackgroundColor:(UIColor *)backgroundColor {
    self.navigationController.navigationBar.barTintColor = backgroundColor;
}

/**
 设置导航栏主题文字颜色

 @param color color
 */
- (void)setupNaviTitleColor:(UIColor *)color {
    NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
    [titleTextAttributes setObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
}


#pragma mark - 【控制器屏幕旋转】
static char XN_UIViewController_AllowRotate;
static char XN_UIViewController_Orientation;
/**
 设置屏幕旋转
 
 @param allowRotate 设置当前控制器是否支持旋转
 @param orientation 屏幕旋转方向
 */
- (void)setAllowRotate:(BOOL)allowRotate orientation:(UIInterfaceOrientationMask)orientation {
    [self setAllowRotate:allowRotate];
    [self setOrientation:orientation];
}

- (void)setAllowRotate:(BOOL)allowRotate {
    objc_setAssociatedObject(self, &XN_UIViewController_AllowRotate, [NSNumber numberWithBool:allowRotate], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setOrientation:(UIInterfaceOrientationMask)orientation {
    objc_setAssociatedObject(self, &XN_UIViewController_Orientation, [NSNumber numberWithUnsignedInteger:orientation], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)allowRotate {
    NSNumber *value = objc_getAssociatedObject(self, &XN_UIViewController_AllowRotate);
    return value ? value.boolValue : NO;
}

- (UIInterfaceOrientationMask)orientation {
    NSNumber *value = objc_getAssociatedObject(self, &XN_UIViewController_Orientation);
    return value ? value.unsignedIntegerValue : UIInterfaceOrientationMaskPortrait;
}

/**
 设置强制旋转
 
 @param interfaceOrientation 旋转方向
 */
- (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // 先重置方向
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    // 强制设置方向
    NSNumber *orientationTarget = [NSNumber numberWithUnsignedInteger:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}

/**
 * 交换屏幕旋转相关方法
 */
- (void)xn_initRotatingControl {
    void (^ExchangeMethodBlock)(NSString *originalMethodStr, SEL exchangeMethodSel) = ^(NSString *originalMethodStr, SEL exchangeMethodSel) {
        Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(originalMethodStr));
        Method exchangeMethod = class_getInstanceMethod([self class], exchangeMethodSel);
        method_exchangeImplementations(exchangeMethod, originalMethod);
    };
    ExchangeMethodBlock(@"shouldAutorotate", @selector(xn_shouldAutorotate));
    ExchangeMethodBlock(@"supportedInterfaceOrientations", @selector(xn_supportedInterfaceOrientations));
    ExchangeMethodBlock(@"preferredInterfaceOrientationForPresentation", @selector(xn_preferredInterfaceOrientationForPresentation));
}

/**
 是否自动旋转

 @return result
 */
- (BOOL)xn_shouldAutorotate {
    return self.allowRotate;
}

/**
 返回支持的方向
 
 @return result
 */
- (NSUInteger)xn_supportedInterfaceOrientations {
    return self.orientation;
}

/**
 这个是返回优先方向

 @return UIInterfaceOrientation
 */
- (UIInterfaceOrientation)xn_preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}



#pragma mark -【控制器遮罩】
static char XN_ViewController_ShadeView;
static char XN_ViewController_CompleteCall;
static char XN_ViewController_ShadeViewAnimationDuration;

- (void)setVcShadeView:(UIView *)shadeView {
    objc_setAssociatedObject(self, &XN_ViewController_ShadeView, shadeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)vcShadeView {
    return objc_getAssociatedObject(self, &XN_ViewController_ShadeView);
}

- (NSTimeInterval)shadeViewAnimationDuration {
    NSNumber *duration = objc_getAssociatedObject(self, &XN_ViewController_ShadeViewAnimationDuration);
    return duration ? duration.floatValue : 0.25f;
}

- (void)addShadeViewWithRect:(CGRect)rect color:(UIColor *)color duration:(NSTimeInterval)duration completeCall:(void(^)(void))completeCall {
    if(self.vcShadeView) {
        [self.vcShadeView removeFromSuperview];
        self.vcShadeView = nil;
    }
    objc_setAssociatedObject(self, &XN_ViewController_CompleteCall, completeCall, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &XN_ViewController_ShadeViewAnimationDuration, @(duration), OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.vcShadeView = [[UIView alloc] initWithFrame:rect];
    self.vcShadeView.backgroundColor = color;
    [self.vcShadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesClick)]];
    self.vcShadeView.alpha = 0.f;
    [self.view.window addSubview:self.vcShadeView];
    [self showShadeView];
}

- (void)showShadeView {
    [UIView animateWithDuration:self.shadeViewAnimationDuration animations:^{
        self.vcShadeView.alpha = 1.f;
    }];
}

- (void)dismissShadeView {
    if(! self.vcShadeView) return;
    void (^CompleteCall)(void)  = objc_getAssociatedObject(self, &XN_ViewController_CompleteCall);
    if(CompleteCall) {
        CompleteCall();
    }
    [UIView animateWithDuration:self.shadeViewAnimationDuration animations:^{
        self.vcShadeView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.vcShadeView removeFromSuperview];
        self.vcShadeView = nil;
    }];
}

- (void)touchesClick {
    [self dismissShadeView];
}

@end
