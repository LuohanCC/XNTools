//
//  XNTableViewCell.h
//  Eccs
//
//  Created by 罗函 on 2018/12/10.
//  Copyright © 2018 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XNTableViewCell : UITableViewCell
+ (NSString *)cellId;
+ (Class)cellClass;
@end

NS_ASSUME_NONNULL_END
