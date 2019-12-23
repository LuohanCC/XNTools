//
//  UIResponder+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/5/9.
//

#import <Foundation/Foundation.h>

@interface UIResponder (XNExtension)<UIApplicationDelegate>

#pragma mark - 屏幕旋转
- (BOOL)allowRotateEnable;
- (UIInterfaceOrientationMask)orientation;

/**
 AppDelegate中重写方法applicationsupportedInterfaceOrientationsForWindow，并返回该方法
 
 @param application application
 @param window window
 @return UIInterfaceOrientationMask
 */
- (UIInterfaceOrientationMask)xn_application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window;


/**
 需要切换屏幕方向的控制器中[XNAppDelegate setSupportedInterfaceOrientationsForWindow:UIInterfaceOrientationMaskAllButUpsideDown];

 @param orientation orientation
 */
- (void)setSupportedInterfaceOrientationsForWindow:(UIInterfaceOrientationMask)orientation;

/**
 在设备方向不变的情况下强制旋转屏幕

 @param interfaceOrientation interfaceOrientation
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
