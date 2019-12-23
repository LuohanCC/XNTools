//
//  UITextField+WJ.m
//  XNTools
//
//  Created by 罗函 on 2016/9/28.
//  Copyright © 2016年 罗函. All rights reserved.
//

//UITextField+WJ.m
#import "UITextField+XNExtension.h"
#import <objc/runtime.h>
#import "XNUtils.h"

NSString * const WJTextFieldDidDeleteBackwardNotification = @"com.whojun.textfield.did.notification";
@implementation UITextField (XNExtension)
+ (void)load {
    [XNUtils exchangeMethod:[self class] originalMethodStr:@"deleteBackward" exchangeMethod:@selector(wj_deleteBackward)];
}

- (void)wj_deleteBackward {
    [self wj_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])  {
        id <WJTextFieldDelegate> delegate  = (id<WJTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:WJTextFieldDidDeleteBackwardNotification object:self];
}
@end
