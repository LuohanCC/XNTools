//
//  UIImageView+XNExtension.m
//  XNTools
//
//  Created by jarvis on 2019/1/10.
//

#import "UIImageView+XNExtension.h"

@implementation UIImageView (XNExtension)

/**
 设置图片与渲染颜色
 
 @param image 原图
 @param tintColor 渲染颜色
 */
- (void)setImage:(UIImage *)image tintColor:(UIColor *)tintColor {
    self.image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    self.tintColor = tintColor;
}

@end

