//
//  XNBannerVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/26.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNBannerVC.h"
#import "XNBannerView.h"
#import <XNTools/XNConf.h>

@interface XNBannerVC (){
    BOOL isfromurl;
}
@property (strong, nonatomic) IBOutlet UIButton *btn_change;
@property (strong, nonatomic) XNBannerView *banner;
@property (strong, nonatomic) NSMutableArray *arr;
@end

@implementation XNBannerVC

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_VC_BG;
    self.title = @"广告视图";
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btn_change.layer.cornerRadius = 6.f;
    _btn_change.layer.borderColor = [UIColor clearColor].CGColor;
    _btn_change.layer.borderWidth = 0.1;
    
    _arr = [[NSMutableArray alloc] initWithCapacity:5];
    [_arr addObject:[UIImage imageNamed:@"00.jpg"]];
    [_arr addObject:[UIImage imageNamed:@"11.png"]];
    [_arr addObject:[UIImage imageNamed:@"22.png"]];
    [_arr addObject:[UIImage imageNamed:@"33.png"]];
    [_arr addObject:[UIImage imageNamed:@"44.png"]];
    _banner = [[XNBannerView alloc] initWithFrame:CGRectMake(0, XNNaviBarHeight, [UIScreen mainScreen].bounds.size.width, 200) imageArray:_arr];
    NSLog(@"%f", [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:_banner];
}
- (IBAction)btn_action:(id)sender {
    isfromurl = !isfromurl;
    [_arr removeAllObjects];
    if(_banner) [_banner removeFromSuperview];
    if(isfromurl) {
        [_btn_change setTitle:@"从网络加载(当前)" forState:UIControlStateNormal];
        [_arr addObject:@"http://pic2.ooopic.com/10/62/21/09b1OOOPIC24.jpg"];
        [_arr addObject:@"http://pic39.nipic.com/20140316/18189013_154124713120_2.jpg"];
        [_arr addObject:@"http://img.sccnn.com/bimg/337/23557.jpg"];
        [_arr addObject:@"http://pic32.nipic.com/20130810/3648411_233408558366_2.jpg"];
        [_arr addObject:@"http://pic2.ooopic.com/01/15/67/08b1OOOPIC75.jpg"];
        _banner = [[XNBannerView alloc] initWithFrame:CGRectMake(0, XNNaviBarHeight, [UIScreen mainScreen].bounds.size.width, 200) imageURLGroup:_arr];
        [self.view addSubview:_banner];
    }else{
        [_btn_change setTitle:@"从静态资源加载(当前)" forState:UIControlStateNormal];
        [_arr addObject:[UIImage imageNamed:@"00.jpg"]];
        [_arr addObject:[UIImage imageNamed:@"11.png"]];
        [_arr addObject:[UIImage imageNamed:@"22.png"]];
        [_arr addObject:[UIImage imageNamed:@"33.png"]];
        [_arr addObject:[UIImage imageNamed:@"44.png"]];
        _banner = [[XNBannerView alloc] initWithFrame:CGRectMake(0, XNNaviBarHeight, [UIScreen mainScreen].bounds.size.width, 200) imageArray:_arr];
        [self.view addSubview:_banner];
    }
    
}


@end
