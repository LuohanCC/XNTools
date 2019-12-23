//
//  XNTitleAndSwitchTBCell.h
//  Eccs
//
//  Created by 罗函 on 2018/12/10.
//  Copyright © 2018 罗函. All rights reserved.
//

#import "XNTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XNTitleAndSwitchTBCellDelegate <NSObject>
- (void)switchStatusDidChanged:(BOOL)on indexPath:(NSIndexPath *)indexPath;
@end

@interface XNTitleAndSwitchTBCell : XNTableViewCell
@property (nonatomic, assign) id<XNTitleAndSwitchTBCellDelegate> delegate;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel  *labTitle;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, readwrite, copy) void (^Block)(BOOL value);
- (void)setDelegate:(id<XNTitleAndSwitchTBCellDelegate> _Nonnull)delegate indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
