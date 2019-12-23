//
//  SingletonUD.m
//  XNTools
//
//  Created by 罗函 on 16/7/22.
//  Copyright © 2016年 刘健. All rights reserved.
//

#import "XNUserDefaults.h"

@implementation UserDefaults

#pragma mark - NSUserDefaults
+ (NSUserDefaults *)instance {
    static NSUserDefaults *userdefaults = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userdefaults = [NSUserDefaults standardUserDefaults];
    });
    return userdefaults;
}

@end
