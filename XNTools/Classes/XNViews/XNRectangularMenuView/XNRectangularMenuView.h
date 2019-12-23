//
//  XNRectangularMenuView.h
//  XNTools
//
//  Created by 罗函 on 2018/11/23.
//  Copyright © 2018 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XNRectangularMenuViewDelegate <NSObject>
- (void)xn_registerTableViewCells:(UICollectionView *)collectionView;
- (UICollectionViewCell *)xn_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)xn_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XNRectangularMenuView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) id<XNRectangularMenuViewDelegate> xnDelegate;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIColor *cellBackgroundColor; //default:while
@property (nonatomic, strong) UIColor *cellHighlightBackgroundColor; //default:0xbbbbbb66
@property (nonatomic, strong) UIColor *separatorColor; //default:[UIColor colorWithRGB:0x000000 alpha:0.1]
@property (nonatomic, assign) CGFloat separatorWidth; //default:0.5f
@property (nonatomic, assign) NSUInteger row; //default:4
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
