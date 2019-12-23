//
//  XNLottieVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/29.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNLottieVC.h"
#import <Lottie/Lottie.h>

@interface XNLottieVC ()
@property (nonatomic, strong) LOTAnimationView *lottie01;
@property (nonatomic, strong) LOTAnimationView *lottie02;

@end

@implementation XNLottieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"路径动画";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.lottie01];
    [self.view addSubview:self.lottie02];
}

- (LOTAnimationView *)lottie01 {
    if(!_lottie01) {
        _lottie01 = [LOTAnimationView animationNamed:@"animation"];
        _lottie01.contentMode = UIViewContentModeScaleAspectFill;
        [_lottie01 setLoopAnimation:YES];
    }
    return _lottie01;
}

- (LOTAnimationView *)lottie02 {
    if(!_lottie02) {
        _lottie02 = [LOTAnimationView animationNamed:@"animation2"];
        _lottie02.contentMode = UIViewContentModeScaleAspectFill;
        [_lottie02 setLoopAnimation:YES];
    }
    return _lottie02;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat w = (self.view.frame.size.height - XNNaviBarHeight )/ 2;
    self.lottie01.frame = CGRectMake((self.view.bounds.size.width-w)/2, XNNaviBarHeight, w, w);
    self.lottie02.frame = CGRectMake((self.view.bounds.size.width-w)/2, XNNaviBarHeight + self.lottie01.frame.size.height + 20, w, w);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottie01 play];
    [self.lottie02 play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottie01 pause];
    [self.lottie02 pause];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
