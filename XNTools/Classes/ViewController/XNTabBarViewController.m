//
//  XNTabBarViewController.m
//  XNTools
//
//  Created by 罗函 on 2015/5/13.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import "XNTabBarViewController.h"

#pragma mark - XNTabBarItem
@implementation XNTabBarItem

@synthesize badgeColor = _badgeColor;
-  (void)setBadgeColor:(UIColor *)badgeColor {
    _badgeColor = badgeColor;
    if(_xnDelegate && [_xnDelegate respondsToSelector:@selector(setupBadge:)]) {
        [_xnDelegate setupBadge:self];
    }
}

@synthesize badgeValue = _badgeValue;
- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    if(_xnDelegate && [_xnDelegate respondsToSelector:@selector(setupBadge:)]) {
        [_xnDelegate setupBadge:self];
    }
}

@end

#pragma mark - XNTabBarButton
@implementation XNTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if(!(self = [super initWithFrame:frame])) return nil;
    _badgeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _badgeView.backgroundColor = [UIColor colorWithRed:251/255.0 green:87/255.0 blue:88/255.0 alpha:1];
    _badgeView.layer.cornerRadius = 10 / 2;
    _badgeView.layer.borderWidth = 0;
    _badgeView.layer.borderColor = _badgeView.backgroundColor.CGColor;
    _badgeView.hidden = YES;
    [self addSubview:_badgeView];
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _badgeView.frame = CGRectMake(self.bounds.size.width - 10 - 10, 15, 10, 10);
}

@end

#pragma mark - XNTabBarViewController
@interface XNTabBarViewController ()<UITabBarControllerDelegate, XNTabBarItemDelegate> {
    CGRect bulgeButtonRect;
    CGRect bulgeButtonRectOnScreen;
}
@property (nonatomic, weak) XNTabBarItem *bulgeTabBarItem;
@property (nonatomic, strong) XNTabBarButton *bulgeButton;
@property (nonatomic, strong) UIButton *additionButton;
@end

@implementation XNTabBarViewController

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _bulgeIndex = -1;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    self.tabBar.clipsToBounds = NO;
    self.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_bulgeTabBarItem) {
        if(self.style == XNTabBarItemStyleImage) {
            self.bulgeTabBarItem.title = nil;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (XNTabBarButton *)bulgeButton {
    if(!_bulgeButton) {
        _bulgeButton = [XNTabBarButton buttonWithType:(UIButtonTypeCustom)];
        [_bulgeButton addTarget:self action:@selector(clickBulgeButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bulgeButton;
}

- (UIButton *)additionButton {
    if(!_additionButton) {
        _additionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _additionButton.backgroundColor = [UIColor clearColor];
        [_additionButton addTarget:self action:@selector(touchButtonTouchDown) forControlEvents:(UIControlEventTouchDown)];
        [_additionButton addTarget:self action:@selector(touchButtonTouchUpInside) forControlEvents:(UIControlEventTouchUpInside)];
        [_additionButton addTarget:self action:@selector(touchButtonTouchUpOutsideAndCancel) forControlEvents:(UIControlEventTouchUpOutside)];
        [_additionButton addTarget:self action:@selector(touchButtonTouchUpOutsideAndCancel) forControlEvents:(UIControlEventTouchCancel)];
    }
    return _additionButton;
}

- (CABasicAnimation *)tabBarItemAnimation {
    if(!_tabBarItemAnimation) {
        _tabBarItemAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _tabBarItemAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _tabBarItemAnimation.duration = 0.08;
        _tabBarItemAnimation.repeatCount = 1;
        _tabBarItemAnimation.autoreverses = YES;
        _tabBarItemAnimation.fromValue = [NSNumber numberWithFloat:0.8];
        _tabBarItemAnimation.toValue = [NSNumber numberWithFloat:1.2];
    }
    return _tabBarItemAnimation;
}

// 突出按钮的点击事件
- (void)clickBulgeButton:(XNTabBarButton *)button {
    if (!_bulgeButton) return;
    //判断是否被外界拦截
    if (_xnDelegate && [_xnDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        BOOL isSelect = [_xnDelegate tabBarController:self shouldSelectViewController:button.viewController];
        if(!isSelect) return;
    }
    //突出按钮是否可被选中
    if (self.isBulgeSelectEnable) {
        [self setBulgeButtonSelected:YES];
    } else {
        if (self.bulgeButton.selected) {
            self.bulgeButton.selected = NO;
        }
    }
    if (_xnDelegate && [_xnDelegate respondsToSelector:@selector(bulgeButtonDidSelected:)]) {
        [_xnDelegate bulgeButtonDidSelected:self.bulgeButton];
    }
}

- (void)setBulgeButtonSelected:(BOOL)isSelected {
    if(!_bulgeButton) return;
    self.bulgeButton.selected = isSelected;
    if (isSelected) {
        if (_tabBarItemAnimated) {
            [self addAnimationAtTabbarItem:_bulgeTabBarItem];
        }
        self.selectedIndex = self.bulgeTabBarItem.tag;
    }
    //    self.bulgeButton.userInteractionEnabled = !isSelected;
}

- (void)addChildViewController:(UIViewController *)childController {
    if(childController.tabBarItem && [childController.tabBarItem isKindOfClass:[XNTabBarItem class]]) {
        XNTabBarItem *xnTabBarItem = (XNTabBarItem *)childController.tabBarItem;
        xnTabBarItem.viewController = childController;
        xnTabBarItem.tag = self.viewControllers.count;
        if(_bulgeIndex >= 0 && xnTabBarItem.tag == _bulgeIndex) {
            self.bulgeTabBarItem = xnTabBarItem;
            self.bulgeTabBarItem.xnDelegate = self;
        }
    }
    [super addChildViewController:childController];
}

-  (void)setBulgeTabBarItem:(XNTabBarItem *)bulgeTabBarItem {
    [self.bulgeButton setViewController:bulgeTabBarItem.viewController];
    [self.bulgeButton setTitle:bulgeTabBarItem.title];
    [self.bulgeButton setImage:[bulgeTabBarItem.image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]
                      forState:(UIControlStateNormal)];
    [self.bulgeButton setImage:[bulgeTabBarItem.selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]
                      forState:(UIControlStateHighlighted)];
    [self.bulgeButton setImage:[bulgeTabBarItem.selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]
                      forState:(UIControlStateSelected)];
    [self.bulgeButton setHidden:YES];
    [self.tabBar addSubview:self.bulgeButton];
    [self.additionButton setHidden:YES];
    [self.view addSubview:self.additionButton];
    bulgeTabBarItem.image = bulgeTabBarItem.selectedImage = [UIImage new];
    _bulgeTabBarItem = bulgeTabBarItem;
}

- (void)setupBadge:(XNTabBarItem *)xnTabbar {
    if(!xnTabbar.badgeValue || [xnTabbar.badgeValue isEqualToString:@""] || xnTabbar.badgeValue.integerValue <= 0) {
        self.bulgeButton.badgeView.hidden = YES;
    }else{
        self.bulgeButton.badgeView.hidden = NO;
    }
}



- (void)changeRotate:(NSNotification*)noti {
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if(_bulgeTabBarItem && _bulgeTabBarItem.tag == viewController.tabBarItem.tag) {
        return NO;
    }else{
        [self setBulgeButtonSelected:NO];
    }
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(_bulgeTabBarItem && _bulgeTabBarItem.tag == item.tag) {
        return;
    }
    if(!self.isTabBarItemAnimated) return;
    [self addAnimationAtTabbarItem:(XNTabBarItem *)item];
}

- (void)addAnimationAtTabbarItem:(XNTabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if(self.selectedIndex == index) return;
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    [[tabbarbuttonArray[index] layer] addAnimation:self.tabBarItemAnimation forKey:nil];
}

- (void)viewDidLayoutSubviews {
    if(!_bulgeButton) return;
    // 横屏时不显示的bulgeTabBarItem.title，因为横屏时，image在左title在右。
    self.bulgeTabBarItem.title = [UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? _bulgeButton.title : nil;
    CGFloat itemMaximumWidth = [UIScreen mainScreen].bounds.size.width / self.viewControllers.count;
    CGSize  imageSize = self.bulgeButton.imageView.image.size;
    if(CGRectEqualToRect(self.bulgeButton.frame, bulgeButtonRect) || CGSizeEqualToSize(self.bulgeButton.frame.size, CGSizeZero)) {
        CGFloat bulgeOriginX = self.bulgeTabBarItem.tag * itemMaximumWidth + (itemMaximumWidth - imageSize.width) / 2;
        CGFloat bulgeOriginY = self.bulgeOffsetY;
        bulgeButtonRect = CGRectMake(bulgeOriginX, bulgeOriginY, imageSize.width, imageSize.height);
        [self.bulgeButton setHidden:NO];
        [self.bulgeButton setFrame:bulgeButtonRect];
        [self.bulgeButton.superview bringSubviewToFront:self.bulgeButton];
        
        CGRect additionButtonRect = bulgeButtonRect;
        CGRect bulgeRectFromVCView = [self.bulgeButton.imageView convertRect:self.bulgeButton.imageView.frame toView:self.view];
        additionButtonRect.origin.y = bulgeRectFromVCView.origin.y;
        additionButtonRect.size.height = self.tabBar.frame.origin.y - bulgeRectFromVCView.origin.y;
        if(additionButtonRect.size.height >= 2) {
            //            self.additionButton.hidden = NO;
            self.additionButton.frame = additionButtonRect;
            [self.additionButton.superview bringSubviewToFront:self.additionButton];
            [self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        }else{
            //            self.additionButton.hidden = YES;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([object isKindOfClass:[UITabBar class]] && _additionButton) {
        _additionButton.hidden = self.tabBar.hidden;
    }
}

- (void)touchButtonTouchDown {
    self.bulgeButton.selected = YES;
}

- (void)touchButtonTouchUpInside {
    self.bulgeButton.selected = NO;
    [self clickBulgeButton:self.bulgeButton];
}

- (void)touchButtonTouchUpOutsideAndCancel {
    self.bulgeButton.selected = NO;
}

- (void)setTabBarHidden:(id)hidden {
    if (_additionButton) {
        _additionButton.hidden = [hidden boolValue];
    }
}

@end

