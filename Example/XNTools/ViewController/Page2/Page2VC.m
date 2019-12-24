//
//  XNPage2VC.m
//  XNTools_Example
//
//  Created by 罗函 on 2018/2/6.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "Page2VC.h"
#import "JPushVC.h"
#import "UIViewController+XNExtension.h"

@interface Page2VC ()
@property (nonatomic, strong) NSArray *viewDatas;

@end

@implementation Page2VC

- (NSArray *)viewDatas {
    if(!_viewDatas) {
        _viewDatas = @[@{@"title":@"Jpush Web", @"info":@"直接在手机端进行服务端推送功能"}];
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
    [self setupNavigationBarBackgroundColor:[UIColor colorWithRGB:0x008B8B]];
    [self setupNavigationBarTintColor:[UIColor whiteColor] titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:19.f]];
    self.title = @"工具类";
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
    switch (indexPath.row) {
        case 0:{
            JPushVC *rootVC = [[JPushVC alloc] init];
            [self.navigationController pushViewController:rootVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end



