//
//  XNViewController.m
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "XNViewController.h"
#import "UIColor+XNExtension.h"
#import "UIViewController+XNExtension.h"

@interface XNViewController ()
@end

@implementation XNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //控制相关的初始化
    [self initialization];
    //初始化子视图
    [self initSubviews];
}

- (void)initialization {
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:244/255.0 blue:248/255.0 alpha:1];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 11.0) {
        self.automaticallyAdjustsScrollViewInsets = false; //IOS 11中已被遗弃
    }
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setupBackBarButtonItemWithImage:[UIImage imageNamed:@"ico_nav_back.png"]
         backIndicatorTransitionMaskImage:[UIImage imageNamed:@"ico_nav_back.png"]
                                tintColor:[UIColor blackColor]];
    /*
    self.navigationController.navigationBar.translucent = NO;
    [self setupNavigationBarBackgroundColor:[UIColor colorWithRGB:0xe16531]];
    [self setupNavigationBarTintColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:19.f]];
     */
}

- (void)setTransparentNavigationBar:(BOOL)enable {
    UIImage *image = nil, *shadowImage = nil;
    if (enable) {
        image = [[UIImage alloc] init];
        shadowImage = [[UIImage alloc] init];
    }
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
}

- (void)initSubviews { }

@end

