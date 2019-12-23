//
//  UINavigationController+autoHidesTabBarWhenPushed.m
//  XNTools
//
//  Created by LuohanCC on 2016/11/18.
//  Copyright © 2016年 LuohanCC. All rights reserved.
//

#import "UINavigationController+autoHidesTabBarWhenPushed.h"
#import "XNUtils.h"
#import <objc/message.h>

@interface UINavigationController () <UINavigationControllerDelegate>
@end

@implementation UINavigationController (hidesBottomBarWhenPushed)

+ (void)load {
    [UINavigationController autoHidesTabBarWhenPushed];
}

+ (void)autoHidesTabBarWhenPushed {
    [XNUtils exchangeMethod:[self class]
          originalMethodStr:@"initWithRootViewController:"
             exchangeMethod:@selector(initWithRootViewControllerAndSetupAutoHidesTabbar:)];
    [XNUtils exchangeMethod:[self class]
          originalMethodStr:@"pushViewController:animated:"
             exchangeMethod:@selector(pushViewControllerAndHidesTabbar:animated:)];
}

- (instancetype)initWithRootViewControllerAndSetupAutoHidesTabbar:(UIViewController *)rootViewController {
    UINavigationController *nav = [self initWithRootViewControllerAndSetupAutoHidesTabbar:rootViewController];
    nav.delegate = self;
    return nav;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1) {
        [self hiddenTabBar:@NO];
    }
}

- (void)pushViewControllerAndHidesTabbar:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.delegate isEqual:self]) {
        if (self.viewControllers.count > 0 ) {
            //使用系统的隐藏方法，会直接跟随改VC向左运动至消失，无法实现向下消失的动画
            //[viewController setHidesBottomBarWhenPushed:YES];
            [self hiddenTabBar:@YES];
        }
    } else {
        NSLog(@"The NavigationController delegate is not it self.");
    }
    [self pushViewControllerAndHidesTabbar:viewController animated:animated];
}

- (void)hiddenTabBar:(id)hidden {
    if(!self.tabBarController) return;
    SEL faSelector = NSSelectorFromString(@"setTabBarHidden:");
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.tabBarController performSelector:faSelector withObject:hidden];
    #pragma clang diagnostic pop
}
@end
