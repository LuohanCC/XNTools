//
//  XNHamburgerButtonVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/28.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNHamburgerButtonVC.h"
#import "HamburgerButton.h"
#import "HBButton.h"
#import <UIView+XNExtension.h>

@interface XNHamburgerButtonVC () {
    NSUInteger disForCenter;
    NSUInteger lineWidth;
    NSUInteger lineHeight;
}
@property (nonatomic, strong) HamburgerButton *hamburgerButton;
@property (nonatomic, strong) HBButton *xnHBButton;

@end

@implementation XNHamburgerButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VC_BG;
    self.title = @"XNHamBurgerButton";
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.hamburgerButton];
    disForCenter = 10;
    lineWidth = 40;
    lineHeight = 3;
    
    [self.view addSubview:self.xnHBButton];
}

- (HBButton *)xnHBButton {
    if(!_xnHBButton) {
        CGFloat w = 60;
//        _xnHBButton = [[HBButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - w)/2, 200, w, w)];
        _xnHBButton = [[HBButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - w)/2, 200, w, w) lineWidth:lineWidth lineHeight:lineHeight distanceFromTheCenter:disForCenter];
        [_xnHBButton addTarget:self action:@selector(hbAction:) forControlEvents:UIControlEventTouchUpInside];
        [_xnHBButton createBordersWithColor:[UIColor clearColor] withCornerRadius:4 andWidth:0];
        _xnHBButton.backgroundColor = [UIColor colorWithRGB:0xCD5C5C];
    }
    return _xnHBButton;
}

- (void)removeHBButton {
    if(_xnHBButton) {
        [_xnHBButton removeFromSuperview];
        _xnHBButton = nil;
    }
}

- (void)hbAction:(HBButton *)button {
    button.selected = !button.selected;
    button.showsMenu = button.selected;
}

- (HamburgerButton *)hamburgerButton {
    if (!_hamburgerButton) {
        CGFloat w = 52;
        _hamburgerButton = [[HamburgerButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - w)/2, 100, w, w)];
        [_hamburgerButton addTarget:self action:@selector(hamburgerAction:) forControlEvents:UIControlEventTouchUpInside];
        _hamburgerButton.backgroundColor = [UIColor redColor];
    }
    return _hamburgerButton;
}
- (void)hamburgerAction:(HamburgerButton *)button {
    button.selected = !button.selected;
    button.showsMenu = button.selected;
}
//动画时长
- (IBAction)clickSlider04:(UISlider *)sender {
    float value = (float)sender.value;
    if(_xnHBButton.duration != value) {
        _xnHBButton.duration = value;
    }
}
//离中线的距离
- (IBAction)clickSlider03:(UISlider *)sender {
    NSUInteger value = (int)sender.value;
    if(disForCenter != value) {
        disForCenter = value;
        [self removeHBButton];
        [self.view addSubview:self.xnHBButton];
    }
}
//线宽
- (IBAction)clickSlider02:(UISlider *)sender {
    NSUInteger value = (int)sender.value;
    if(lineWidth != value) {
        lineWidth = value;
        [self removeHBButton];
        [self.view addSubview:self.xnHBButton];
    }
}
//线高
- (IBAction)clickSlider:(UISlider *)sender {
    NSUInteger value = (int)sender.value;
    if(lineHeight != value) {
        lineHeight = value;
        [self removeHBButton];
        [self.view addSubview:self.xnHBButton];
    }
}
@end
