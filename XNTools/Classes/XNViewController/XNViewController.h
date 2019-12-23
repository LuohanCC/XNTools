//
//  XNViewController.h
//  XNTools
//
//  Created by 罗函 on 16/5/23.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+XNExtension.h"

@interface XNViewController : UIViewController
- (void)setTransparentNavigationBar:(BOOL)enable;
- (void)initSubviews;
- (void)initialization;
@end
