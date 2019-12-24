//
//  XNTableView.m
//  XNTools
//
//  Created by 罗函 on 2017/9/11.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import "XNTableView.h"
#import "../../Utils/XNUtils.h"
#import "../../XNConf.h"
#import "../../UIViewExtension/UIView+XNEmptyDisplay.h"

@interface XNTableView()

@end
@implementation XNTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if(! (self = [super initWithFrame:frame])) return nil;
    [self setupTableView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if(! (self = [super initWithFrame:frame style:style])) return nil;
    [self setupTableView];
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if(self.emptyView.showing) {
        [self.emptyView display];
    }
}

- (void)setupTableView {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    self.delaysContentTouches = NO;
    // 自动关闭估算高度
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = [XNUtils isNotchScreen] ? 34: 0;
    [self hideSeparator];
}

#pragma mark - Reset separtor offsetX
- (void)xn_viewDidLayoutSubviews {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)xn_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)hideSeparator {
    [self setTableFooterView:[self newTransparentView]];
}

- (nullable UIView *)newTransparentView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - MJRefresh & EmptyDisplay & pageAttribute
- (void)reloadData {
    [self updateEmptyDisplay];
    [super reloadData];
}

- (void)updateEmptyDisplay {
    if(_xnDelegate && [_xnDelegate respondsToSelector:@selector(xn_checkDataSource)]) {
        self.empty = ![_xnDelegate xn_checkDataSource];
    }
}

- (void)setEmpty:(BOOL)empty {
    _empty = empty;
    if(_empty) {
        if (self.mj_footer) {
            self.mj_footer.hidden = YES;
        }
        [self.emptyView display];
    }else{
        if (self.mj_footer) {
            self.mj_footer.hidden = NO;
        }
        [self.emptyView removeEmptyDisplay];
    }
}

- (void)updatePageAttribute:(int)totalPage currentCount:(NSUInteger)currentCount{
    _pageAttribute.totalPage = totalPage;
    if (self.mj_header && self.mj_header.isRefreshing) {
        _pageAttribute.pageIndex = _pageAttribute.initialIndex;
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer) {
        if (self.mj_footer.isRefreshing) {
            _pageAttribute.pageIndex ++;
            [self.mj_footer endRefreshing];
        }
        // 如果接口中没有返回总页数，通过当前页数据是否小于pageSize判断是否是尾页
        if (_pageAttribute.totalPage == DEFAULT_PAGE_TOTAL) {
            if (currentCount < _pageAttribute.pageSize) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
        }
        // 如果接口中含有总页数，通过当前页码判断是否是尾页
        else {
            if (_pageAttribute.pageIndex >= _pageAttribute.totalPage) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }
}

- (NSUInteger)getPageIndexWithMJRefreshState {
    if (self.mj_header && self.mj_header.isRefreshing) {
        return _pageAttribute.initialIndex;
    }
    if (self.mj_footer && self.mj_footer.isRefreshing) {
        return _pageAttribute.pageIndex + 1;
    }
    return _pageAttribute.initialIndex;
}

- (BOOL)isMJReload {
    if (self.mj_header) {
        return self.mj_header.isRefreshing;
    }
    return false;
}

- (BOOL)isMJLoadMore {
    if (self.mj_footer) {
        return self.mj_footer.isRefreshing;
    }
    return false;
}


@end
