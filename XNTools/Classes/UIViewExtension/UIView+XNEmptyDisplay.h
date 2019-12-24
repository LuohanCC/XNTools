//
//  UIView+XNEmptyDisplay.h
//  XNTools
//
//  Created by 罗函 on 14/7/5.
//  Copyright © 2014年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol XNEmptyViewDelegate <NSObject>
- (void)emptyDisplayTouchDown;
@end

@interface XNEmptyView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labMessage;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic,   weak) UIView  *targetView;
@property (nonatomic,   weak) id<XNEmptyViewDelegate> delegate;
@property (nonatomic, assign, getter=isShowing) BOOL showing;

/**
 设置EmptyDisplay资源
 
 @param image 图片
 @param title 提示文字
 @param info 详细内容
 */
- (void)initWithImage:(UIImage *)image title:(NSString *)title info:(NSString *)info;

/**
 显示
 */
- (void)display;

/**
 移除显示
 */
- (void)removeEmptyDisplay;
@end

@interface UIView (XNEmptyDisplay)
- (void)setEmptyView:(UIView *)emptyView;
- (XNEmptyView *)emptyView;
@end
