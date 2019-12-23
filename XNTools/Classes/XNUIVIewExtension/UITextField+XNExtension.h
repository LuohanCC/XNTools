//
//  UITextField+WJ.h
//  XNTools
//
//  Created by 罗函 on 2016/9/28.
//  Copyright © 2016年 罗函. All rights reserved.
//

//UITextField+WJ.h
#import <UIKit/UIKit.h>

extern NSString * const WJTextFieldDidDeleteBackwardNotification;
@protocol WJTextFieldDelegate <UITextFieldDelegate>
@optional
/**
 监听键盘删除键

 @param textField textField
 */
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

extern NSString * const WJTextFieldDidDeleteBackwardNotification;

@interface UITextField (XNExtension)
@property (weak, nonatomic) id<WJTextFieldDelegate> delegate;
@end

