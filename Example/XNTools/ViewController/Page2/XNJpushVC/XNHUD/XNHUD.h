//
//  XNHUD.h
//  XNHUD, https://github.com/XNHUD/XNHUD
//
//  Copyright (c) 2011-2016 Sam Vermette and contributors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000

#define UI_APPEARANCE_SELECTOR

#endif

extern NSString * const XNHUDDidReceiveTouchEventNotification;
extern NSString * const XNHUDDidTouchDownInsideNotification;
extern NSString * const XNHUDWillDisappearNotification;
extern NSString * const XNHUDDidDisappearNotification;
extern NSString * const XNHUDWillAppearNotification;
extern NSString * const XNHUDDidAppearNotification;

extern NSString * const XNHUDStatusUserInfoKey;

typedef NS_ENUM(NSInteger, XNHUDStyle) {
    XNHUDStyleLight,        // default style, white HUD with black text, HUD background will be blurred on iOS 8 and above
    XNHUDStyleDark,         // black HUD and white text, HUD background will be blurred on iOS 8 and above
    XNHUDStyleCustom        // uses the fore- and background color properties
};

typedef NS_ENUM(NSUInteger, XNHUDMaskType) {
    XNHUDMaskTypeNone = 1,  // default mask type, allow user interactions while HUD is displayed
    XNHUDMaskTypeClear,     // don't allow user interactions
    XNHUDMaskTypeBlack,     // don't allow user interactions and dim the UI in the back of the HUD, as on iOS 7 and above
    XNHUDMaskTypeGradient,  // don't allow user interactions and dim the UI with a a-la UIAlertView background gradient, as on iOS 6
    XNHUDMaskTypeCustom     // don't allow user interactions and dim the UI in the back of the HUD with a custom color
};

typedef NS_ENUM(NSUInteger, XNHUDAnimationType) {
    XNHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
    XNHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
};

@interface XNHUD : UIView

#pragma mark - Customization

@property (assign, nonatomic) XNHUDStyle defaultStyle UI_APPEARANCE_SELECTOR;                   // default is XNHUDStyleLight
@property (assign, nonatomic) XNHUDMaskType defaultMaskType UI_APPEARANCE_SELECTOR;             // default is XNHUDMaskTypeNone
@property (assign, nonatomic) XNHUDAnimationType defaultAnimationType UI_APPEARANCE_SELECTOR;   // default is XNHUDAnimationTypeFlat
@property (assign, nonatomic) CGSize minimumSize UI_APPEARANCE_SELECTOR;            // default is CGSizeZero, can be used to avoid resizing for a larger message
@property (assign, nonatomic) CGFloat ringThickness UI_APPEARANCE_SELECTOR;         // default is 2 pt
@property (assign, nonatomic) CGFloat ringRadius UI_APPEARANCE_SELECTOR;            // default is 18 pt
@property (assign, nonatomic) CGFloat ringNoTextRadius UI_APPEARANCE_SELECTOR;      // default is 24 pt
@property (assign, nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;          // default is 14 pt
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;                  // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
@property (strong, nonatomic) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;      // default is [UIColor whiteColor]
@property (strong, nonatomic) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;      // default is [UIColor blackColor]
@property (strong, nonatomic) UIColor *backgroundLayerColor UI_APPEARANCE_SELECTOR; // default is [UIColor colorWithWhite:0 alpha:0.4]
@property (strong, nonatomic) UIImage *infoImage UI_APPEARANCE_SELECTOR;            // default is the bundled info image provided by Freepik
@property (strong, nonatomic) UIImage *successImage UI_APPEARANCE_SELECTOR;         // default is the bundled success image provided by Freepik
@property (strong, nonatomic) UIImage *errorImage UI_APPEARANCE_SELECTOR;           // default is the bundled error image provided by Freepik
@property (strong, nonatomic) UIView *viewForExtension UI_APPEARANCE_SELECTOR;      // default is nil, only used if #define SV_APP_EXTENSIONS is set
@property (assign, nonatomic) NSTimeInterval minimumDismissTimeInterval;            // default is 5.0 seconds

@property (assign, nonatomic) UIOffset offsetFromCenter UI_APPEARANCE_SELECTOR;     // default is 0, 0

@property (assign, nonatomic) NSTimeInterval fadeInAnimationDuration;  // default is 0.15
@property (assign, nonatomic) NSTimeInterval fadeOutAnimationDuration; // default is 0.15


+ (void)setDefaultStyle:(XNHUDStyle)style;                  // default is XNHUDStyleLight
+ (void)setDefaultMaskType:(XNHUDMaskType)maskType;         // default is XNHUDMaskTypeNone
+ (void)setDefaultAnimationType:(XNHUDAnimationType)type;   // default is XNHUDAnimationTypeFlat
+ (void)setMinimumSize:(CGSize)minimumSize;                         // default is CGSizeZero, can be used to avoid resizing for a larger message
+ (void)setRingThickness:(CGFloat)ringThickness;                    // default is 2 pt
+ (void)setRingRadius:(CGFloat)radius;                              // default is 18 pt
+ (void)setRingNoTextRadius:(CGFloat)radius;                        // default is 24 pt
+ (void)setCornerRadius:(CGFloat)cornerRadius;                      // default is 14 pt
+ (void)setFont:(UIFont*)font;                                      // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)setForegroundColor:(UIColor*)color;                         // default is [UIColor blackColor], only used for XNHUDStyleCustom
+ (void)setBackgroundColor:(UIColor*)color;                         // default is [UIColor whiteColor], only used for XNHUDStyleCustom
+ (void)setBackgroundLayerColor:(UIColor*)color;                    // default is [UIColor colorWithWhite:0 alpha:0.5], only used for XNHUDMaskTypeBlack
+ (void)setInfoImage:(UIImage*)image;                               // default is the bundled info image provided by Freepik
+ (void)setSuccessImage:(UIImage*)image;                            // default is the bundled success image provided by Freepik
+ (void)setErrorImage:(UIImage*)image;                              // default is the bundled error image provided by Freepik
+ (void)setViewForExtension:(UIView*)view;                          // default is nil, only used if #define SV_APP_EXTENSIONS is set
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;     // default is 5.0 seconds
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;        // default is 0.15 seconds
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;       // default is 0.15 seconds

#pragma mark - Show Methods

+ (void)show;
+ (void)showWithMaskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use show and setDefaultMaskType: instead.")));
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showWithStatus: and setDefaultMaskType: instead.")));

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showProgress: and setDefaultMaskType: instead.")));
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showProgress:status: and setDefaultMaskType: instead.")));

+ (void)setStatus:(NSString*)status; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses the HUD a little bit later
+ (void)showInfoWithStatus:(NSString*)status;
+ (void)showInfoWithStatus:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showInfoWithStatus: and setDefaultMaskType: instead.")));
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showSuccessWithStatus: and setDefaultMaskType: instead.")));
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showErrorWithStatus: and setDefaultMaskType: instead.")));

// shows a image + status, use 28x28 white PNGs
+ (void)showImage:(UIImage*)image status:(NSString*)status;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(XNHUDMaskType)maskType __attribute__((deprecated("Use showImage:status: and setDefaultMaskType: instead.")));

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;

+ (void)popActivity; // decrease activity count, if activity count == 0 the HUD is dismissed
+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;

+ (BOOL)isVisible;

+ (NSTimeInterval)displayDurationForString:(NSString*)string;

@end

