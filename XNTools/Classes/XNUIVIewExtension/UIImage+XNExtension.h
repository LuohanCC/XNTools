//
//  UIImage+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2017/12/9.
//

#import <Foundation/Foundation.h>

@interface UIImage (XNExtension)

/**
 从XNTools的Bundle中获取图片资源
 
 @param name name
 @param target target
 @return image
 */
+ (UIImage *)imageFromTheXNBundle:(NSString *)name target:(id)target;

/**
 根据颜色创建图片

 @param color color
 @return image
 */
+ (UIImage *)createImageWithUIColor:(UIColor *)color;
+ (UIImage *)createImageWithUIColor:(UIColor *)color size:(CGSize)size;

/**
 调整图片大小

 @param img img
 @param newSize newSize
 @return image
 */
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize;

/**
 高斯模式
 
 @param image image
 @param blur 模糊程度
 @return blurryImage
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 渐变色转成Image
 
 @param size size
 @param locations locations
 @param components components
 @param count count
 @return 渐变色图片
 */
+ (UIImage *)gradientImageWithSize:(CGSize)size
                            locations:(const CGFloat[])locations
                           components:(const CGFloat[])components
                                count:(NSInteger)count
                           horizontal:(BOOL)horizontal;


/**
 图片切割，切割点为中心处
 
 @return 切割完成后的图片
 */
- (UIImage *)resizableImageWithOriginX:(CGFloat)x y:(CGFloat)y;
- (UIImage *)resizableImageWithCenter;
@end



