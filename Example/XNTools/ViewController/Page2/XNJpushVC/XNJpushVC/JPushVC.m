//
//  ViewController.m
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "JPushVC.h"
#import "InputViewController.h"
#import "ExtrasViewController.h"
#import "MessagesCell.h"
#import <AFNetworking.h>
#import "SimpleTBVC.h"
#import "XNHUD.h"
#import <AudioToolbox/AudioServices.h>

static NSString * MessageCellIdentifier = @"MessageCellIdentifier";

@interface JPushVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UIBarButtonItem *barButton01;
@property (nonatomic, retain) UIBarButtonItem *barButton02;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *titlesGoutp00;
@property (nonatomic, retain) NSArray *titlesGoutp01;
@property (nonatomic, retain) NSArray *titlesGoutp02;
@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) NSMutableDictionary *iosparams;
@property (nonatomic, retain) NSMutableDictionary *androidparams;

@end

@implementation JPushVC

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"MessagesCell" bundle:nil] forCellReuseIdentifier:MessageCellIdentifier];
    }
    return _tableView;
}

- (void)testPush:(UIBarButtonItem *)sender {
    [self push:0];
 }

- (void)doPush:(UIBarButtonItem *)sender {
    [self push:1];
}

- (NSMutableDictionary *)params {
    if(!_params) {
        _params = [NSMutableDictionary new];
        [_params setValue:@"all" forKey:@"platform"];
        [_params setValue:@"all" forKey:@"audience"];
        [_params setValue:@"6cdabc0fd28af2eeeec7e67b" forKey:@"AppKey"];
        [_params setValue:@"266703e7c47ed87d83537ed9" forKey:@"MasterSecret"];
    }
    return _params;
}

- (void)initDatas {
    self.titlesGoutp00 = @[@"AppKey", @"MasterSecret", @"platform"];
    self.titlesGoutp01 = @[@"alert", @"sound", @"badge", @"extras"];
    self.titlesGoutp02 = @[@"alert", @"Title", @"builder_id", @"extras"];
    
    
    if(! [self getDatas]) {
        self.iosparams = [[NSMutableDictionary alloc] init];
        [self.iosparams setValue:@"IOS:收到了一条新推送!"          forKey:@"alert"];
        [self.iosparams setValue:@"default"                     forKey:@"sound"];
        [self.iosparams setValue:@"+1"                          forKey:@"badge"];
        [self.iosparams setValue:@{@"newsid": @"321"}           forKey:@"extras"];
        
        self.androidparams = [[NSMutableDictionary alloc] init];
        [self.androidparams setValue:@"Android:收到了一条新推送!"  forKey:@"alert"];
        [self.androidparams setValue:@"default"                 forKey:@"title"];
        [self.androidparams setValue:@"+1"                      forKey:@"builder_id"];
        [self.androidparams setValue:@{@"newsid": @"321"}       forKey:@"extras"];
        
    }
 
    self.title = @"Jpush Web";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDatas];
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:COLOR_VC_BG];
    //BarButtonItems
    _barButton01 = [[UIBarButtonItem alloc] initWithTitle:@"验证" style:(UIBarButtonItemStylePlain) target:self action:@selector(testPush:)];
    [_barButton01 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(255, 255, 255)} forState:(UIControlStateNormal)];
    _barButton02 = [[UIBarButtonItem alloc] initWithTitle:@"推送" style:(UIBarButtonItemStylePlain) target:self action:@selector(doPush:)];
    [_barButton02 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(255, 255, 255)} forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[self.barButton02, self.barButton01];
    [self setupXNHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? _titlesGoutp00.count : (section  == 1 ? _titlesGoutp01.count : _titlesGoutp02.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellheight = 40;
    if(indexPath.row == 3 && (indexPath.section == 1 || indexPath.section == 2)) {
        switch (indexPath.section) {
            case 1:{
                if(_iosparams[@"extras"]) {
                    cellheight = 20 + 13 * ((NSDictionary *)_iosparams[@"extras"]).count;
                }
            }
                break;
            case 2:{
                if(_androidparams[@"extras"]) {
                    cellheight = 20 + 13 * ((NSDictionary *)_androidparams[@"extras"]).count;
                }
            }
                break;
                
            default:
                break;
        }
        if(cellheight < 40) cellheight = 40;
    }
    return cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:{
            [cell setValueWithIndexPath:indexPath dic:self.params titles:_titlesGoutp00];
        }
            break;
            
        case 1:{
            [cell setValueWithIndexPath:indexPath dic:self.iosparams titles:_titlesGoutp01];
        }
            break;
            
        case 2:{
            [cell setValueWithIndexPath:indexPath dic:self.androidparams titles:_titlesGoutp02];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    header.backgroundColor = self.view.backgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, header.bounds.size.width-20, header.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = [UIColor grayColor];
    label.text = section == 0 ? @"主要参数" : (section == 1 ? @"IOS推送参数" : @"Android推送参数");
    [header addSubview:label];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MessagesCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section != 0 && indexPath.row == 3) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"ExtrasStoryBoard" bundle:nil];
        ExtrasViewController *extrasVC = [board instantiateViewControllerWithIdentifier:@"ExtrasViewController_ID"];
        extrasVC.dic =  indexPath.section == 1 ? _iosparams[@"extras"] : _androidparams[@"extras"];
        [extrasVC setBlock:^(NSMutableDictionary * dic) {
            if(dic) {
                if(indexPath.section == 1) {
                    [_iosparams setValue:dic forKey:@"extras"];
                }else{
                    [_androidparams setValue:dic forKey:@"extras"];
                }
                [self.tableView reloadData];
            }
        }];
        [self.navigationController pushViewController:extrasVC animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 2) {
        SimpleTBVC *vc = [[SimpleTBVC alloc] init:DEVICES_GROUP_PARAMS title:self.titlesGoutp00[2]];
        [vc setCallBack:^(NSInteger index) {
            [_params setValue:DEVICES_GROUP_PARAMS[index] forKey:self.titlesGoutp00[2]];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        InputViewController *inputVC = [[InputViewController alloc] init:cell.title.text text:cell.message.text];
        [inputVC setBlock:^(NSString *text) {
            switch (indexPath.section) {
                case 0:
                    [_params setValue:text forKey:cell.key];
                    break;
                case 1:
                    [_iosparams setValue:text forKey:cell.key];
                    break;
                case 2:
                    [_androidparams setValue:text forKey:cell.key];
                    break;
                    
                default:
                    break;
            }
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:inputVC animated:YES];
    }
}

- (void)push:(NSInteger)choices {
    NSString *url = @"https://api.jpush.cn/v3/push";
    if(choices == 0) {
        url = [url stringByAppendingString:@"/validate"];
    }
    
    NSString *keys = [NSString stringWithFormat:@"%@:%@", _params[@"appkey"], _params[@"mastersecret"]];
    NSData *nsdata = [keys dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    AFHTTPSessionManager *lhmanager = [AFHTTPSessionManager manager];
    lhmanager.requestSerializer.timeoutInterval = 15.f;
    base64Encoded = [NSString stringWithFormat:@"Basic %@", base64Encoded];
    
    lhmanager.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    //返回参数无需设置，AFN默认就是json
    [lhmanager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //获取用户token
    [lhmanager.requestSerializer setValue:@"/v3/push HTTP/1.1" forHTTPHeaderField:@"POST"];
    [lhmanager.requestSerializer setValue:base64Encoded forHTTPHeaderField:@"Authorization"];
    
    NSMutableDictionary *notificationParams = [[NSMutableDictionary alloc] init];
    [notificationParams setValue:self.androidparams             forKey:@"android"];
    [notificationParams setValue:self.iosparams                 forKey:@"ios"];
    
    NSMutableDictionary *optionsParams = [[NSMutableDictionary alloc] init];
    [optionsParams setValue:@"120"                       forKey:@"time_to_live"];
    [optionsParams setValue:@"false"                    forKey:@"apns_production"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _params[@"platform"], @"platform",
                         @"all", @"audience",
                         notificationParams, @"notification",
                         optionsParams, @"options",
                         nil];
    [XNHUD show];
    [lhmanager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(choices == 0) {
            [XNHUD showSuccessWithStatus:@"验证通过,可以进行推送"];
        }else{
            [XNHUD showSuccessWithStatus:@"推送成功"];
            [self systemVibrate];
            [self systemSound];
        }
        NSLog(@"操作成功\n\nresponseObject = %@", responseObject);
        [self saveDatas];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [XNHUD showErrorWithStatus:choices == 0 ? @"验证失败" : @"推送失败"];
    }];
    
}

- (void)saveDatas {
    [[NSUserDefaults standardUserDefaults] setObject:_params forKey:@"params"];
    [[NSUserDefaults standardUserDefaults] setObject:_iosparams forKey:@"iosparams"];
    [[NSUserDefaults standardUserDefaults] setObject:_androidparams forKey:@"androidparams"];
}

- (BOOL)getDatas {
    NSMutableDictionary *dic01 = [[NSUserDefaults standardUserDefaults] objectForKey:@"params"];
    NSMutableDictionary *dic02 = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"iosparams"];
    NSMutableDictionary *dic03 = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"androidparams"];
    if(dic01 && dic02 && dic03) {
        self.params = [[NSMutableDictionary alloc] initWithDictionary:dic01];
        self.iosparams = [[NSMutableDictionary alloc] initWithDictionary:dic02];
        self.androidparams = [[NSMutableDictionary alloc] initWithDictionary:dic03];
        return YES;
    }
    return NO;
}

- (void)setupXNHUD {
    [XNHUD setDefaultStyle:XNHUDStyleCustom];
    [XNHUD setBackgroundColor:[UIColor colorWithRGB:0x00A9AB]];
    [XNHUD setForegroundColor:[UIColor colorWithRGB:0xeeeeee]];
    [XNHUD setMinimumDismissTimeInterval:1.0];
}

#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
- (void)systemVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)systemSound
{
    AudioServicesPlaySystemSound(SOUNDID);
}
@end
