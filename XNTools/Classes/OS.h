//
//  OS.h
//  AFNetworking
//
//  Created by jarvis on 2019/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OS : NSObject
+ (CGFloat)screenRealWidth;
+ (CGFloat)screenRealHeight;
+ (CGFloat)screenWidthPx;
+ (CGFloat)screenHeightPx;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGFloat)screenShortEdge;
+ (CGFloat)statusBarHeight;
+ (NSDictionary *)bundleInfoDictionary;
+ (NSString *)appName;
+ (NSString *)appVersion;
+ (NSString *)appVersionValue;
+ (NSString *)appVersionValueEx;
+ (NSString *)appBuildVersion;
+ (NSString *)deviceNick;
+ (NSString *)deviceName;
+ (NSString *)deviceMode;
+ (NSString *)deviceLocalizedModel;
+ (NSString *)deviceSystemVersion;
+ (CGFloat)deviceSystemVersionFValue;
+ (NSNotificationCenter *)notifyCenter;
+ (id<UIApplicationDelegate>)applicationDelegate;
@end

NS_ASSUME_NONNULL_END
