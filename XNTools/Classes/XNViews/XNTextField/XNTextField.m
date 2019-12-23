//
//  XNTextField.m
//  XNTools
//
//  Created by 罗函 on 2014/8/24.
//
//

#import "XNTextField.h"
//#import <YYKit/YYKit.h>


@implementation XNTextField

//通过代码创建
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame placeholder:@""];
}
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = placeholder;
        [self setUpUI];
    }
    return self;
}

//通过xib创建
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI
{
//    设置border
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 22;
//    self.backgroundColor = Default_FontColor;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.borderWidth = 1;
    // 字体大小
    self.font = _textDefaultFont ? _textDefaultFont : [UIFont systemFontOfSize:16];
    // 光标、字体颜色
    self.tintColor = self.textColor = _textDefaultColor?_textDefaultColor:[UIColor whiteColor];
    // 占位符的颜色和大小
    if(!_placeholderDefaultColor) _placeholderDefaultColor = [UIColor colorWithRed:95/255.0 green:110/255.0 blue:134/255.0 alpha:1];
    // 不成为第一响应者
    [self resignFirstResponder];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

@synthesize textDefaultColor = _textDefaultColor;
- (void)setTextDefaultColor:(UIColor *)textDefaultColor {
    _textDefaultColor = textDefaultColor;
    self.tintColor = self.textColor = _textDefaultColor;
}

@synthesize textDefaultFont = _textDefaultFont;
- (void)setTextDefaultFont:(UIFont *)textDefaultFont {
    _textDefaultFont = textDefaultFont;
    self.font = _textDefaultFont;
}

@synthesize placeholderDefaultColor = _placeholderDefaultColor;
- (void)setPlaceholderDefaultColor:(UIColor *)placeholderDefaultColor {
    _placeholderDefaultColor = placeholderDefaultColor;
    [self setValue:_placeholderDefaultColor forKeyPath:@"_placeholderLabel.textColor"]; //[UIColor hex:@"5F6E86"]
}

@synthesize placeholderDefaultFont = _placeholderDefaultFont;
- (void)setPlaceholderDefaultFont:(UIFont *)placeholderDefaultFont {
    _placeholderDefaultFont = placeholderDefaultFont;
    [self setValue:_placeholderDefaultFont forKeyPath:@"_placeholderLabel.font"];
}


/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:_placeholderDefaultColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

@end
