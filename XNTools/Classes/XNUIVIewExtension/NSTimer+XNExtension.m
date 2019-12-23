//
//  NSTimer+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/3/28.
//

#import "NSTimer+XNExtension.h"

@implementation NSTimer (XNExtension)

/**
 停止定时器并置空
 
 @param timer timer
 */
+ (void)stopTimerAndSetItNil:(NSTimer *)timer {
    if(timer) {
        [timer invalidate];
        timer = nil;
    }
}

@end
