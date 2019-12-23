//
//  XNTableViewCell.m
//  Eccs
//
//  Created by 罗函 on 2018/12/10.
//  Copyright © 2018 罗函. All rights reserved.
//

#import "XNTableViewCell.h"

@implementation XNTableViewCell

+ (NSString *)cellId {
    return NSStringFromClass([XNTableViewCell class]);
}

+ (Class)cellClass {
    return [XNTableViewCell class];
}

@end
