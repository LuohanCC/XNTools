//
//  XNConf.h
//  Pods
//
//  Created by jarvis on 2019/1/9.
//

#ifndef XNConf_h
#define XNConf_h

//#import "Utils/XNUtils.h"

#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 尺寸相关定义 
//#define XNScrRealwidth   ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
//#define XNScrRealHeight  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
//#define XNScreenWidthPx                 (XNScreenWidth * [UIScreen mainScreen].scale)
//#define XNScreenHeightPx                (XNScreenHeight * [UIScreen mainScreen].scale)
//#define XNScreenWidth                   [[UIScreen mainScreen] bounds].size.width
//#define XNScreenHeight                  [[UIScreen mainScreen] bounds].size.height
//#define XNScreenShortEdge               (XNScreenWidth<XNScreenHeight?XNScreenWidth:XNScreenHeight)
//#define XNIsIPhoneX                     [XNUtils isNotchScreen]
//#define XNStatusBarHeight               [[UIApplication sharedApplication] statusBarFrame].size.height
#define XNNaviBarHeight                 (false ? 88.f : 64.f)
#define XNTabbarHeight                  (false ? (49.f + 34.f) : 49.f)
#define XNHomeIndicatorHeight           (false ? 34.f : 0.f)
//
//#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 获取设备和APP版本信息
//#define XNAppDictionary                 [[NSBundle mainBundle] infoDictionary]
//#define XNAppName                       [XNAppDictionary objectForKey:@"CFBundleDisplayName"]
//#define XNAppVersion                    [XNAppDictionary objectForKey:@"CFBundleShortVersionString"]
//#define XNAppVersionValue               [XNAppVersion stringByReplacingOccurrencesOfString:@"." withString:@""]
//#define XNAppVersionValueEx             (XNAppVersionValue.length==2?[XNAppVersionValue stringByAppendingString:@"0"]:XNAppVersionValue)
//#define XNAPPBuildVersion               [XNAppDictionary objectForKey:@"CFBundleVersion"]
//#define XNDeviceNick                    [[UIDevice currentDevice] name]
//#define XNDeviceName                    [[UIDevice currentDevice] systemName]
//#define XNDeviceModel                   [[UIDevice currentDevice] model]
//#define XNDevicelocalizedModel          [[UIDevice currentDevice] localizedModel]
//#define XNDeviceSystemVersion           [[UIDevice currentDevice] systemVersion]
//#define XNDeviceSystemVersionValue      [[[UIDevice currentDevice] systemVersion] floatValue]
//
//#define XNNotificationCenter [NSNotificationCenter defaultCenter]
//
//#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 位置相关定义
//#define XNToastDefaultPosition          [NSValue valueWithCGPoint:CGPointMake(SCR_WIDTH/2, SCR_HEIGHT*0.8)]
//
//#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 APP相关定义
//#define XNAppDelegate                   [UIApplication sharedApplication].delegate
#define XNSelfBundle                    [NSBundle bundleForClass:[self class]]
#define XNImage(name)                   [UIImage imageNamed:name]
#define XNStringByJointString(base,url) [NSString stringWithFormat:@"%@%@",base,url]
#define XNLS(key)                       NSLocalizedString(key, key)
#define XNFS(size)                      (size*XNScreenShortEdge/375.0)
#define WeakSelf                        __weak typeof(self) weakSelf = self;

#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 Succinct Logcat
#define XNLogcatFormat(tag, format, ...)\
fprintf(stderr,"%s[%s第%d行]:%s\n",\
tag,\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__LINE__, \
[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);

#define XNLogcat(tag, string) \
fprintf(stderr,"%s[%s第%d行]:%s\n", \
tag,\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__LINE__, \
string.UTF8String);

#define XNSuccinctLogcatFromat(format, ...)\
fprintf(stderr, "%s\n", \
[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);

#define XNSuccinctLogcat(string) fprintf(stderr, "%s\n", string.UTF8String);

#ifdef DEBUG_LOGCAT
#define XNLOG_DF(format, ...) XNLogcatFormat("☘️", format, ##__VA_ARGS__)
#define XNLOG_D(string)       XNLogcat("☘️", string)
#define XNLOG_WF(format, ...) XNLogcatFormat("⚠️", format, ##__VA_ARGS__)
#define XNLOG_W(string)       XNLogcat("⚠️", string)
#define XNLOG_EF(format, ...) XNLogcatFormat("❌", format, ##__VA_ARGS__)
#define XNLOG_E(string)       XNLogcat("❌", string)
#define XNLOG_SF(format, ...) XNSuccinctLogcatFromat(format, ##__VA_ARGS__);
#define XNLOG_S(string)       XNSuccinctLogcat(string)
#else
#define XNLOG_DF(format, ...)
#define XNLOG_D(string)
#define XNLOG_WF(format, ...)
#define XNLOG_W(string)
#define XNLOG_EF(format, ...)
#define XNLOG_E(string)
#define XNLOG_SF(format, ...)
#define XNLOG_S(string)
#endif


#pragma mark 🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹 kCString
#define XNToolsName                     @"XNTools"
#define XNkCNoNetworkConnection         @"No network connection"
#define XNkCLoading                     @"loading"

#endif /* XNConf_h */
