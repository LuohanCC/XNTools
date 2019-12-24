//
//  NSDate+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/3/2.
//

#define MINUTE     60
#define HOUS       3600
#define DAY        3600*24
#define MONTH      3600*24*30
#define YEAR       3600*24*30*12
#define DateFormatterStr(str)  [NSString stringWithFormat:@"YYYY%@MM%@dd%@", str?str:@"年", str?str:@"月", str?@"":@"日"]
#define TimeFormatterStr2(str) [NSString stringWithFormat:@"HH%@mm%@", str?str:@"小时", str?@"":@"分"]
#define TimeFormatterStr3(str) [NSString stringWithFormat:@"HH%@mm%@ss%@", str?str:@"小时", str?str:@"分", str?@"":@"秒"]

#import "NSDate+XNExtension.h"

@implementation NSDate (XNExtension)

/**
 时间戳 -> 字符串

 @param timeStamp timeStamp
 @param format format
 @return string
 */
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSUInteger)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate dateStringFromNSDate:date format:format];
}

/**
 时间戳 -> 字符串 （自定义日期分隔符、事件分隔符）

 @param timeStamp timeStamp
 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return string
 */
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate dateStringFromNSDate:date format:format dateSeparator:dateSeparator timeSeparator:timeSeparator];
}

/**
 NSDate -> 字符串

 @param format format
 @return string
 */
- (NSString *)dateStringWithFormat:(NSUInteger)format {
    return [NSDate dateStringFromNSDate:self format:format];
}

/**
 NSDate -> 字符串 （自定义日期分隔符、事件分隔符）

 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return 字符串
 */
- (NSString *)dateStringWithFormat:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator {
    return [NSDate dateStringFromNSDate:self format:format dateSeparator:dateSeparator timeSeparator:timeSeparator];
}

/**
 时间戳

 @return long long
 */
- (long long)timesTemp {
    return (long long)[self timeIntervalSince1970];
}

/**
 NSData -> 字符串 （按格式）

 @param date date
 @param format format
 @return 字符串
 */
+ (NSString *)dateStringFromNSDate:(NSDate *)date format:(NSUInteger)format {
    return [NSDate dateStringFromNSDate:date format:format dateSeparator:nil timeSeparator:nil];
}

/**
 NSData -> 字符串 （按格式；自定义分日期隔符和时间分隔符）

 @param date date
 @param format format
 @param dateSeparator dateSeparator
 @param timeSeparator timeSeparator
 @return 字符串
 */
+ (NSString *)dateStringFromNSDate:(NSDate *)date format:(NSUInteger)format dateSeparator:(NSString *)dateSeparator timeSeparator:(NSString *)timeSeparator {
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    switch (format) {
        case 3:
            [dateFormatter setDateFormat:DateFormatterStr(dateSeparator)];
            break;
        case 5:
            [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@ %@", DateFormatterStr(dateSeparator), TimeFormatterStr2(timeSeparator)]];
            break;
        case 6:
            [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@ %@", DateFormatterStr(dateSeparator), TimeFormatterStr3(timeSeparator)]];
            break;
        case 7:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
            break;
        default:
            break;
    }
    NSString *formatterStr = [dateFormatter stringFromDate:date];
    if(dateSeparator && [dateSeparator isEqualToString:@"-"]) {
        formatterStr = [formatterStr stringByReplacingOccurrencesOfString:@"-" withString:dateSeparator];
    }
    if(timeSeparator && [timeSeparator isEqualToString:@":"]) {
        formatterStr = [formatterStr stringByReplacingOccurrencesOfString:@":" withString:timeSeparator];
    }
    return formatterStr;
}

/**
 获取两个时间的差值

 @param max 较大的时间
 @param min 较小的时间
 @return 差值显示
 */
+ (NSString *)differenceWith:(NSDate *)max min:(NSDate *)min {
    NSTimeInterval timeBetween = [NSDate compare:max min:min];
    NSString *compareStr;
    //小于1分钟
    if (timeBetween < MINUTE) {
        compareStr = [NSString stringWithFormat:@"%d秒", (int)timeBetween];
    }
    //小于1小时
    else if(timeBetween < HOUS) {
        compareStr = [NSString stringWithFormat:@"%d分钟", (int)timeBetween / (MINUTE)];
    }
    //小于1天
    else if(timeBetween < DAY) {
        compareStr = [NSString stringWithFormat:@"%d小时", (int)timeBetween / (HOUS)];
    }
    //小于1个月
    else if(timeBetween < MONTH) {
        compareStr = [NSString stringWithFormat:@"%d天", (int)timeBetween / (DAY)];
    }
    //小于1年
    else if(timeBetween < YEAR){
        compareStr = [NSString stringWithFormat:@"%d个月", (int)timeBetween / (MONTH)];
    }
    //年差
    else {
        compareStr = [NSString stringWithFormat:@"%d年", (int)timeBetween / (YEAR)];
    }
    if(timeBetween < 0) {
        compareStr = @"0小时";
    }
    return compareStr;
}

/**
 两个时间相隔的秒数

 @param max 较大的时间
 @param min 较小的时间
 @return 差值
 */
+ (NSTimeInterval)compare:(NSDate *)max min:(NSDate *)min {
    NSDate *date1 = max;
    NSDate *date2 = min;
    //消除8小时的误差。
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    date1 = [date1 dateByAddingTimeInterval: interval];//追加8小时
    date2 = [date2 dateByAddingTimeInterval:interval];
    //计算时间差间隔
    NSTimeInterval timeBetween = [date1 timeIntervalSinceDate:date2];
    return timeBetween;
}

/**
 获取时间戳

 @return 时间戳
 */
+ (NSTimeInterval)timeStamp {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    return time;
}

+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

@end

