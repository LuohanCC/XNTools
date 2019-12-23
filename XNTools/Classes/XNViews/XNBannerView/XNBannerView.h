//
//  XNBannerView.h
//  XNTools
//
//  Created by LuohanCC on 15/12/19.
//  Copyright © 2015年 Luohan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XNS_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define XNS_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@protocol XNBannerViewDelegate <NSObject>
- (void)xnBannerVisibleIndexDidChanged:(NSUInteger)index;
- (void)xnBannerOpenUrlWithIndex:(NSUInteger)index;
@end

@interface XNBannerView : UIView
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSArray *imageURLGroup;
@property (nonatomic, assign) NSUInteger visibleIndex;
@property (nonatomic, weak) id<XNBannerViewDelegate> delegate;
//@property (nonatomic, readwrite, copy) void (^BlockFromIndex)(NSInteger);
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
- (instancetype)initWithFrame:(CGRect)frame imageURLGroup:(NSArray *)imageURLGroup;
@end

