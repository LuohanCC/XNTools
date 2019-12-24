//
//  UIImageView+XNExtension.h
//  XNTools
//
//  Created by jarvis on 2019/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (XNExtension)

/**
 设置图片与渲染颜色
 
 @param image 原图
 @param tintColor 渲染颜色
 */
- (void)setImage:(UIImage *)image tintColor:(UIColor *)tintColor;

@end;


NS_ASSUME_NONNULL_END
