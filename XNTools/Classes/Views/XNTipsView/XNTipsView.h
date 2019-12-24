//
//  XNTipsView.h
//  XNTools
//
//  Created by 罗函 on 15/2/6.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XN_TIPS [XNTipsView Instance]

typedef NS_ENUM(NSUInteger, XNTipsViewButtonStyle) {
    XNTipsViewButtonStyleDefault,
    XNTipsViewButtonStyleCancel
};

typedef NS_ENUM(NSUInteger, XNTipsViewAnimation) {
    XNTipsViewAnimationNone             = 0,      // 无动画
    XNTipsViewAnimationLanding          = 1 << 0, // 从下面上升
    XNTipsViewAnimationAscend           = 1 << 1, // 从上面降落
    XNTipsViewAnimationFromLeftToRight  = 1 << 2, // 从左边出现
    XNTipsViewAnimationFromRightToLeft  = 1 << 3, // 从右边出现
    XNTipsViewAnimationScale            = 1 << 4, // 缩放动画
    XNTipsViewAnimationOpacity          = 1 << 5  // 渐隐渐现
};

struct XNTipsButtonColor {
    unsigned int normalHex;
    unsigned int highlightedHex;
};

@interface XNTipsAction : UIButton
@property (nonatomic, assign) XNTipsViewButtonStyle style;

+ (XNTipsAction *)createActionWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor
                            actionStyle:(XNTipsViewButtonStyle)actionStyle;
@end


@protocol XNTipsViewDelegate <NSObject>
@optional
- (void)clickeTipsActionAtIndex:(NSInteger)index;
- (void)tipsDidDismiss;
@end

@interface XNTipsView : NSObject
@property (nonatomic, readwrite, copy) void (^ClickedBtnAtIndexBlock)(NSInteger);
@property (nonatomic, weak) id <XNTipsViewDelegate> delegate;
// Animations
@property (nonatomic, assign) XNTipsViewAnimation showAnimation; /* XNTipsViewAnimationScale | XNTipsViewAnimationOpacity */
@property (nonatomic, assign) XNTipsViewAnimation dismissAnimation; /* XNTipsViewAnimationScale | XNTipsViewAnimationOpacity */
@property (nonatomic, assign) CFTimeInterval animationDuration; /* 0.25f */
@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;
// titleView
@property (nonatomic, assign) CGFloat titleViewHeight;/* 默认40像素, label写死22像素 */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *titleContentView;
@property (nonatomic, strong) UIView  *titleShadowView;
// messangeView
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentBackgroundView;
@property (nonatomic, strong) UITextView *textView;
// actionView
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) UIView *actionContentView;
@property (nonatomic, strong) UIView *actionShadowView;
// shadow info
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, assign) BOOL shaowClickEnable;/* 点击背景区域自动消失，默认YES */
@property (nonatomic, weak) UIView *targetView;


+ (XNTipsView *)Instance;

/**
 * 标题 + 内容
 */
- (void)show:(NSString *)title message:(NSString *)message;
/**
 标题 + 内容 + 按钮
 */
- (void)show:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray;
/**
 * 传入代理、标题 + 内容 + 按钮
 */
- (void)show:(id)target title:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray;
/**
 * 传入Block、标题 + 内容 + 按钮
 */
- (void)show:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray completion:(void (^)(NSInteger))completion;
/**
 * dismiss
 */
- (void)dismiss;
/**
 * 锁定Action
 */
- (void)setActionsLocked:(NSArray <NSNumber *>*)btnIndex isLocked:(BOOL)isLocked;
/**
 * 重置所有设置
 */
- (void)setup;

- (void)setBackgroundColor:(UIColor *)color;

@end
