//
//  InputViewController.m
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "InputViewController.h"
#import <XNTools/UIView+XNExtension.h>
#import <XNTools/UIColor+XNExtension.h>

@interface InputViewController ()
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIBarButtonItem *rightBarButton;

@end

@implementation InputViewController

- (UITextView *)textView {
    if(!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width-20, 90) ];
        [_textView createBordersWithColor:[UIColor colorWithRGB:0x000000 alpha:0.6] withCornerRadius:5 andWidth:0.5];
        _textView.scrollsToTop = YES;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.contentMode = UIViewContentModeTop;
    }
    return _textView;
}

- (UIBarButtonItem *)rightBarButton {
    if(!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(action_RightBarButton:)];
    }
    return _rightBarButton;
}

- (void)action_RightBarButton:(UIBarButtonItem *)sender {
    if(_Block) _Block (self.textView.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)init:(NSString *)title text:(NSString *)text{
    if(self = [super init]) {
        self.title = title;
        self.text = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:COLOR_VC_BG];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.textView];
    [self.navigationItem setRightBarButtonItem:self.rightBarButton];
    self.textView.text = self.text;
}



@end
