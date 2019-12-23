//
//  InputViewController.h
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <XNTools/XNViewController.h>

@interface InputViewController : XNViewController

@property (nonatomic, readwrite, copy) void (^Block)(NSString *);
- (instancetype)init:(NSString *)title text:(NSString *)text;

@end
