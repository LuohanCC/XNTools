//
//  SimpleTBVC.h
//  XNJPushAPP
//
//  Created by 罗函 on 16/6/2.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <XNTools/XNViewController.h>

@interface SimpleTBVC : XNViewController
@property (nonatomic, readwrite, copy) void (^CallBack)(NSInteger);
- (instancetype)init:(NSArray *)titles  title:(NSString *)title ;
@end
