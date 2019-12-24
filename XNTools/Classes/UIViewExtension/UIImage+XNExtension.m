//
//  UIImage+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2017/12/9.
//

#import "UIImage+XNExtension.h"

@implementation UIImage (XNExtension)

/**
 从XNTools的Bundle中获取图片资源

 @param name name
 @param target target
 @return image
 */
+ (UIImage *)imageFromTheXNBundle:(NSString *)name target:(id)target {
    NSBundle *bundle = [NSBundle bundleForClass:[target class]];
    NSString *xnBundleName = [NSString stringWithFormat:@"%@.bundle", @"XNTools"];
    NSString *imagePath = [bundle pathForResource:name ofType:nil inDirectory:xnBundleName];
    return [UIImage imageWithContentsOfFile:imagePath];
}

/**
 根据颜色创建图片
 
 @param color color
 @return image
 */
+ (UIImage *)createImageWithUIColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageWithUIColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 调整图片大小
 
 @param img img
 @param newSize newSize
 @return image
 */
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 高斯模式

 @param image image
 @param blur 模糊程度
 @return blurryImage
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (image == nil) {
        return nil;
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [filter setValue:@(blur) forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

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
                        horizontal:(BOOL)horizontal {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建色彩空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint = (CGPoint){0, 0};
    CGPoint endPoint = (CGPoint){size.width,0};
    if (!horizontal) {
        startPoint = (CGPoint){size.width/2, 0};
        endPoint = (CGPoint){size.width/2,size.height};
    }
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, colorGradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRelease(colorGradient);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 图片切割，切割点为中心处

 @return 切割完成后的图片
 */
- (UIImage *)resizableImageWithOriginX:(CGFloat)x y:(CGFloat)y {
    UIEdgeInsets insets = UIEdgeInsetsMake(x, y, 0, 0);
    UIImage *image = [self resizableImageWithCapInsets:insets];
    return image;
}

- (UIImage *)resizableImageWithCenter {
    CGFloat x = self.size.width / 2, y = self.size.height / 2;
    UIEdgeInsets insets = UIEdgeInsetsMake(y, x, y, x);
    UIImage *image = [self resizableImageWithCapInsets:insets];
    return image;
}

@end


