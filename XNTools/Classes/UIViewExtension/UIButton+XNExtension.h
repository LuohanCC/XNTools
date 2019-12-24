//
//  UIButton+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/1/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XNButtonImagePosition) {
    XNButtonImageLeft = 0,   //image在左边，title在右边
    XNButtonImageRight = 1,  //image在右边，title在左边
    XNButtonImageTop = 2,    //image在上边，title在下边
    XNButtonImageBottom = 3, //image在下边，title在上边
};

@interface UIButton (XNExtension)

/**
 设置image相对于title的位置
 
 @param position XNButtonImagePosition
 @param spacingValue 距离中心的距离
 */
- (void)setImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue;
- (void)setImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue text:(NSString *)text;

/**
 设置图片与渲染颜色
 
 @param image 原图
 @param tintColor 渲染颜色
 @param state 按钮状态
 */
- (void)setImage:(UIImage *)image tintColor:(UIColor *)tintColor forState:(UIControlState)state;

//Extension methods
+ (instancetype)buttonWithType:(UIButtonType)buttonType rect:(CGRect)rect;

/*
 * title、titleColor、titleFont、sel、target
 */
- (void)setTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont sel:(SEL)sel target:(id)target;

/*
 * normalColor、highlightedColor、selectedColor
 */
- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor selectedColor:(UIColor *)selectedColor;

/*
 * normalImage、highlightedImage、selectedImage
 */
- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage selectedImage:(UIImage *)selectedImage;

/*
 * normalImage、highlightedImage、selectedImage
 */
- (void)setBackgroundImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage selectedImage:(UIImage *)selectedImage;

@end
