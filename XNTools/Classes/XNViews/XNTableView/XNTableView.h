//
//  XNTableView.h
//  XNTools
//
//  Created by 罗函 on 2017/9/11.
//  Copyright © 2017年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "UIView+XNEmptyDisplay.h"

#define TABLE_CELL_HEIGHT_45     45.f
#define TABLE_HEADER_HEIGHT_10   10.f
#define DEFAULT_PAGE_TOTAL       -1

typedef BOOL (^CheckDataSources)(void);
typedef void (^XN_MJRefresh_Header_Footer)(void);

typedef struct {
    int initialIndex;
    int pageIndex;
    int totalPage;
    int pageSize;
}TBPageControlAttribute;

CG_INLINE TBPageControlAttribute
TBPageControlAttributeMake(int initialIndex, int pageIndex, int totalPage, int pageSize) {
    TBPageControlAttribute pageControl = {initialIndex, pageIndex, totalPage, pageSize};
    return pageControl;
}

@protocol XNTableViewDelegate <NSObject>
@optional
- (void)xn_tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath obj:(NSObject *)obj;
- (void)xn_tableView:(UITableView *)tableView didUpdateDataSource:(NSObject *)obj;
// 根据数据源是否为空来隐藏/显示EmptyView和MJFooter
- (BOOL)xn_checkDataSource;
@end

@interface XNTableView : UITableView
@property (nonatomic) TBPageControlAttribute pageAttribute;
@property (nonatomic, assign, getter=isEmpty) BOOL empty;
@property (nonatomic, assign) id<XNTableViewDelegate> xnDelegate;

/**
 根据刷新动作返回当前请求的pageIndex
 */
- (NSUInteger)getPageIndexWithMJRefreshState;

/**
 获取到数据后，如果接口中带有totalPage、pageIndex、pageSize字段，调用此方法
 */
- (void)updatePageAttribute:(int)totalPage currentCount:(NSUInteger)currentCount;

/**
 是否下拉刷新
 */
- (BOOL)isMJReload;

/**
 是否上滑加载更多
 */
- (BOOL)isMJLoadMore;

/**
 用于设置透明的hreader和footer
 */
- (UIView *)newTransparentView;

/**
 Separtor offsetX为0
 */
- (void)xn_viewDidLayoutSubviews;
- (void)xn_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end

