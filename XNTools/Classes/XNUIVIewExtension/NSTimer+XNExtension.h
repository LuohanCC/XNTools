//
//  NSTimer+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/3/28.
//

#import <Foundation/Foundation.h>

@interface NSTimer (XNExtension)

/**
 停止定时器并置空

 @param timer timer
 */
+ (void)stopTimerAndSetItNil:(NSTimer *)timer;

@end
