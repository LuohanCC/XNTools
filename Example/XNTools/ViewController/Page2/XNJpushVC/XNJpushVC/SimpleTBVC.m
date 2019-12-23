//
//  SimpleTBVC.m
//  XNJPushAPP
//
//  Created by 罗函 on 16/6/2.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "SimpleTBVC.h"
#import <XNTools/UIColor+XNExtension.h>

@interface SimpleTBVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *datas;
@end

@implementation SimpleTBVC

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)init:(NSArray *)titles title:(NSString *)title {
    if(self = [super init]) {
        self.datas = titles;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:COLOR_VC_BG];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellheight = 40;
    return cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    header.backgroundColor = self.view.backgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, header.bounds.size.width-20, header.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = [UIColor grayColor];
    label.text = @"单选";
    [header addSubview:label];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(_CallBack) _CallBack(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
