//
//  XNTitleAndSwitchTBCell.m
//  Eccs
//
//  Created by 罗函 on 2018/12/10.
//  Copyright © 2018 罗函. All rights reserved.
//

#import "XNTitleAndSwitchTBCell.h"
#import "../../UIViewExtension/UIColor+XNExtension.h"
#import "../../UIViewExtension/UIView+XNExtension.h"
#import <Masonry/Masonry.h>

@implementation XNTitleAndSwitchTBCell

+ (NSString *)cellId {
    return NSStringFromClass([XNTitleAndSwitchTBCell class]);
}

+ (Class)cellClass {
    return [XNTitleAndSwitchTBCell class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)labTitle {
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.font = [UIFont systemFontOfSize:15.f];
        _labTitle.textColor = [UIColor colorWithRGB:0x333333];
        _labTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _labTitle;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStatusDidChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _switchView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.labTitle.superview) {
        [self.contentView addSubview:self.labTitle];
        [self.contentView addSubview:self.switchView];
    }
    CGRect switchFrame = self.switchView.frame;
    CGRect titleFrame = self.labTitle.frame;
    CGFloat switchWidth = 50.f;
    CGFloat switchHeight = 31.f;
    CGFloat titleHeight = switchHeight;
    if (CGRectGetMinX(switchFrame) == 0 && CGRectGetMinY(switchFrame) == 0) {
        switchFrame = CGRectMake(self.width-switchWidth-15, (self.height-switchHeight)/2, switchWidth, switchHeight);
    }
//    if (CGRectGetMinX(titleFrame) == 0 && CGRectGetMinY(titleFrame) == 0) {
        CGSize size = [self.labTitle sizeThatFits:CGSizeMake(self.width - switchWidth - 15 - 10, titleHeight)];
//        titleFrame = CGRectMake(15, (self.height-titleHeight)/2, size.width, size.height);
        titleFrame = CGRectMake(15, (self.height-titleHeight)/2, size.width, size.height);
//    }
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(switchFrame.origin.x);
        make.top.mas_equalTo(switchFrame.origin.y);
        make.width.mas_equalTo(switchFrame.size.width);
        make.height.mas_equalTo(switchFrame.size.height);
    }];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           make.leading.mas_equalTo(titleFrame.origin.x);
           make.top.mas_equalTo(titleFrame.origin.y);
           make.width.mas_equalTo(titleFrame.size.width);
           make.height.mas_equalTo(titleFrame.size.height);
       }];
//    _switchView.frame = switchFrame;
//    _labTitle.frame = titleFrame;
}

- (void)switchStatusDidChanged:(UISwitch *)switchView {
    if (_delegate && [_delegate respondsToSelector:@selector(switchStatusDidChanged:indexPath:)]) {
        [_delegate switchStatusDidChanged:switchView.on indexPath:_indexPath];
    }
    if (_Block) {
        _Block(switchView.on);
    }
}

- (void)setDelegate:(id<XNTitleAndSwitchTBCellDelegate>)delegate indexPath:(NSIndexPath *)indexPath {
    _delegate = delegate;
    _indexPath = indexPath;
}
@end
