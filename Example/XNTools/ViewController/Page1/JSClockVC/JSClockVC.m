//
//  JSClockVC.m
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/26.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "JSClockVC.h"

@interface JSClockVC ()

@end

@implementation JSClockVC

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_VC_BG;
    self.title = @"用JS/CSS/HTML写的时钟";
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    UIWebView * web=[[UIWebView alloc] initWithFrame:rect];
    
    //    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"clock" ofType:@"html"];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    NSURL *url =[NSURL URLWithString:filePath];
    //    [web loadHTMLString:htmlString baseURL:url];
    
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/html/clock.html"];
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    web.scrollView.backgroundColor = [UIColor clearColor];
    web.backgroundColor = [UIColor clearColor];
    [web setOpaque:NO];
    web.scrollView.bounces = NO;
    web.userInteractionEnabled = NO;
    
    web.clipsToBounds = YES;
    web.scalesPageToFit=YES;
    //    [web loadHTMLString:str baseURL:nil];
    [self.view addSubview:web];
}
@end
