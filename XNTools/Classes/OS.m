//
//  OS.m
//  AFNetworking
//
//  Created by jarvis on 2019/12/24.
//

#import "OS.h"
#import <UIKit/UIApplication.h>

@implementation OS

+ (CGFloat)screenRealWidth {
    return ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height);
}

+ (CGFloat)screenRealHeight {
    return ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width);
}

+ (CGFloat)screenWidthPx {
    return (self.screenRealWidth * [UIScreen mainScreen].scale);
}

+ (CGFloat)screenHeightPx {
    return (self.screenRealHeight * [UIScreen mainScreen].scale);
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenShortEdge {
    float width = self.screenWidth, height = self.screenHeight;
    return width < height ? width : height;
}

+ (CGFloat)statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (NSDictionary *)bundleInfoDictionary {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appName {
    return [self.bundleInfoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion {
    return [self.bundleInfoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appVersionValue {
    return  [self.appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
}

+ (NSString *)appVersionValueEx {
    NSString *value = self.appVersionValue;
    return  (value.length==2?[value stringByAppendingString:@"0"]:value);
}

+ (NSString *)appBuildVersion {
    return [self.bundleInfoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)deviceNick {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceMode {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceLocalizedModel {
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *)deviceSystemVersion  {
    return [[UIDevice currentDevice] systemVersion];
}

+ (CGFloat)deviceSystemVersionFValue  {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSNotificationCenter *)notifyCenter {
    return [NSNotificationCenter defaultCenter];
}

+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (BOOL)isIphoneX {
    return NO;
}
@end
