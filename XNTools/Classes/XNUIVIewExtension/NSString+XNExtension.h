//
//  NSString+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2017/9/20.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XNExtension)

/**
 判断字符串是否为空
 
 @param string string
 @return 是/否
 */
+ (BOOL)isNotEmpty:(NSString *)string;

/**
 判断多个字符串是否为空
 
 @param string string
 @return 是/否
 */
+ (BOOL)isNotEmptyStrings:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION;

/**
 判断字符串是否为空
 
 @return 是/否
 */
- (BOOL)isNotEmpty;

/**
 判断是否是手机号码/电话号码
 
 @return 是/否
 */
- (BOOL)isPhoneNumber;

/**
 拼接字符串、后缀
 
 @param aString aString
 @param suffix suffix
 @return 拼接结果
 */
- (NSString *)stringByAppendingString:(NSString *)aString suffix:(NSString *)suffix;

/**
 删除尾部匹配到的字符串
 
 @param suffix suffix
 @return 处理结果
 */
- (NSString *)deleteIfHasSuffix:(NSString *)suffix;

/**
 根据内容获取实际尺寸
 
 @param font font
 @param boundsSize boundsSize
 @return size
 */
- (CGSize)getFullSize:(UIFont *)font boundsSize:(CGSize)boundsSize;
@end
