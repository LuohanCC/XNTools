//
//  XNRefreshController.m
//  XNTools_Example
//
//  Created by 罗函 on 2018/2/8.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "XNRefreshController.h"
#import <XNProgressHUD/XNProgressHUD.h>
#import <XNProgressHUD/XNRefreshView.h>
#import "UIViewController+XNProgressHUD.h"

@interface XNRefreshController ()
@property (weak, nonatomic) IBOutlet XNRefreshView *refreshView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISwitch *switchDelay;
@property (nonatomic, assign) NSTimeInterval delayResponse;
@property (nonatomic, assign) NSTimeInterval delayDismiss;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maskType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *display;

@end

@implementation XNRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"XNProgressHUD";
    
    _refreshView.tintColor = [UIColor colorWithRGB:0xe16531];
    _refreshView.lineWidth = 4.f;
    _refreshView.label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    _refreshView.style = XNRefreshViewStyleProgress;
 
    [[XNProgressHUD shared] setPosition:CGPointMake(XNScreenWidth/2, XNScreenHeight * 0.7)];
    [[XNProgressHUD shared] setTintColor:[UIColor colorWithRGB:0x0A5591 alpha:0.7]];
    
    [self.hud setPosition:CGPointMake(XNScreenWidth/2, XNScreenHeight * 0.7)];
//    [self.hud setTintColor:[UIColor colorWithRGB:0x0A5591 alpha:0.7]];
    [self.hud setTintColor:[UIColor colorWithRGB:0x263238 alpha:0.8]];
    [self.hud setRefreshStyle:(XNRefreshViewStyleProgress)];
    [self.hud setMaskType:(XNProgressHUDMaskTypeBlack)  hexColor:0x00000044];
    [self.hud setMaskType:(XNProgressHUDMaskTypeCustom) hexColor:0xff000044];
    
    _delayResponse = 1.0f;
    _delayDismiss = 3.f;
}

- (IBAction)actionCustomView:(UISwitch *)sender {
    XNRefreshView *refreshView = (XNRefreshView *)self.hud.refreshView;
    if(sender.on) {
        [refreshView setInfoImage:[UIImage imageNamed:@"ico_xnprogresshud_info.png"]];
        [refreshView setErrorImage:[UIImage imageNamed:@"ico_xnprogresshud_error.png"]];
        [refreshView setSuccessImage:[UIImage imageNamed:@"ico_xnprogresshud_success.png"]];
    }else{
        [refreshView setInfoImage:nil];
        [refreshView setErrorImage:nil];
        [refreshView setSuccessImage:nil];
    }
}

- (IBAction)sliderAction:(UISlider *)sender {
    _refreshView.progress = sender.value;
    [self.hud showProgressWithTitle:@"正在下载" progress:sender.value];
}

- (IBAction)actionMaskType:(UISegmentedControl *)sender {
    [self.hud setMaskType:sender.selectedSegmentIndex];
}

- (IBAction)actionRepeatition:(UIButton *)sender {
    [self showhudWithIndex:_display.selectedSegmentIndex];
}

- (IBAction)actionSegmented:(UISegmentedControl *)sender {
    self.maskType.selectedSegmentIndex = 0;
    [self showhudWithIndex:sender.selectedSegmentIndex];
}

- (void)showhudWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            if(_switchDelay.on) {
                [self.hud setDisposableDelayResponse:_delayResponse delayDismiss:_delayDismiss];
            }
            [self.hud show];
        }
            break;
        case 1:{
            if(_switchDelay.on) {
                [self.hud setDisposableDelayResponse:_delayResponse delayDismiss:_delayDismiss];
            }
            [self.hud showLoadingWithTitle:@"正在登录"];
        }
            break;
        case 2:{
            [self.hud showWithTitle:@"这是一个支持自定义的轻量级HUD"];
        }
            break;
        case 3:{
            [self.hud showInfoWithTitle:@"请输入账号"];
        }
            break;
        case 4:{
            [self.hud showErrorWithTitle:@"拒绝访问"];
        }
            break;
        case 5:{
            [self.hud showSuccessWithTitle:@"操作成功"];
        }
            break;
        default:
            break;
    }
}

- (IBAction)actionHorizontion:(UISegmentedControl *)sender {
    [self.hud setOrientation:sender.selectedSegmentIndex];
}

- (IBAction)actionDismiss:(id)sender {
//    [[XNProgressHUD shared] dismiss];
    [self.hud dismiss];
}
@end
