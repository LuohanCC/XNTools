//
//  XNHUDVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/26.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNHUDVC.h"
#import "XNHUD.h"
#import <XNTools/UIView+XNExtension.h>
#import <XNTools/UIButton+XNExtension.h>
#import <XNTools/NSString+XNExtension.h>

#import "Canvas.h"

@interface XNHUDVC ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation XNHUDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VC_BG;
    self.title = @"修改SVGProgressHUD";
    // Do any additional setup after loading the view.
    [_button createBordersWithColor:[UIColor clearColor] withCornerRadius:6 andWidth:0];
    [_button setImagePosition:(XNButtonImageBottom) spacingValue:10];
    
    NSString *str = @"787878787878787,";
    str = [str deleteIfHasSuffix:@","];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [XNHUD setDefaultStyle:XNHUDStyleCustom];
    [XNHUD setBackgroundColor:[UIColor colorWithRGB:0x000000 alpha:0.8]];
    [XNHUD setForegroundColor:[UIColor colorWithRGB:0xeeeeee]];
    [XNHUD setMinimumDismissTimeInterval:1.0];
    [XNHUD showWithStatus:@"正在加载"];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:10.f];
    
}

- (void)dismiss {
    [XNHUD dismiss];
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
