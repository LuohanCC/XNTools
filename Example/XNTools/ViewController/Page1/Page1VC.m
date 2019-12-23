//
//  Page1VC.m
//  XNTools_Example
//
//  Created by 罗函 on 2018/2/6.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "Page1VC.h"
#import "XNBannerVC.h"
#import "XNTipsVC.h"
#import "JPushVC.h"
#import "XNHUDVC.h"
#import "JSClockVC.h"
#import "XNHamburgerButtonVC.h"
#import <XNTools/XNConf.h>
#import "XNLottieVC.h"
#import <XNTools/XNNavigationController.h>
#import "XNRefreshController.h"

@interface Page1VC ()
@property (nonatomic, strong) NSArray *viewDatas;

@end

@implementation Page1VC
- (NSArray *)viewDatas {
    if(!_viewDatas) {
        _viewDatas = @[@{@"title":@"XNBannerView",         @"info":@"广告视图，支持本地、网络资源加载"},
                       @{@"title":@"XNTipsView",           @"info":@"相对UIAlertViewController更加灵活，支持各种自定义"},
                       @{@"title":@"XNHUDVC",              @"info":@"改写SVGProgressHUD"},
                       @{@"title":@"JSClockVC",            @"info":@"用HTML/CSS/JS写的时钟，可直接放在Android上运行"},
                       @{@"title":@"XNHamburger",          @"info":@"汉堡包按钮，支持多种自定义"},
                       @{@"title":@"PathAnimations",       @"info":@"路径动画"},
                       @{@"title":@"XNRefreshController",  @"info":@"RefreshView"}
                       ];
    }
    return _viewDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    [self setupBackBarButtonItemWithImage:[UIImage imageNamed:@"ico_nav_back.png"]
         backIndicatorTransitionMaskImage:[UIImage imageNamed:@"ico_nav_back.png"]
                                tintColor:[UIColor whiteColor]];
    [self setupNavigationBarBackgroundColor:[UIColor colorWithRGB:0xe16531]];
    [self setupNavigationBarTintColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:19.f]];
    self.title = @"视图类";
    self.view.backgroundColor = COLOR_VC_BG;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"UITableViewCell"];
    cell.detailTextLabel.textColor = [UIColor colorWithRGB:0x555555];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.f];
    NSDictionary *dataDic = nil;
    dataDic = self.viewDatas[indexPath.row];
    cell.textLabel.text = dataDic[@"title"];
    cell.detailTextLabel.text = dataDic[@"info"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                XNBannerVC *bannerVC = [board instantiateViewControllerWithIdentifier:@"XNBannerVC_ID"];
                [self.navigationController pushViewController:bannerVC animated:YES];
            }
                break;
            case 1:{
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                XNTipsVC *tipsVC = [board instantiateViewControllerWithIdentifier:@"XNTipsVC_ID"];
                [self.navigationController pushViewController:tipsVC animated:YES];
            }
                break;
            case 2:{
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                XNHUDVC *xnhudVC = [board instantiateViewControllerWithIdentifier:@"XNHUDVC_ID"];
                [self.navigationController pushViewController:xnhudVC animated:YES];
            }
                break;
            case 3:{
                JSClockVC *clockVC = [[JSClockVC alloc] init];
                [self.navigationController pushViewController:clockVC animated:YES];
            }
                break;
            case 4:{
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                XNHamburgerButtonVC *hamburgerVC = [board instantiateViewControllerWithIdentifier:@"XNHamburgerButtonVC_ID"];
                [self.navigationController pushViewController:hamburgerVC animated:YES];
            }
                break;
            case 5:{
                XNLottieVC *xnLottieVC = [XNLottieVC new];
                [self.navigationController pushViewController:xnLottieVC animated:YES];
            }
                break;
            case 6:{
                
                UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                XNRefreshController *xnRefreshController = [board instantiateViewControllerWithIdentifier:@"XNRefreshController_ID"];
                [self.navigationController pushViewController:xnRefreshController animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
@end


