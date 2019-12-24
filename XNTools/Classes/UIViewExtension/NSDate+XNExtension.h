//
//  NSDate+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/3/2.
//

#import <Foundation/Foundation.h>

@interface NSDate (XNExtension)
/**
 时间戳 -> 字符串
 
 @param timeStamp timeStamp
 @param format format
 @return string
 */
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSUInteger)format;

/**
 时间戳 -> 字符串 （自定义日期分隔符、事件分隔符）
 
 @param timeStamp timeStamp
 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return string
 */
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator;

/**
 NSDate -> 字符串
 
 @param format format
 @return string
 */
- (NSString *)dateStringWithFormat:(NSUInteger)format;

/**
 NSDate -> 字符串 （自定义日期分隔符、事件分隔符）
 
 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return 字符串
 */
- (NSString *)dateStringWithFormat:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator;

/**
 时间戳
 
 @return long long
 */
- (long long)timesTemp;

/**
 NSData -> 字符串 （按格式）
 
 @param date date
 @param format format
 @return 字符串
 */
+ (NSString *)dateStringFromNSDate:(NSDate *)date format:(NSUInteger)format;

/**
 NSData -> 字符串 （按格式；自定义分日期隔符和时间分隔符）
 
 @param date date
 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return 字符串
 */
+ (NSString *)dateStringFromNSDate:(NSDate *)date format:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator;

/**
 获取两个时间的差值
 
 @param max 较大的时间
 @param min 较小的时间
 @return 差值显示
 */
+ (NSString *)differenceWith:(NSDate *)max min:(NSDate *)min;

/**
 两个时间相隔的秒数
 
 @param max 较大的时间
 @param min 较小的时间
 @return 差值
 */
+ (NSTimeInterval)compare:(NSDate *)max min:(NSDate *)min;

/**
 获取时间戳
 
 @return 时间戳
 */
+ (NSTimeInterval)timeStamp;

+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2;

@end

