//
//  UIColor+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2017/12/22.
//

#import <UIKit/UIKit.h>

@interface UIColor (XNExtension)
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (uint32_t)rgbValue;
- (uint32_t)rgbaValue;
@end
