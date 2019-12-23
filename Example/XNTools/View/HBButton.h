//
//  HBButton.h
//  XNTools_Example
//
//  Created by 罗函 on 2017/12/27.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBButton : UIButton
@property (nonatomic, assign) NSUInteger lineWidth; //线条的宽度
@property (nonatomic, assign) NSUInteger lineHeight; //线条的高度
@property (nonatomic, assign) NSUInteger distanceFromTheCenter; //线条距离中心点的距离
@property (nonatomic, assign) NSTimeInterval duration; //线条的宽度
@property (nonatomic, assign) BOOL showsMenu;
- (instancetype)initWithFrame:(CGRect)frame lineWidth:(NSUInteger)lineWidth lineHeight:(NSUInteger)lineHeight distanceFromTheCenter:(NSUInteger)distanceFromTheCenter;
@end
