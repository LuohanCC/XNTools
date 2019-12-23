//
//  XNNavigationController.h
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UINavigationBar+Extension.h"

@interface XNNavigationController : UINavigationController

//@property (nonatomic, retain) NSMutableArray *naviColors;

//@property (nonatomic, retain) UIColor *lastNavColor;

//@property (nonatomic, retain) UIColor *currentNavColor;

//@property (nonatomic, assign) CGFloat lastloctionx;

//@property (nonatomic, assign) NSInteger currentvisiblevcIndex;
//@property (nonatomic, weak) UIViewController *currentvisiblevc;

//- (void)endPanAction:(NSInteger)currentIndex;

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navColor:(UIColor *)navColor;
- (void)setNavigationBarTextAttributeName:(UIColor *)color font:(UIFont *)font;
@end
