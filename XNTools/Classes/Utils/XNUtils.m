//
//  Utils.m
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "XNUtils.h"
#import <objc/message.h>
#import <sys/utsname.h>
#import <Foundation/Foundation.h>


#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation XNUtils


/**
 交换方法
 
 @param class mainClass
 @param originalMethodStr 原方法
 @param exchangeMethodSel 新方法
 */
+ (void)exchangeMethod:(Class)class originalMethodStr:(NSString *)originalMethodStr exchangeMethod:(SEL)exchangeMethodSel {
    Method originalMethod = class_getInstanceMethod(class, NSSelectorFromString(originalMethodStr));
    Method exchangeMethod = class_getInstanceMethod(class, exchangeMethodSel);
    /**
     *  在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，就可以对其进行交换了。
     */
    if (!class_addMethod(class, exchangeMethodSel, method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod))) {
        method_exchangeImplementations(exchangeMethod, originalMethod);
    }
}

/**
 获取随机数
 
 @param from minNumber
 @param to maxNumber
 @return randomNumber
 */
+ (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 根据nibName获取Nib
 
 @param target target
 @param nibName nibName
 @return Nib
 */
+ (UINib *)nibWithClassAndName:(id)target nibName:(NSString *)nibName {
    UINib *nb = nil;
#ifdef isFramework
    NSBundle *bundle = [NSBundle bundleForClass:[target class]];
    nb = [UINib nibWithNibName:nibName bundle:bundle];
#else
    nb = [UINib nibWithNibName:nibName bundle:nil];
#endif
    return nb;
}

/**
 在主线程执行一个闭包

 @param block block
 */
+ (void)runOnMainQueue:(void (^)(void))block {
    dispatch_async(dispatch_get_main_queue(), block);
}

/**
 在子线程执行一个闭包
 
 @param block block
 */
+ (void)runOnGlobalQueue:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(0, 0), block);
}

/**
 获取图片缩略图
 
 @param image 原图
 @return 缩略图
 */
+ (UIImage *)cutImage:(UIImage *)image {
    UIImage *thumbnail = nil;
    if (image.size.height>image.size.width){
        thumbnail = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage],CGRectMake(0,fabs(image.size.height - image.size.width)/2.0, image.size.width, image.size.width))];
    } else {
        thumbnail = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage],CGRectMake(fabs(image.size.height - image.size.width)/2.0,0, image.size.height, image.size.height))];
    }
    return thumbnail;
}

/**
 获取顶层控制器
 
 @return vc
 */
+ (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 获取设备的名称
 
 @return displayName
 */
+ (NSString *)getDeviceSystemName {
    static dispatch_once_t one;
    static NSString *name;
    struct utsname systemInfo;
    uname(&systemInfo);
    dispatch_once(&one, ^{
        NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
        if (!model) return;
        NSDictionary *dic = @{
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              @"iPhone10,1" : @"iPhone 8",
                              @"iPhone10,4" : @"iPhone 8",
                              @"iPhone10,2" : @"iPhone 8 Plus",
                              @"iPhone10,5" : @"iPhone 8 Plus",
                              @"iPhone10,3" : @"iPhone X",
                              @"iPhone10,6" : @"iPhone X",
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,4" : @"iPhone XS Max",
                              @"iPhone11,6" : @"iPhone XS Max",
                              @"iPhone11,8" : @"iPhone XR",
                              
                              @"iPod1,1" : @"iPod Touch 1G",
                              @"iPod2,1" : @"iPod Touch 2G",
                              @"iPod3,1" : @"iPod Touch 3G",
                              @"iPod4,1" : @"iPod Touch 4G",
                              @"iPod5,1" : @"iPod Touch 5G",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2",
                              @"iPad2,2" : @"iPad 2",
                              @"iPad2,3" : @"iPad 2",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad Mini 1",
                              @"iPad2,6" : @"iPad Mini 1",
                              @"iPad2,7" : @"iPad Mini 1",
                              @"iPad3,1" : @"iPad 3",
                              @"iPad3,2" : @"iPad 3",
                              @"iPad3,3" : @"iPad 3",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad Mini 2",
                              @"iPad4,5" : @"iPad Mini 2",
                              @"iPad4,6" : @"iPad Mini 2",
                              @"iPad4,7" : @"iPad Mini 3",
                              @"iPad4,8" : @"iPad Mini 3",
                              @"iPad4,9" : @"iPad Mini 3",
                              @"iPad5,1" : @"iPad Mini 4",
                              @"iPad5,2" : @"iPad Mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro 9.7",
                              @"iPad6,4" : @"iPad Pro 9.7",
                              @"iPad6,7" : @"iPad Pro 12.9",
                              @"iPad6,8" : @"iPad Pro 12.9",
                              
                              @"i386"   : @"iPhone Simulator",
                              @"x86_64" : @"iPhone Simulator",
                              };
        if ([dic.allKeys containsObject:model]) {
            name = dic[model];
        } else {
            name = model;
        }
    });
    return name;
}

/**
 判断刘海屏(iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等)
 
 UIView中的safeAreaInsets如果是刘海屏就会发生变化，普通屏幕safeAreaInsets恒等于UIEdgeInsetsZero
 @return 返回YES表示是刘海屏
 */
+ (BOOL)isNotchScreen {
    CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
                break;
            case UIInterfaceOrientationLandscapeRight:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
    } else {
        // Fallback on earlier versions
        return false;
    }
    return iPhoneNotchDirectionSafeAreaInsets > 20;
}

/**
 判断是否是iPad
 
 @return 是/否
 */
+ (BOOL)isIPad {
    NSString *deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPad"];
}

/**
 判断是否是iPhone
 
 @return 是/否
 */
+ (BOOL)isIPhone {
    NSString *deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}

/**
 判断是否是IPod touch
 
 @return 是/否
 */
+ (BOOL)isIPodTouch {
    NSString *deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPod touch"];
}

+ (BOOL)isRightToLeft {
    NSString *country = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    if ([UIView appearance].semanticContentAttribute == UISemanticContentAttributeForceRightToLeft ||
        [@"ar" isEqual:country]) {
        return YES;
    }
    return NO;
}

+ (void)showPresentViewController:(UIViewController *)vc root:(UIViewController *)root {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([root isKindOfClass:UINavigationController.class]) {
            [((UINavigationController *)root).visibleViewController presentViewController:vc animated:YES completion:nil];
//            [((UINavigationController *)root) pushViewController:vc animated:YES];
        } else {
            [root presentViewController:vc animated:YES completion:nil];
        }
    }];
}
+ (void)pushViewController:(UIViewController *)vc {
    UIViewController *root = [XNUtils appRootViewController];
    if ([root isKindOfClass:UINavigationController.class]) {
        [((UINavigationController *)root) pushViewController:vc animated:YES];
    } else {
        if (root.navigationController) {
            [root.navigationController pushViewController:vc animated:YES];
        } else {
            [root presentViewController:vc animated:YES completion:nil];
        }
    }
}

+ (BOOL)isWiFiEnabled {
    NSCountedSet * cset = [[NSCountedSet alloc] init];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
      for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
      if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
        [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
//    return YES;
}

unsigned long GetTickCount() {
    struct timespec ts;
    if (@available(iOS 10.0, *)) {
        clock_gettime(CLOCK_MONOTONIC, &ts);
    } else {
        // Fallback on earlier versions
    }
    return (unsigned long)(ts.tv_sec * 1000 + ts.tv_nsec / 1000000);//ms
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)style {
    if (style == UIStatusBarStyleDefault) {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    } else {
        [UIApplication sharedApplication].statusBarStyle = style;
    }
}
@end
