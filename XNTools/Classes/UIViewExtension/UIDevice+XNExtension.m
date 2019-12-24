//
//  UIDevice+XNExtension.m
//  Eccs
//
//  Created by 罗函 on 2018/4/18.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "UIDevice+XNExtension.h"

@implementation UIDevice (XNExtension)

/**
 在设备方向不变的情况下强制旋转屏幕
 
 @param interfaceOrientation interfaceOrientation
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithUnsignedInteger:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}
@end
