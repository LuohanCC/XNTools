//
//  XNRectangularMenuView.m
//  XNTools
//
//  Created by 罗函 on 2018/11/23.
//  Copyright © 2018 罗函. All rights reserved.
//

#import "XNRectangularMenuView.h"

@interface XNRectangularMenuView()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger maxCount;
@end
@implementation XNRectangularMenuView

- (CGFloat)getItemWidth {
    return (self.bounds.size.width - self.separatorWidth * (self.row + 1)) / self.row;
}

- (CGFloat)getCollectionViewHeight {
    int itemWidth = [self getItemWidth];
    NSUInteger section = _titles.count / self.row;
    if (_titles.count % self.row) {
        section += 1;
    }
    CGFloat height = (itemWidth + self.separatorWidth) * section + self.separatorWidth;
    if (height > self.bounds.size.height) {
        height = self.bounds.size.height;
    }
    return height;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.delaysContentTouches = NO;
    }
    return _collectionView;
}

- (void)layoutSubviews {
    self.backgroundColor = [UIColor clearColor];
    CGFloat separator = self.separatorWidth;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = separator;
    layout.minimumInteritemSpacing = separator;
    layout.sectionInset = UIEdgeInsetsMake(separator, separator, separator, separator);
    
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), [self getCollectionViewHeight]);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = self.separatorColor;
    [self addSubview:self.collectionView];
    if (_xnDelegate && [_xnDelegate respondsToSelector:@selector(xn_registerTableViewCells:)]) {
        [_xnDelegate xn_registerTableViewCells:_collectionView];
    }
}

- (UIColor *)cellBackgroundColor {
    return _cellBackgroundColor ? _cellBackgroundColor : [UIColor whiteColor];
}

- (UIColor *)cellHighlightBackgroundColor {
    return _cellHighlightBackgroundColor ? _cellHighlightBackgroundColor : [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.1];;
}

- (UIColor *)separatorColor {
    return _separatorColor ? _separatorColor : [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.1];
}

- (NSUInteger)row {
    return _row > 0 ? _row : 4;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (titles && titles.count > 0) {
        _maxCount = _titles.count;
        if (_maxCount % self.row) {
            _maxCount += (self.row - _maxCount % self.row);
        }
    }
}

#pragma mark collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _maxCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = self.row;
    int width = [self getItemWidth];
    if ((indexPath.row + 1) % row) {
        return CGSizeMake(width, width);
    } else {
        float widthForRow4 = self.bounds.size.width - width * (row-1) - self.separatorWidth * (row+1);
        return CGSizeMake(widthForRow4, width);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (indexPath.row < _titles.count) {
        if (_xnDelegate && [_xnDelegate respondsToSelector:@selector(xn_collectionView:didSelectItemAtIndexPath:)]) {
            [_xnDelegate xn_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_xnDelegate && [_xnDelegate respondsToSelector:@selector(xn_collectionView:cellForItemAtIndexPath:)])
        return [_xnDelegate xn_collectionView:collectionView cellForItemAtIndexPath:indexPath];
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = self.cellHighlightBackgroundColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = self.cellBackgroundColor;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _titles.count) {
        return YES;
    }
    return NO;
}

@end
