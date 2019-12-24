//
//  UILabel+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/3/18.
//

#import "UILabel+XNExtension.h"
#import "NSString+XNExtension.h"

@implementation UILabel (XNExtension)

/**
 * initWithFrame
 
 * params:frame、textColor、font、textAlignment
 */
- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment {
    return [self initWithFrame:frame textColor:textColor font:font textAlignment:textAlignment numberOfLines:1 backgroundColor:[UIColor clearColor]];
}

/**
 * initWithFrame

 * params:frame、textColor、font、textAlignment、numberOfLines、backgroundColor
 */
- (instancetype)initWithFrame:(CGRect)frame
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines
              backgroundColor:(UIColor *)backgroundColor {
    if(!(self = CGRectEqualToRect(frame, CGRectZero) ? [super init] : [super initWithFrame:frame])) return nil;
    self.textColor = textColor;
    self.font = font;
    self.textAlignment = textAlignment;
    self.numberOfLines = numberOfLines;
    self.backgroundColor = backgroundColor;
    return self;
}

/**
 根据文字内容获取适当的大小

 @param boundsSize boundsSize
 @return size 
 */
- (CGSize)getTextContentSizeWithBoundsSize:(CGSize)boundsSize {
    CGSize size = CGSizeZero;
    if (self.text) {
        size = [self.text getFullSize:self.font boundsSize:boundsSize];
    }
    return size;
}
@end
