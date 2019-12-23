//
//  XNMultistageTableView.h
//  XNTools
//
//  Created by 罗函 on 2018/8/24.
//  Copyright © 2018年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * [无限级列表控件使用说明]
 * 特点:TableViewCell/HeaderView/FooterView由代理者在外部注册、外部构建。
 * 使用步骤:
 * 1.Model必须继承XNMultistageListModel；实例化XNMultistageTableView并成为代理，实现XNMultistageTableViewDelegate协议方法；
 * 2.[protocol]:注册Cells
 * 3.[protocol]:构建具体的Cells
 * 4.[protocol]:点击某个Cell时，返回这个Cell的子集数据。
 */

#pragma mark - XNMultistageListModel
@interface XNMultistageListModel : NSObject
@property (nonatomic, assign) NSUInteger xn_level;                  //级别
@property (nonatomic, assign) NSUInteger xn_nextLevelCount;         //子级数量
@property (nonatomic, assign) BOOL       xn_nothingMore;            //是否还有子级
@property (nonatomic, assign) BOOL       xn_showingNextLevel;       //子级是否正显示
@property (nonatomic, assign) NSUInteger xn_cellHeight;             //cell高度
@property (nonatomic, strong) NSObject  *xn_obj;                    //其他数据
+ (XNMultistageListModel *)tree;
- (void)addSubLevelCount:(NSUInteger)count;
- (void)clearNextLevel;

/*** 维护整棵树的的重要属性和方法 ***/
@property (nonatomic,   weak) XNMultistageListModel *xn_parent;     //父级
@property (nonatomic, assign) NSUInteger             xn_indexPath;  //在父级中的引索路径
@property (nonatomic, strong) NSMutableArray        *xn_subObjects; //由XNMultistageTableView的使用者维护一颗完整的树
- (void)setupSubObject:(NSMutableArray *)array; // 将新加载的数据更新到xn_subObjects中去
- (NSArray *)getFullIndexPaths; // 获取该节点在整棵树中的完整路径
// 通过该节点完整路径找到该节点在树中找到相应的节点数据
+ (XNMultistageListModel *)seekForObjectsByPath:(NSArray *)paths tree:(XNMultistageListModel *)tree;
@end

#pragma mark - XNMultistageTableView
@class XNMultistageTableView;
@protocol XNMultistageTableViewDelegate <NSObject>
- (void)xn_registerTableViewCells:(XNMultistageTableView *)tableView;
- (UITableViewCell *)xn_tableView:(XNMultistageTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath obj:(XNMultistageListModel *)obj;
- (void)xn_tableView:(XNMultistageTableView *)tableView loadTheSubLevelDataAtParentPath:(NSObject *)obj block:(void (^)(NSArray *))block;
@optional
- (CGFloat)xn_tableView:(XNMultistageTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)xn_tableView:(XNMultistageTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView*)xn_tableView:(XNMultistageTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)xn_tableView:(XNMultistageTableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView*)xn_tableView:(XNMultistageTableView *)tableView viewForFooterInSection:(NSInteger)section;
@end

@interface XNMultistageTableView : UITableView
@property (nonatomic, weak) id<XNMultistageTableViewDelegate> xnDelegate; // 必须实现该代理。注意：不要代理UITableViewDelegate、UITableViewDataSource
- (void)setupUIWithMultistageData:(NSArray *)array; // 初始化dataSource，这是第一级列表的初始化方法，将执行tableView的reloadData方法。
@end
