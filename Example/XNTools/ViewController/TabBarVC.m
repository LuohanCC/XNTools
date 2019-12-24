//
//  TabBarVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2018/2/6.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "TabBarVC.h"
#import "Page1VC.h"
#import "Page2VC.h"
#import <XNTools/XNViewController.h>
#import <XNTools/XNNavigationController.h>
#import "OS.h"

@interface TabBarVC ()<XNTabBarViewControllerDelegate>

@end

@implementation TabBarVC

- (instancetype)init {
    if(!(self = [super init])) return nil;
    self.xnDelegate = self;
    
    CGRect rect = CGRectMake(0, 0, OS.screenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRGB:0x777777 alpha:0.1].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    self.bulgeIndex = 1;
    self.bulgeOffsetY = -24;
    self.bulgeSelectEnable = YES;
    self.tabBarItemAnimated = YES;
    //    self.style = XNTabBarItemStyleImage;
    //vc01
    Page1VC *vc01 = [[Page1VC alloc] initWithStyle:(UITableViewStyleGrouped)];
    XNViewController *vc02 = [XNViewController new];
    Page2VC *vc03 = [[Page2VC alloc] initWithStyle:(UITableViewStyleGrouped)];
    
    NSArray *titles = nil, *images = nil, *selectImages = nil;
    titles = @[@"视图类", @"XNTabBarVC", @"工具类"];
    images = @[@"img_tabbar_01", @"img_tabbar_bulge", @"img_tabbar_03"];
    selectImages = @[@"img_tabbar_01_select", @"img_tabbar_bulge", @"img_tabbar_03_select"];
    [self initTabbarViewController:@[vc01, vc02, vc03] titles:titles images:images selImages:selectImages];
    
    return self;
}

- (void)initTabbarViewController:(NSArray *)vcArray titles:(NSArray *)titles images:(NSArray *)images  selImages:(NSArray *)selImages {
    if(vcArray && titles && images && selImages) {
        for (int i = 0; i<vcArray.count; i++) {
            UIViewController *vc = vcArray[i];
            XNTabBarItem *item = [[XNTabBarItem alloc] initWithTitle:titles[i]
                                                               image:[XNImage(images[i]) imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]
                                                       selectedImage:[XNImage(selImages[i]) imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]
                                  ];
            self.tabBar.tintColor = [UIColor colorWithRGB:0x000000];
            item.tag = i;
            vc.tabBarItem = item;
            XNNavigationController *navi = [[XNNavigationController alloc] initWithRootViewController:vc];
            [navi setNavigationBarTextAttributeName:[UIColor redColor] font:[UIFont systemFontOfSize:17.f]];
            [self addChildViewController:navi];
            
        }
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if([viewController isKindOfClass:[XNNavigationController class]]) {
        XNNavigationController *navi = ((XNNavigationController *)viewController);
        if([navi.viewControllers.firstObject isKindOfClass:[XNViewController class]]) {
//            NSLog(@"拦截");
//            return NO;
        }
    }
    return YES;
}

@end
