//
//  UILabel+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/3/18.
//

#import <UIKit/UIKit.h>

@interface UILabel (XNExtension)

/**
 * initWithFrame
 
 * params:frame、textColor、font、textAlignment
 */
- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment;

/**
 * initWithFrame
 
 * params:frame、textColor、font、textAlignment、numberOfLines、backgroundColor
 */
- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines
              backgroundColor:(UIColor *)backgroundColor;

/**
 根据文字内容获取适当的大小
 
 @param boundsSize boundsSize
 @return size CGSizeMake([[UIScreen mainScreen] bounds].size.width*0.8, MAXFLOAT)
 */
- (CGSize)getTextContentSizeWithBoundsSize:(CGSize)boundsSize;
@end
