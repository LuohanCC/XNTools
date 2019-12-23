//
//  AppDelegate.m
//  XNTools
//
//  Created by 罗函 on 12/08/2017.
//  Copyright (c) 2017 罗函. All rights reserved.
//

#import "AppDelegate.h"
#import "XNToolsLogo.h"
#import "TabBarVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor darkGrayColor];
    self.window.rootViewController = [TabBarVC new];
    [self.window makeKeyAndVisible];
    self.isLoading = YES;
    
    if(self.isLoading) {
        _vMask = [[XNToolsLogo alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:_vMask];
        [self performSelector:@selector(logoMaskDismiss) withObject:nil afterDelay:1.f];
    }
    
    return YES;
}

- (void)logoMaskDismiss {
    if(!self.isLoading) return;
    [_vMask addMaskView];
    _vMask.userInteractionEnabled = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.fromValue = @1.0;
    animation.toValue = @1000.0;
    animation.repeatCount = 1;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [animation setValue:animation.toValue forKey:@"scale"];
    [_vMask.layer addAnimation:animation forKey:@"vMaskAnimations"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if(_vMask) {
        [_vMask removeFromSuperview];
        _vMask = nil;
    }
}

@end
