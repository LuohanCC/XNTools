//
//  UIButton+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/1/31.
//

#import "UIButton+XNExtension.h"
#import <objc/message.h>
#import "../Utils/XNUtils.h"

static char objc_XNButtonImagePosition;
static char objc_XNButtonImageSpacing;
@implementation UIButton (XNExtension)

+ (void)load {
    [XNUtils exchangeMethod:[self class] originalMethodStr:@"setSelected:" exchangeMethod:@selector(xn_setSelected:)];
}

#pragma mark - 调整button.titleLabel和button.imageView的位置
- (void)setXNButtonImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue {
    objc_setAssociatedObject(self, &objc_XNButtonImagePosition, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &objc_XNButtonImageSpacing, @(spacingValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xn_setSelected:(BOOL)selected {
    [self xn_setSelected:selected];
    NSNumber *value = objc_getAssociatedObject(self, &objc_XNButtonImagePosition);
    NSNumber *spacing = objc_getAssociatedObject(self, &objc_XNButtonImageSpacing);
    if (!value || !spacing) return;
    // 改变selected之后，button.currentTitle内容不会改变，这里需要重新设置image和title的位置
    NSString *currentTitle = [self titleForState:(selected?UIControlStateSelected:UIControlStateNormal)];
    [self setImagePosition:value.integerValue spacingValue:spacing.integerValue text:currentTitle];
}

/**
 设置image相对于title的位置
 
 @param position XNButtonImagePosition
 @param spacingValue 距离中心的距离
 */
- (void)setImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue {
    CGFloat labelWidth  = self.titleLabel.intrinsicContentSize.width;
    CGFloat imageWith   = self.imageView.frame.size.width;
    [self setImagePosition:position spacingValue:spacingValue labelWidth:labelWidth imageWidth:imageWith];
}

// 下一版本可移除
- (void)setImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    CGFloat labelWidth = label.intrinsicContentSize.width;
    CGFloat imageWith   = self.imageView.intrinsicContentSize.width;
    [self setImagePosition:position spacingValue:spacingValue labelWidth:labelWidth imageWidth:imageWith];
}

- (void)setImagePosition:(XNButtonImagePosition)position spacingValue:(CGFloat)spacingValue labelWidth:(CGFloat)labelWidth imageWidth:(CGFloat)imageWidth {
    [self setXNButtonImagePosition:position spacingValue:spacingValue];
    CGFloat distance = spacingValue / 2;
    if(position == XNButtonImageLeft || position == XNButtonImageRight) {
        switch (position) {
            case XNButtonImageLeft:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -distance, 0, distance);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, distance, 0, -distance);
                break;
            case XNButtonImageRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + distance, 0, -(labelWidth + distance));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + distance), 0, imageWidth + distance);
                break;
            default:
                break;
        }
        return;
    }
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    CGFloat imageHeight = self.imageView.frame.size.height;
    switch (position) {
        case XNButtonImageTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(imageHeight+distance, -imageWidth, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-distance, 0, 0, -labelWidth);
        }
            break;
        case XNButtonImageBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight-distance, -imageWidth, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(labelHeight+distance, 0, 0, -labelWidth);
        }
            break;
        default:
            break;
    }
}

/**
 设置图片与渲染颜色
 
 @param image 原图
 @param tintColor 渲染颜色
 @param state 按钮状态
 */
- (void)setImage:(UIImage *)image tintColor:(UIColor *)tintColor forState:(UIControlState)state {
    [self setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)] forState:state];;
    self.tintColor = tintColor;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType rect:(CGRect)rect {
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = rect;
    return button;
}

/*
 * title、titleColor、titleFont、sel、target
 */
- (void)setTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont sel:(SEL)sel target:(id)target {
    [self setTitle:title forState:(UIControlStateNormal)];
    [self setTitleColor:titleColor forState:(UIControlStateNormal)];
    if(titleFont) {
        [self.titleLabel setFont:titleFont];
    }
    if(sel && target) {
        [self addTarget:target action:sel forControlEvents:(UIControlEventTouchDown)];
    }
}

/*
 * normalColor、highlightedColor、selectedColor
 */
- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor selectedColor:(UIColor *)selectedColor {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    [self setTitleColor:highlightedColor forState:(UIControlStateHighlighted)];
    [self setTitleColor:selectedColor forState:(UIControlStateSelected)];
}

/*
 * normalImage、highlightedImage、selectedImage
 */
- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage selectedImage:(UIImage *)selectedImage {
    [self setImage:image forState:(UIControlStateNormal)];
    [self setImage:highlightedImage forState:(UIControlStateHighlighted)];
    [self setImage:selectedImage forState:(UIControlStateSelected)];
}

/*
 * normalImage、highlightedImage、selectedImage
 */
- (void)setBackgroundImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage selectedImage:(UIImage *)selectedImage {
    [self setBackgroundImage:image forState:(UIControlStateNormal)];
    [self setBackgroundImage:highlightedImage forState:(UIControlStateHighlighted)];
    [self setBackgroundImage:selectedImage forState:(UIControlStateSelected)];
}

@end
