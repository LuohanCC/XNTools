//
//  ViewController.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/9.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNTipsVC.h"
#import <XNTools/UIImage+XNExtension.h>
#import "XNUtils.h"
#import <XNTools/XNTipsView.h>
#import <XNTools/UIView+XNExtension.h>
#import <XNTools/UIColor+XNExtension.h>
#import "UIImage+XNExtension.h"
#import <Lottie/Lottie.h>

@interface XNTipsVC () <XNTipsViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn01;
@property (weak, nonatomic) IBOutlet UIButton *btn02;
@property (weak, nonatomic) IBOutlet UIButton *btn03;
@property (strong, nonatomic)LOTAnimationView *lottie;

@property (nonatomic, strong) XNTipsAction *cancelButton;
@property (nonatomic, strong) XNTipsAction *otherButton;
@property (nonatomic, strong) XNTipsAction *readButton;
@end

@implementation XNTipsVC

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_VC_BG;
    self.title = @"XNTipsView";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_btn01 createBordersWithColor:[UIColor clearColor] withCornerRadius:6 andWidth:0];
    [_btn02 createBordersWithColor:[UIColor clearColor] withCornerRadius:6 andWidth:0];
    [_btn03 createBordersWithColor:[UIColor clearColor] withCornerRadius:6 andWidth:0];
    
    
    void (^SetupBtns)(UIButton *button) = ^(UIButton *button){
        [button setBackgroundImage:[UIImage createImageWithUIColor:[UIColor grayColor]] forState:(UIControlStateNormal)];
        [button setBackgroundImage:[UIImage createImageWithUIColor:[UIColor colorWithRGB:0xB22222]] forState:(UIControlStateSelected)];
        [button createBordersWithColor:[UIColor clearColor] withCornerRadius:4 andWidth:0];
    };
    
    for (int i=0; i<6; i++) {
        UIButton *button = [self.view viewWithTag:2000 + i];
        SetupBtns(button);
        [button addTarget:self action:@selector(showAnimationChange:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    for (int i=0; i<6; i++) {
        UIButton *button = [self.view viewWithTag:3000 + i];
        SetupBtns(button);
        [button addTarget:self action:@selector(dismissAnimationChange:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    _cancelButton = [XNTipsAction createActionWithTitle:@"取消"
                                             titleColor:[UIColor whiteColor]
                                            actionStyle:(XNTipsViewButtonStyleCancel)];
    _otherButton  = [XNTipsAction createActionWithTitle:@"确定"
                                             titleColor:[UIColor whiteColor]
                                            actionStyle:(XNTipsViewButtonStyleDefault)];
    _readButton   = [XNTipsAction createActionWithTitle:@"朗读"
                                             titleColor:[UIColor whiteColor]
                                            actionStyle:(XNTipsViewButtonStyleDefault)];
    [_readButton setBackgroundImage:[UIImage createImageWithUIColor:[UIColor colorWithRGB:0xB22222]] forState:(UIControlStateNormal)];
    [_readButton setBackgroundImage:[UIImage createImageWithUIColor:[UIColor colorWithRGB:0x800000]] forState:(UIControlStateHighlighted)];
    
    XN_TIPS.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)showAnimationChange:(UIButton *)button {
    [self changeButtonsStatusWithBaseTag:2000 button:button];
    XNTipsViewAnimation animation = [self animationWithButtonBaseTag:2000];
    XN_TIPS.showAnimation = animation;
}

- (void)dismissAnimationChange:(UIButton *)button {
    [self changeButtonsStatusWithBaseTag:3000 button:button];
    XNTipsViewAnimation animation = [self animationWithButtonBaseTag:3000];
    XN_TIPS.dismissAnimation = animation;
}

- (void)changeButtonsStatusWithBaseTag:(NSUInteger)baseTag button:(UIButton *)button {
    if(button.tag-baseTag < 4) {
        for(int i=0; i<4; i++) {
            UIButton *b = [self.view viewWithTag:baseTag + i];
            if(b.tag == button.tag) {
                button.selected = !button.selected;
            }else{
                b.selected = NO;
            }
        }
    }else{
        button.selected = !button.selected;
    }
}

- (XNTipsViewAnimation)animationWithButtonBaseTag:(NSUInteger)baseTag {
    __block XNTipsViewAnimation animation = XNTipsViewAnimationNone;
    void (^SetupAnimation)(XNTipsViewAnimation a) = ^(XNTipsViewAnimation a){
        if(animation == XNTipsViewAnimationNone) {
            animation = a;
        }else{
            animation = animation | a;
        }
    };
    for (int i=0; i<6; i++) {
        UIButton *button = [self.view viewWithTag:baseTag + i];
        if(i == 0) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationLanding);
                i = 3;
            }
        }
        else if(i == 1) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationAscend);
                i = 3;
            }
        }
        else if(i == 2) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationFromLeftToRight);
                i = 3;
            }
        }
        else if(i == 3) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationFromRightToLeft);
            }
        }
        else if(i == 4) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationScale);
            }
        }
        else if(i == 5) {
            if(button.selected) {
                SetupAnimation(XNTipsViewAnimationOpacity);
            }
        }
    }
    return animation;
}

- (IBAction)btnClick01:(id)sender {
    [XN_TIPS.textView setUserInteractionEnabled:true];
    [XN_TIPS setBackgroundColor:[UIColor colorWithRGB:0x333333]];
    XN_TIPS.titleLabel.textColor = [UIColor colorWithRGB:0xFFFFFF];
    XN_TIPS.textView.textColor = [UIColor colorWithRGB:0xFFFFFF];
    [XN_TIPS show:@"Warning"
          message:@"[App] if we're in the real pre-commit handler we can't actually add any new fences due to CA restriction"
      actionArray:@[_cancelButton, _otherButton]];
}

- (IBAction)btnClick02:(id)sender {
    [XN_TIPS.textView setUserInteractionEnabled:true];
    [XN_TIPS setBackgroundColor:[UIColor colorWithRGB:0xFEFEFE]];
    XN_TIPS.titleLabel.textColor = [UIColor colorWithRGB:0x333333];
    XN_TIPS.textView.textColor = [UIColor colorWithRGB:0x333333];
    [XN_TIPS show:@"今日要闻"
          message:[self news]
      actionArray:@[_cancelButton, _readButton, _otherButton]];
}

- (IBAction)btnClick03:(id)sender {
    [XN_TIPS.textView setUserInteractionEnabled:true];
    XN_TIPS.titleContentView.backgroundColor = [UIColor colorWithRGB:0xFF8C00];
    [XN_TIPS show:@"OC Code" message:nil actionArray:nil];
    [self.lottie play];
}

- (void)tipsDidDismiss {
    if(_lottie) {
        [self.lottie stop];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self tipsDidDismiss];
}


- (LOTAnimationView *)lottie {
    if(!_lottie) {
        _lottie = [LOTAnimationView animationNamed:@"empty_list"];
//        _lottie.frame = CGRectMake(0, 0, [XN_TIPS defaultWidth], 150);
        _lottie.contentMode = UIViewContentModeScaleAspectFill;
        _lottie.backgroundColor = [UIColor colorWithRGB:0x008B8B];
        [_lottie setLoopAnimation:YES];
    }
    return _lottie;
}

- (UITextView *)customView {
    UITextView *vText = [[UITextView alloc] initWithFrame:CGRectZero];
    vText.backgroundColor = [UIColor clearColor];
    vText.font = [UIFont systemFontOfSize:7.0];
    vText.textColor = [UIColor whiteColor];
    vText.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    vText.showsVerticalScrollIndicator = YES;
    vText.userInteractionEnabled = YES; //默认不可滑动
    vText.backgroundColor = [UIColor colorWithRGB:0x5F9EA0];
    vText.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    vText.text = [self text];
    return vText;
}

- (NSString *)text {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"xntipsCodeHeader" ofType:@"txt"];
    NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"");
    return dataFile;
}

- (NSString *)news {
    return @"市场闻风而动，那些曾经放款门槛低到只要一张身份证就可以的网贷、分期购平台，纷纷收紧而停止放贷，那些因为各种原因落入多头借贷陷阱的借款人开始大面积逾期，随之而来的催收风暴里，屡屡传出有人因为不堪暴力催收而轻生的消息。\r\n网贷平台上，不管是现金贷还是消费分期，年化利率直逼36%的不在少数，更有一些转化到线下交易的私贷，收取的“手续费”更是高达40%甚至50%，这也是网贷饱受诟病的地方。\r\n钛媒体影像《在线》多地走访，花了数月时间深入接触借款人、催收人、放款公司。对很多人来说，接触网贷的那一天起，他们的命运就注定发生了变化；当监管到来时，他们的命运和生活再次发生变化。可是未来呢，他们已无暇顾及，眼下最好的生活就是“得过且过”吧。\r\n市场闻风而动，那些曾经放款门槛低到只要一张身份证就可以的网贷、分期购平台，纷纷收紧而停止放贷，那些因为各种原因落入多头借贷陷阱的借款人开始大面积逾期，随之而来的催收风暴里，屡屡传出有人因为不堪暴力催收而轻生的消息。\r\n网贷平台上，不管是现金贷还是消费分期，年化利率直逼36%的不在少数，更有一些转化到线下交易的私贷，收取的“手续费”更是高达40%甚至50%，这也是网贷饱受诟病的地方。\r\n钛媒体影像《在线》多地走访，花了数月时间深入接触借款人、催收人、放款公司。对很多人来说，接触网贷的那一天起，他们的命运就注定发生了变化；当监管到来时，他们的命运和生活再次发生变化。可是未来呢，他们已无暇顾及，眼下最好的生活就是“得过且过”吧。\r\n市场闻风而动，那些曾经放款门槛低到只要一张身份证就可以的网贷、分期购平台，纷纷收紧而停止放贷，那些因为各种原因落入多头借贷陷阱的借款人开始大面积逾期，随之而来的催收风暴里，屡屡传出有人因为不堪暴力催收而轻生的消息。\r\n网贷平台上，不管是现金贷还是消费分期，年化利率直逼36%的不在少数，更有一些转化到线下交易的私贷，收取的“手续费”更是高达40%甚至50%，这也是网贷饱受诟病的地方。\r\n钛媒体影像《在线》多地走访，花了数月时间深入接触借款人、催收人、放款公司。对很多人来说，接触网贷的那一天起，他们的命运就注定发生了变化；当监管到来时，他们的命运和生活再次发生变化。可是未来呢，他们已无暇顾及，眼下最好的生活就是“得过且过”吧。\r\n市场闻风而动，那些曾经放款门槛低到只要一张身份证就可以的网贷、分期购平台，纷纷收紧而停止放贷，那些因为各种原因落入多头借贷陷阱的借款人开始大面积逾期，随之而来的催收风暴里，屡屡传出有人因为不堪暴力催收而轻生的消息。\r\n网贷平台上，不管是现金贷还是消费分期，年化利率直逼36%的不在少数，更有一些转化到线下交易的私贷，收取的“手续费”更是高达40%甚至50%，这也是网贷饱受诟病的地方。\r\n钛媒体影像《在线》多地走访，花了数月时间深入接触借款人、催收人、放款公司。对很多人来说，接触网贷的那一天起，他们的命运就注定发生了变化；当监管到来时，他们的命运和生活再次发生变化。可是未来呢，他们已无暇顾及，眼下最好的生活就是“得过且过”吧。";
}

@end
