//
//  XNMultistageTableView.m
//  XNTools
//
//  Created by 罗函 on 2018/8/24.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import "XNMultistageTableView.h"
#import "../../XNConf.h"
#import "../../Utils/XNUtils.h"

#define XNMultistageCellHeight   40.f
#define XNMultistageHeaderHeight 10.f
#define XNMultistageFooterHeight 10.f

@implementation XNMultistageListModel
+ (XNMultistageListModel *)tree {
    return [XNMultistageListModel new];
}
- (void)addSubLevelCount:(NSUInteger)count {
    _xn_nextLevelCount += count;
}
- (void)clearNextLevel {
    _xn_nextLevelCount = 0;
    _xn_showingNextLevel = false;
}
- (NSUInteger)xn_cellHeight {
    return _xn_cellHeight > 15 ? _xn_cellHeight : XNMultistageCellHeight;
}
- (NSUInteger)xn_level {
    if (!_xn_level) _xn_level = 0;
    return _xn_level;
}
#pragma mark - 维护整棵树的方法，是XNMultistageTableView的使用者才需要用到方法
- (void)setupSubObject:(NSMutableArray *)array {
    if (!_xn_subObjects) _xn_subObjects = [NSMutableArray new];
    _xn_nothingMore = !array || array.count == 0;
    if (!_xn_nothingMore)
        [_xn_subObjects addObjectsFromArray:array];;
}
- (NSArray *)getFullIndexPaths {
    NSMutableArray *path = [NSMutableArray new];
    XNMultistageListModel *parent = self;
    for (NSInteger level = parent.xn_level; level >= 0; level --) {
        [path insertObject:@(parent.xn_indexPath) atIndex:0];
        parent = parent.xn_parent;
    }
    return path.count > 0 ? path : nil;
}
+ (XNMultistageListModel *)seekForObjectsByPath:(NSArray *)paths tree:(XNMultistageListModel *)tree {
    if (!paths || !tree) return nil;
    XNMultistageListModel *object = tree;
    NSUInteger index = 0;
    while (index < paths.count) {
        NSNumber *value = paths[index];
        if (!object.xn_subObjects && index >= object.xn_subObjects.count )
            break;
        object = object.xn_subObjects[value.unsignedIntegerValue];
        index++;
    }
    return object;
}
@end

@interface XNMultistageTableView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *data;
@end
@implementation XNMultistageTableView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:(UITableViewStyleGrouped)];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (!(self = [super initWithFrame:frame style:style])) return nil;
    [self initUI];
    return self;
}

- (void)initUI {
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    self.bounces = YES;
    self.delegate = self;
    self.dataSource = self;
    self.delaysContentTouches = NO;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = [XNUtils isNotchScreen] ? 34: 0;
    self.backgroundColor = [UIColor clearColor];
    self.separatorColor  = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.2];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)setXnDelegate:(id<XNMultistageTableViewDelegate>)xnDelegate {
    _xnDelegate = xnDelegate;
    if ([self respondsToDelegateSelector:@selector(xn_registerTableViewCells:)]) {
        [self.xnDelegate xn_registerTableViewCells:self];
    }
}

- (NSMutableArray *)data {
    if (!_data) _data = [NSMutableArray new];
    return _data;
}

- (void)setupUIWithMultistageData:(NSArray *)array {
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:array];
    [self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XNMultistageListModel *item = (XNMultistageListModel *)obj;
        item.xn_level = 0;
        item.xn_indexPath = idx;
    }];
    [self reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToDelegateSelector:@selector(xn_tableView:heightForRowAtIndexPath:)])
        return [self.xnDelegate xn_tableView:self heightForRowAtIndexPath:indexPath];
    XNMultistageListModel *obj = [self.data objectAtIndex:indexPath.row];
    return obj.xn_cellHeight ? obj.xn_cellHeight : XNMultistageCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([self respondsToDelegateSelector:@selector(xn_tableView:cellForRowAtIndexPath:obj:)])
        cell =  [self.xnDelegate xn_tableView:self cellForRowAtIndexPath:indexPath obj:self.data[indexPath.row]];
    return cell ? cell : [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToDelegateSelector:@selector(xn_tableView:heightForHeaderInSection:)])
        return [self.xnDelegate xn_tableView:self heightForHeaderInSection:section];
    return XNMultistageHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToDelegateSelector:@selector(xn_tableView:viewForHeaderInSection:)])
        return [self.xnDelegate xn_tableView:self viewForHeaderInSection:section];
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToDelegateSelector:@selector(xn_tableView:heightForFooterInSection:)])
        return [self.xnDelegate xn_tableView:self heightForFooterInSection:section];
    return XNMultistageFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToDelegateSelector:@selector(xn_tableView:viewForFooterInSection:)])
        return [self.xnDelegate xn_tableView:self viewForFooterInSection:section];
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XNMultistageListModel *obj = [self.data objectAtIndex:indexPath.row];
    if (obj && [obj isKindOfClass:[XNMultistageListModel class]]) {
        if (obj.xn_showingNextLevel) {
            [self removeSubLevelDataFromIndexPath:indexPath parent:obj];
            return;
        }
        __weak typeof(self) weakSelf = self;
        if ([self respondsToDelegateSelector:@selector(xn_tableView:loadTheSubLevelDataAtParentPath:block:)]) {
            [self.xnDelegate xn_tableView:self loadTheSubLevelDataAtParentPath:obj block:^(NSArray *arr) {
                [weakSelf insetSubLevelDataAtIndexPath:indexPath parent:obj arr:arr];
            }];
        }
    }
}

#pragma private methods
- (BOOL)respondsToDelegateSelector:(SEL)sel {
    return (_xnDelegate && [_xnDelegate respondsToSelector:sel]);
}

- (void)insetSubLevelDataAtIndexPath:(NSIndexPath *)indexPath parent:(XNMultistageListModel *)parent arr:(NSArray *)arr {
    parent.xn_showingNextLevel = true;
    NSMutableArray *animationIndexs = nil;
    parent.xn_nothingMore = (!arr || arr.count == 0) ? true : false;
    if (! parent.xn_nothingMore) {
        NSUInteger position = indexPath.row + 1;
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(position, arr.count)];
        [self.data insertObjects:arr atIndexes:indexes];
        [parent addSubLevelCount:arr.count];
        animationIndexs = [[NSMutableArray alloc] initWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XNMultistageListModel *item = (XNMultistageListModel *)obj;
            item.xn_indexPath = idx;
            item.xn_parent = parent;
            item.xn_level = parent.xn_level + 1;
            [animationIndexs addObject:[NSIndexPath indexPathForRow:position + idx inSection:indexPath.section]];
        }];
    }
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    if (animationIndexs && animationIndexs.count > 0)
        [self insertRowsAtIndexPaths:animationIndexs withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}

- (void)removeSubLevelDataFromIndexPath:(NSIndexPath *)indexPath parent:(XNMultistageListModel *)parent {
    parent.xn_showingNextLevel = false;
    NSMutableArray *animationIndexs = nil;
    NSUInteger position = indexPath.row + 1;
    if (! parent.xn_nothingMore) {
        animationIndexs = [NSMutableArray new];
        NSUInteger index = position;
        while (index < self.data.count) {
            XNMultistageListModel *item = self.data[index];
            if (item.xn_level <= parent.xn_level) break;
            [item clearNextLevel];
            [animationIndexs addObject:[NSIndexPath indexPathForRow:index inSection:indexPath.section]];
            index ++;
        }
    }
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    if (animationIndexs && animationIndexs.count > 0) {
        [self.data removeObjectsInRange:NSMakeRange(position, animationIndexs.count)];
        [self deleteRowsAtIndexPaths:animationIndexs withRowAnimation:UITableViewRowAnimationFade];
    }
    [self endUpdates];
    [parent clearNextLevel];
}

@end
