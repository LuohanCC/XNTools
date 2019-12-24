//
//  XNTextField.h
//  XNTools
//
//  Created by 罗函 on 2014/8/24.
//
//

#import <UIKit/UIKit.h>

@interface XNTextField : UITextField
@property (nonatomic, strong) UIColor *placeholderDefaultColor;
@property (nonatomic, strong) UIColor *textDefaultColor;
@property (nonatomic, strong) UIFont *placeholderDefaultFont;
@property (nonatomic, strong) UIFont *textDefaultFont;

- (instancetype)initWithFrame:(CGRect)frame NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用-initWithFrame:placeholder:");
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

@end
