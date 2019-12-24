//
//  XNTipsView.m
//  XNTools
//
//  Created by 罗函 on 15/2/6.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import "XNTipsView.h"
#import "../../UIViewExtension/UIImage+XNExtension.h"
#import "../../UIViewExtension/UIView+XNExtension.h"
#import "../../UIViewExtension/UIColor+XNExtension.h"
#import "../../XNConf.h"
#import "../../Utils/XNUtils.h"
#import "../../OS.h"

#define BackgroundColor          [UIColor colorWithRGB:0xFEFEFE]
#define ShadowColor              [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define TextColor                [UIColor colorWithRGB:0x333333]

@implementation XNTipsAction
static struct XNTipsButtonColor defaultButtonBGColor = {0x008080, 0x005A5A};
static struct XNTipsButtonColor cancelButtonBGColor  = {0xF86441, 0xC66E0F};
+ (XNTipsAction *)createActionWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor
                            actionStyle:(XNTipsViewButtonStyle)actionStyle {
    return [XNTipsAction createActionWithTitle:CGRectZero title:title titleColor:titleColor actionStyle:actionStyle];
}

+ (XNTipsAction *)createActionWithTitle:(CGRect)frame
                                  title:(NSString *)title
                             titleColor:(UIColor *)titleColor
                            actionStyle:(XNTipsViewButtonStyle)actionStyle {
    XNTipsAction *button = [[XNTipsAction alloc] initWithFrame:frame];
    [button setStyle:actionStyle];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:titleColor forState:(UIControlStateNormal)];
    struct XNTipsButtonColor color = actionStyle == XNTipsViewButtonStyleDefault ? defaultButtonBGColor : cancelButtonBGColor;
    UIColor *normal = [UIColor colorWithRGB:color.normalHex];
    UIColor *highlighted = [UIColor colorWithRGB:color.highlightedHex];
    [button setBackgroundImage:[UIImage createImageWithUIColor:normal] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage createImageWithUIColor:highlighted] forState:(UIControlStateHighlighted)];
    [button.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:14.f]];
    return button;
}

@end

@interface XNTipsView () <CAAnimationDelegate> {
    float currentScreenWidth;
}
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) UITapGestureRecognizer *touchEvent;
@end

@implementation XNTipsView

- (void)setupSubviews {
    if(self.shaowClickEnable) {
        [self.shadowView addGestureRecognizer:self.touchEvent];
    }
}

- (void)addSubviews {
    WeakSelf
    // 标题部分
    if (_title && _title.length > 0) {
        [self.contentBackgroundView addSubview:self.titleContentView];
        [self.titleContentView addSubview:self.titleLabel];
        [self.titleContentView addSubview:self.titleShadowView];
    }
    // 按钮部分
    if (_actions && _actions.count > 0) {
        [self.contentBackgroundView addSubview:self.actionContentView];
        [self.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XNTipsAction *item = (XNTipsAction *)obj;
            [item addTarget:weakSelf action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [weakSelf.actionContentView addSubview:item];
        }];
        [self.actionContentView addSubview:self.actionShadowView];
    }
    // 内容部分
    if (_message) {
        [self.contentView addSubview:self.textView];
    }
    [self.contentBackgroundView addSubview:self.contentView];
    [self.shadowView addSubview:self.contentBackgroundView];
    UIView *targetView = _targetView ? _targetView : OS.applicationDelegate.window;
    [targetView addSubview:self.shadowView];
}

- (void)updateSubviewFrame {
    float maxDialogHeight = 0.f;
    float dialogHeight = 0.f;
    float dialogWidth = 0.f;
    float screenWidth = OS.screenWidth, screehHeight = OS.screenHeight;
    if (screehHeight > screenWidth) { //竖屏
        maxDialogHeight = screehHeight - XNNaviBarHeight - XNTabbarHeight - 100;
        dialogWidth = screenWidth * 0.8f;
    } else {
        maxDialogHeight = screehHeight * 0.8;
        dialogWidth = screenWidth * 0.6f;
    }
    float titleHeight = 0.f;
    float titleShadowHeight = 0.f;
    float actionHeight = 0.f;
    float actionShadowHeight = 0.f;
    float contentViewHeight = 0.f;
    
    if (_message) {
        float messageWidth = dialogWidth;
        float maxMessageHeight = maxDialogHeight - titleHeight - actionHeight;
        CGSize messageSize = [self.textView sizeThatFits:CGSizeMake(messageWidth, MAXFLOAT)];
        if (messageSize.height > maxMessageHeight) messageSize.height = maxMessageHeight;
        if (messageSize.width < dialogWidth) messageSize.width = dialogWidth;
        self.textView.frame = CGRectMake(0, 0, messageSize.width, messageSize.height);
        contentViewHeight = messageSize.height;
    } else if (_contentView && !CGRectEqualToRect(_contentView.frame, CGRectZero)) {
        dialogWidth = _contentView.width;
        contentViewHeight = _contentView.height;
    }
    
    if (_title) {
        titleHeight = !CGRectEqualToRect(_titleContentView.frame, CGRectZero) ? _titleContentView.height : 40.f;
        titleShadowHeight = !CGRectEqualToRect(_titleShadowView.frame, CGRectZero) ? _titleShadowView.height : 0.5f;
        self.titleContentView.frame = CGRectMake(0, 0, dialogWidth, titleHeight);
        self.titleLabel.center = CGPointMake(self.titleContentView.width/2, self.titleContentView.height/2);
        self.titleShadowView.frame = CGRectMake(0, titleHeight-titleShadowHeight, dialogWidth, titleShadowHeight);
    }
    if (_actions && _actions.count > 0) {
        actionHeight = !CGRectEqualToRect(_actionContentView.frame, CGRectZero) ? _actionContentView.height : 44.f;
        actionShadowHeight = !CGRectEqualToRect(_actionShadowView.frame, CGRectZero) ? _actionShadowView.height : 0.5f;
        self.actionContentView.frame = CGRectMake(0, dialogHeight - actionHeight, dialogWidth, actionHeight);
        self.actionShadowView.frame = CGRectMake(0, 0, dialogWidth, actionShadowHeight);
        float itemWidth = dialogWidth / self.actions.count, itemHeight = actionHeight;
        [self.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XNTipsAction *item = (XNTipsAction *)obj;
            item.frame = CGRectMake(itemWidth * idx, 0, itemWidth, itemHeight);
        }];
    }
    dialogHeight = titleHeight + actionHeight + contentViewHeight;

    self.shadowView.frame = [UIScreen mainScreen].bounds;
    self.contentBackgroundView.frame = CGRectMake((OS.screenHeight-dialogWidth) / 2, (OS.screenHeight-dialogHeight)/2, dialogWidth, dialogHeight);
    self.contentView.frame = CGRectMake(0, titleHeight, dialogWidth, contentViewHeight);
}

/**************************************************Title****************************************************/
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = TextColor;
    }
    return _titleLabel;
}

- (UIView *)titleContentView {
    if (!_titleContentView) {
        _titleContentView = [[UIView alloc] init];
        _titleContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _titleContentView;
}

- (UIView *)titleShadowView {
    if(!_titleShadowView) {
        _titleShadowView = [UIView new];
        _titleShadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _titleShadowView;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

/**************************************************Message****************************************************/
- (UITextView *)textView {
    if(!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.font = [UIFont systemFontOfSize:15.0];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.textColor = TextColor;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 8, 10, 6);
        _textView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _textView.userInteractionEnabled = NO; //默认不可滑动
        _textView.editable = NO;
        [_textView textContainer].lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _textView;
}

- (void)setMessage:(NSString *)message {
    self.textView.text = message;
    //强制断行
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.firstLineHeadIndent = self.textView.font.pointSize * 2;
    NSDictionary *attributes = @{NSFontAttributeName:self.textView.font,
                                 NSForegroundColorAttributeName:self.textView.textColor,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
}

/**************************************************Action****************************************************/
- (UIView *)actionContentView {
    if (!_actionContentView) {
        _actionContentView = [UIView new];
    }
    return _actionContentView;
}

- (UIView *)actionShadowView {
    if(!_actionShadowView) {
        _actionShadowView = [UIView new];
        _actionShadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _actionShadowView;
}

- (void)setActions:(NSArray *)actions {
    _actions = actions;
}

/**************************************************Content****************************************************/
- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [UIView new];
        _contentBackgroundView.clipsToBounds = NO;
    }
    return _contentBackgroundView;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = BackgroundColor;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

-  (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIView new];
        _shadowView.backgroundColor = ShadowColor;
    }
    return _shadowView;
}

+ (XNTipsView *)Instance {
    static XNTipsView *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [self removeNotification];
}

- (void)setup {
    _shaowClickEnable = true;
    _animationDuration = 0.2f;
    _showAnimation = XNTipsViewAnimationScale | XNTipsViewAnimationOpacity;
    _dismissAnimation = XNTipsViewAnimationScale | XNTipsViewAnimationOpacity;
//    _actionItemPadding = XNPaddingMake(6, 6, 6, 6);
    
    self.contentBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentBackgroundView.layer.shadowOffset = CGSizeMake(0,0);
    self.contentBackgroundView.layer.shadowOpacity = 0.5f;
    self.contentBackgroundView.layer.shadowRadius = 8;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.contentView.backgroundColor = color;
}

- (void)handleStatusBarOrientationChange: (NSNotification *)notification{
    if(currentScreenWidth != OS.screenWidth) {
        currentScreenWidth = OS.screenWidth;
        if(_shadowView) {
            [self updateSubviewFrame];
        }
    }
}

- (void)requestNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStatusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITapGestureRecognizer *)touchEvent {
    if(!_touchEvent) {
        _touchEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Action_touchEven:)];
    }
    return _touchEvent;
}

- (float)maximumEffectiveHeightAtScreen {
    return [UIScreen mainScreen].bounds.size.height - XNNaviBarHeight - XNTabbarHeight - 50 * 2;
}

- (CGFloat)getDefaultWidth {
    float minxmumScreenWidth = OS.screenShortEdge;
    return minxmumScreenWidth * 0.8;
}

- (void)show:(NSString *)title message:(NSString *)message {
    [self show:title message:message actionArray:nil];
}

- (void)show:(id)target title:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray {
    self.delegate = target;
    [self show:title message:message actionArray:actionArray];
}

- (void)show:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray completion:(void (^)(NSInteger))completion {
    _ClickedBtnAtIndexBlock = completion;
    [self show:title message:message actionArray:actionArray];
}

- (void)show:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionArray {
    [self setTitle:title];
    [self setMessage:message];
    [self setActions:actionArray];
    [self display];
}

- (void)display {
    WeakSelf
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if(weakSelf.shadowView.superview) {
            [weakSelf.shadowView removeFromSuperview];
            [[weakSelf.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [weakSelf setupSubviews];
        [weakSelf addSubviews];
        [weakSelf updateSubviewFrame];
        [weakSelf setShowing:YES];
        [weakSelf requestNotification];
    }];
}

- (void)btnAction:(XNTipsAction *)action {
    __block NSUInteger index = 0;
    [self.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == action) {
            index = idx;
            *stop = true;
        }
    }];
    if(_ClickedBtnAtIndexBlock) {
        _ClickedBtnAtIndexBlock(index);
    } else if(self.delegate && [self.delegate respondsToSelector:@selector(clickeTipsActionAtIndex:)]) {
        [self.delegate clickeTipsActionAtIndex:index];
    } else {
        if(action.style == XNTipsViewButtonStyleCancel) {
            [self dismiss];
        }
    }
}

- (void)setActionsLocked:(NSArray <NSNumber *>*)btnIndex isLocked:(BOOL)isLocked; {
    for (NSNumber *number in btnIndex) {
        NSInteger index = number.integerValue;
        if(index < self.actions.count){
            [((XNTipsAction *)[self.actions objectAtIndex:index]) setEnabled:isLocked];
        }
    }
}

#pragma mark - Window的遮罩层
- (void)Action_touchEven:(UITapGestureRecognizer *)touch {
    [self dismiss];
}

- (void)dismiss {
//    [self showTipsView:NO];
    [self setShowing:NO];

    if(_delegate && [_delegate respondsToSelector:@selector(tipsDidDismiss)]) {
        [_delegate tipsDidDismiss];
    }
}

- (void)showShadowView {
    WeakSelf
    if(_showAnimation != XNTipsViewAnimationNone) {
        [UIView animateWithDuration:_animationDuration animations:^{
            weakSelf.shadowView.alpha = 1.f;
        } completion:^(BOOL finished) {
            weakSelf.shadowView.alpha = 1.f;
        }];
    }else{
        _shadowView.alpha = 1.f;
    }
}

- (void)removeShadowView:(BOOL)isNoAnimation {
    WeakSelf
    if(!isNoAnimation && _dismissAnimation != XNTipsViewAnimationNone) {
        [UIView animateWithDuration:_animationDuration animations:^{
            weakSelf.shadowView.alpha = 0.f;
        } completion:^(BOOL finished) {
            weakSelf.shadowView.alpha = 0.f;
            [self removeAllSubViews];
        }];
    }else{
        [self removeAllSubViews];
    }
}

- (void)removeAllSubViews {
    if(self.shadowView.superview) {
        [_shadowView removeFromSuperview];
    }
    if (_contentBackgroundView) {
        //        _contentView.alpha = 1.0;
        [[_contentBackgroundView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_contentBackgroundView removeFromSuperview];
    }
    if (_actionContentView) {
        [[_actionContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_actionContentView removeFromSuperview];
    }
    [self removeNotification];
}

//动画相关
- (BOOL)ifAnimatingOfDisplayContain:(XNTipsViewAnimation)animation {
    return (_showAnimation & animation) == animation;
}

- (BOOL)ifAnimatingOfDismissContain:(XNTipsViewAnimation)animation {
    return (_dismissAnimation & animation) == animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    //    for(CAAnimation *an in animationGroup.animations) {
    //        NSValue *position = [an valueForKey:@"position"];
    //        NSNumber *scale = [an valueForKey:@"scale"];
    //        NSNumber *opacity = [an valueForKey:@"opacity"];
    //        if(position) {
    //            self.contentView.layer.position = position.CGPointValue;
    //        }
    //        else if(scale) {
    //            self.contentView.layer.contentsScale = scale.floatValue;
    //        }
    //        else if(opacity) {
    ////            self.contentView.layer.opacity = opacity.floatValue;
    //        }
    //    }
}

- (void)setShowing:(BOOL)showing {
    if (_showing == showing) return;
    _showing = showing;
    NSMutableArray *animations = [NSMutableArray new];
    NSString *animationKey = nil;
    if(showing) {
        animationKey = @"groupAnnimation_show";
        if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationLanding]) {
            [animations addObject:[self verticalAnimation:YES isFromCenterY:NO]];
        }
        else if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationAscend]) {
            [animations addObject:[self verticalAnimation:NO isFromCenterY:NO]];
        }
        else if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationFromLeftToRight]) {
            [animations addObject:[self horizontalAnimation:YES isFromCenterX:NO]];
        }
        else if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationFromRightToLeft]) {
            [animations addObject:[self horizontalAnimation:NO isFromCenterX:NO]];
        }
        if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationScale]) {
            [animations addObject:[self scaleAnimation:NO]];
        }
        if([self ifAnimatingOfDisplayContain:XNTipsViewAnimationOpacity]) {
            [animations addObject:[self opacityAnimation:NO]];
        }
        [self showShadowView];
    } else {
        animationKey = @"groupAnnimation_dismiss";
        if([self ifAnimatingOfDismissContain:XNTipsViewAnimationLanding]) {
            [animations addObject:[self verticalAnimation:YES isFromCenterY:YES]];
        }
        else if([self ifAnimatingOfDismissContain:XNTipsViewAnimationAscend]) {
            [animations addObject:[self verticalAnimation:NO isFromCenterY:YES]];
        }
        else if([self ifAnimatingOfDismissContain:XNTipsViewAnimationFromLeftToRight]) {
            [animations addObject:[self horizontalAnimation:YES isFromCenterX:YES]];
        }
        else if([self ifAnimatingOfDismissContain:XNTipsViewAnimationFromRightToLeft]) {
            [animations addObject:[self horizontalAnimation:NO isFromCenterX:YES]];
        }
        if([self ifAnimatingOfDismissContain:XNTipsViewAnimationScale]) {
            [animations addObject:[self scaleAnimation:YES]];
        }
        if([self ifAnimatingOfDismissContain:XNTipsViewAnimationOpacity]) {
            [animations addObject:[self opacityAnimation:YES]];
        }
        [self removeShadowView:NO];
    }
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = _animationDuration;
    animationGroup.repeatCount = 1;
    animationGroup.autoreverses = NO;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = animations;
    [self.contentBackgroundView.layer removeAllAnimations];
    [self.contentBackgroundView.layer addAnimation:animationGroup forKey:animationKey];
}

- (CABasicAnimation *)horizontalAnimation:(BOOL)isFromLeft isFromCenterX:(BOOL)isFromCenterX {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = _animationDuration;
    CGPoint sPoint, ePoint;
    UIView *v = self.contentBackgroundView;
    CGRect frame = self.contentBackgroundView.frame;
    if(isFromLeft) {
        sPoint = CGPointMake(isFromCenterX ? v.center.x : -(frame.size.width/2) , v.center.y);
        ePoint = CGPointMake(isFromCenterX ? OS.screenWidth+frame.size.width/2 : v.center.x , v.center.y);
    }else{
        sPoint = CGPointMake(isFromCenterX ? v.center.x : OS.screenWidth+frame.size.width/2 , v.center.y);
        ePoint = CGPointMake(isFromCenterX ? -(frame.size.width/2) : v.center.x , v.center.y);
    }
    moveAnimation.fromValue = [NSValue valueWithCGPoint:sPoint];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:ePoint];
    [moveAnimation setValue:moveAnimation.toValue forKey:@"position"];
    return moveAnimation;
}

- (CABasicAnimation *)verticalAnimation:(BOOL)isLanding isFromCenterY:(BOOL)isFromCenterY {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = _animationDuration;
    CGPoint sPoint, ePoint;
    UIView *v = self.contentBackgroundView;
    CGRect frame = self.contentBackgroundView.frame;
    if(isLanding) {
        sPoint = CGPointMake(v.center.x , isFromCenterY ? v.center.y : -(frame.size.height/2));
        ePoint = CGPointMake(v.center.x , isFromCenterY ? OS.screenHeight+frame.size.height/2 : v.center.y);
    }else{
        sPoint = CGPointMake(v.center.x , isFromCenterY ? v.center.y : OS.screenHeight + frame.size.height/2);
        ePoint = CGPointMake(v.center.x , isFromCenterY ? -(frame.size.height/2) : v.center.y);
    }
    moveAnimation.fromValue = [NSValue valueWithCGPoint:sPoint];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:ePoint];
    [moveAnimation setValue:moveAnimation.toValue forKey:@"position"];
    return moveAnimation;
}

- (CABasicAnimation *)scaleAnimation:(BOOL)isFromCenter {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = _animationDuration;
    animation.fromValue = isFromCenter ? @1.0f : @0.5f;
    animation.toValue = isFromCenter ? @0.5f : @1.0f;
    [animation setValue:animation.toValue forKey:@"scale"];
    return animation;
}

- (CABasicAnimation *)opacityAnimation:(BOOL)isFromCenter{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = _animationDuration;
    animation.fromValue = isFromCenter ? @1.f : @0.f;
    animation.toValue = isFromCenter ? @0.f : @1.f;
    [animation setValue:animation.toValue forKey:@"opacity"];
    return animation;
}

@end
