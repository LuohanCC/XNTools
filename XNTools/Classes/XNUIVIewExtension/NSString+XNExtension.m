//
//  NSString+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2017/9/20.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "NSString+XNExtension.h"

@implementation NSString (XNExtension)

/**
 判断字符串是否为空

 @param string string
 @return 是/否
 */
+ (BOOL)isNotEmpty:(NSString *)string {
    if(!string || string.length==0 || [string isEqual:[NSNull null]] || [string isKindOfClass:[NSNull class]]) return NO;
    return YES;
}

/**
 判断多个字符串是否为空

 @param string string
 @return 是/否
 */
+ (BOOL)isNotEmptyStrings:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION {
    BOOL isNotEmpty = YES;
    NSString *otherString = nil;
    // 1.定义一个指向个数可变的参数列表指针；
    va_list args;
    // 2.string为第一个已知参数,使参数列表指针指向函数参数列表中的第一个可选参数,函数参数列表中参数在内存中的顺序与函数声明时的顺序是一致的。
    va_start(args, string);
    if (string) {
        // 3.返回参数列表中指针所指的参数，返回类型为NSString，并使参数指针指向参数列表中下一个参数。
        while ((otherString = va_arg(args, NSString *)))
            if(! (isNotEmpty = [otherString isNotEmpty])) break;
    }
    //5.清空参数列表，并置参数指针args无效。
    va_end(args);
    return isNotEmpty;
}

/**
 判断字符串是否为空

 @return 是/否
 */
- (BOOL)isNotEmpty {
    if(!self || self.length==0 || [self isEqual:[NSNull null]] || [self isKindOfClass:[NSNull class]]) return NO;
    return YES;
}

/**
 判断是否是手机号码/电话号码

 @return 是/否
 */
- (BOOL)isPhoneNumber {
    NSString *num = self;
    if(num) {
        num = [num stringByReplacingOccurrencesOfString:@"-" withString:@""];
        num = [num stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,1349,153,177,180,189
     */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:num] == YES)
       || ([regextestcm evaluateWithObject:num] == YES)
       || ([regextestct evaluateWithObject:num] == YES)
       || ([regextestcu evaluateWithObject:num] == YES)
       || ([regextestPHS evaluateWithObject:num] == YES)){
        return YES;
    }else{
        return NO;
    }
}

/**
 拼接字符串、后缀

 @param aString aString
 @param suffix suffix
 @return 拼接结果
 */
- (NSString *)stringByAppendingString:(NSString *)aString suffix:(NSString *)suffix {
    if(aString) {
        NSString *text = [self stringByAppendingString:aString];
        if(suffix)  text = [text stringByAppendingString:suffix];
        return text;
    }
    return self;
}

/**
 删除尾部匹配到的字符串

 @param suffix suffix
 @return 处理结果
 */
- (NSString *)deleteIfHasSuffix:(NSString *)suffix {
    if(suffix && self.length >= suffix.length && [self hasSuffix:suffix]) {
        return [self substringToIndex:self.length - suffix.length];
    }
    return self;
}

/**
 根据内容获取实际尺寸

 @param font font
 @param boundsSize boundsSize
 @return size
 */
- (CGSize)getFullSize:(UIFont *)font boundsSize:(CGSize)boundsSize {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:boundsSize options:options attributes:attribute context:nil].size;
}
@end

