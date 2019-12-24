//
//  Utils.h
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNUtils : NSObject

/**
 交换方法
 
 @param class mainClass
 @param originalMethodStr 原方法
 @param exchangeMethodSel 新方法
 */
+ (void)exchangeMethod:(Class)class originalMethodStr:(NSString *)originalMethodStr exchangeMethod:(SEL)exchangeMethodSel;

/**
 获取随机数
 
 @param from minNumber
 @param to maxNumber
 @return randomNumber
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 根据nibName获取Nib
 
 @param target target
 @param nibName nibName
 @return Nib
 */
+ (UINib *)nibWithClassAndName:(id)target nibName:(NSString *)nibName;

/**
 在主线程执行一个闭包
 
 @param block block
 */
+ (void)runOnMainQueue:(void (^)(void))block;

/**
 在子线程执行一个闭包
 
 @param block block
 */
+ (void)runOnGlobalQueue:(void (^)(void))block;

/**
 获取图片缩略图
 
 @param image 原图
 @return 缩略图
 */
+ (UIImage *)cutImage:(UIImage *)image;

/**
 获取顶层控制器
 
 @return vc
 */
+ (UIViewController *)appRootViewController;

/**
 获取设备的名称
 
 @return displayName
 */
+ (NSString *)getDeviceSystemName;

/**
 判断刘海屏(iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等)
 
 UIView中的safeAreaInsets如果是刘海屏就会发生变化，普通屏幕safeAreaInsets恒等于UIEdgeInsetsZero
 @return 返回YES表示是刘海屏
 */
+ (BOOL)isNotchScreen;

/**
 判断是否是iPad
 
 @return 是/否
 */
+ (BOOL)isIPad;

/**
 判断是否是iPhone
 
 @return 是/否
 */
+ (BOOL)isIPhone;

/**
 判断是否是IPod touch
 
 @return 是/否
 */
+ (BOOL)isIPodTouch;
+ (BOOL)isRightToLeft;

+ (void)showPresentViewController:(UIViewController *)vc root:(UIViewController *)root;
+ (void)pushViewController:(UIViewController *)vc;
+ (BOOL)isWiFiEnabled;
+ (void)setStatusBarStyle:(UIStatusBarStyle)style;

unsigned long GetTickCount(void);
@end
