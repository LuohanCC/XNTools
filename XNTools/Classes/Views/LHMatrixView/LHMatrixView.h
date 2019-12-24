//
//  LHMatrixView.h
//  XNTools
//
//  Created by 罗函 on 16/8/15.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LHMatrixViewDelegate <NSObject>
@optional
- (void)indexOfCell:(NSInteger)index;
@end
@interface LHMatrixView : UIView
@property (nonatomic, weak) id<LHMatrixViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame  titles:(NSArray *)titles normalImages:(NSArray *)norImgs selectImages:(NSArray *)selImgs;
- (void)setUnreadCountAtIndex:(NSInteger)index unreadCount:(NSUInteger)unreadCount;
@end

/*  *  *  *  *  * DiamondCell  *  *  *  *  *   */
@interface DiamondCell : UIButton
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *unread;
- (instancetype)initWithFrame:(CGRect)frame NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用-initWithFrame:font:");
- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font;
- (void)setData:(NSString *)text image:(UIImage *)image;
- (void)setData:(NSString *)text norImg:(UIImage *)norImg selImg:(UIImage *)selImg;
@end
