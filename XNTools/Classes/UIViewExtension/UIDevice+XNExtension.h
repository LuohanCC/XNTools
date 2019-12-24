//
//  UIDevice+XNExtension.h
//  Eccs
//
//  Created by 罗函 on 2018/4/18.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (XNExtension)
/**
 在设备方向不变的情况下强制旋转屏幕
 
 @param interfaceOrientation interfaceOrientation
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end

