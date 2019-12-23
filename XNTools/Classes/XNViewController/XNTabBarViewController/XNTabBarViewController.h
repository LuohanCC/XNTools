//
//  XNTabBarViewController.h
//  XNTools
//
//  Created by 罗函 on 2015/5/13.
//  Copyright © 2015年 罗函. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XNTabBarItemStyle)  {
    XNTabBarItemStyleTextAndImage,
    XNTabBarItemStyleImage
};

#pragma mark - XNTabBarItem
@class XNTabBarItem;
@protocol XNTabBarItemDelegate <NSObject>
- (void)setupBadge:(XNTabBarItem *)xnTabbar;
@end
@interface XNTabBarItem : UITabBarItem <UITabBarDelegate>
@property (nonatomic, weak) id<XNTabBarItemDelegate> xnDelegate;
@property (nonatomic, weak) UIViewController *viewController;
@end

#pragma mark - XNTabBarButton
@interface XNTabBarButton : UIButton
// IOS11后，横屏时，title和image呈左右分布，所以在切换横屏时，突出的XNTabBarItem的title需要置为nil，使用这个属性来保存XNTabBarItem.title
@property (nonatomic, strong) NSString *title;
// 突出的XNTabBarItem的badgeView只能显示一个小红点，不展示具体消息数量
@property (nonatomic, strong) UIView *badgeView;
// 保存与之关联的控制器，拦截XNTabBarButton的点击事件时需要传入该控制器（clickBulgeButton: -> tabBarController:shouldSelectViewController:）
@property (nonatomic, weak) UIViewController *viewController;
@end

#pragma mark - XNTabBarViewController
@class XNTabBarViewController;
@protocol XNTabBarViewControllerDelegate <UITabBarControllerDelegate>
- (void)bulgeButtonDidSelected:(XNTabBarButton *)button;
@end
@interface XNTabBarViewController : UITabBarController
@property (nonatomic, weak) id<XNTabBarViewControllerDelegate> xnDelegate;
@property (nonatomic, readonly) XNTabBarButton *bulgeButton;
// 突出的UITabBarItem是否可被选中
// 使用场景:不可被选中时一般是弹出Model控制器，可被选中时与其他UITabBarItem一样对应一个控制器
@property (nonatomic, assign, getter=isBulgeSelectEnable) BOOL bulgeSelectEnable;
// 需要突出的下标
@property (nonatomic, assign) NSInteger bulgeIndex;
// 文字+图片/仅图片
@property (nonatomic, assign) XNTabBarItemStyle style;
// 向上突出的偏移量
@property (nonatomic, assign) NSInteger bulgeOffsetY;
// 开启UITabBarItem动画
@property (nonatomic, assign, getter=isTabBarItemAnimated) BOOL tabBarItemAnimated;
// 自定义UITabBarItem动画（默认为transform.scale动画）
@property (nonatomic, strong) CABasicAnimation *tabBarItemAnimation;

@end

