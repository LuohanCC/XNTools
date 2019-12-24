//
//  SingletonUD.h
//  XNTools
//
//  Created by 罗函 on 16/7/22.
//  Copyright © 2016年 刘健. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XNUserDefaultsInstance [UserDefaults instance]

@interface UserDefaults : NSObject

+ (NSUserDefaults *)instance;

@end
