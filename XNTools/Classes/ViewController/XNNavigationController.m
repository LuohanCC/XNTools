//
//  XNNavigationController.m
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "XNNavigationController.h"

@interface XNNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
//自定义的手势
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
@property (nonatomic, assign) SEL sel;

@end

@implementation XNNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
//        self.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavigationBarTextAttributeName:(UIColor *)color font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font, NSForegroundColorAttributeName:color};
    self.navigationBar.titleTextAttributes = dic;
}

//- (void)viewDidLayoutSubviews{
//    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 11.0) return;
//    UINavigationItem * item = self.navigationItem;
//    NSArray * array = item.leftBarButtonItems;
//    if (array&&array.count!=0){
//        UIBarButtonItem * buttonItem=array[0];
//        UIView *v = buttonItem.customView.superview;
//        while (v && [v isKindOfClass:[UIView class]]) {
//            v = v.superview;
//            if(v.frame.origin.x > 10) {
//                CGRect frame = v.frame;
//                frame.origin.x = 0;
//                v.frame = frame;
//            }
//        }
//    }
//}
@end
