//
//  AlertViewHandler.h
//  XNTools
//
//  Created by 罗函 on 2016/10/19.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger permissions_loction = 1038;

@interface AlertViewHandler : NSObject
+ (AlertViewHandler *_Nonnull)Instance;
//- (void)show:(NSInteger)tag title:(NSString *_Nullable)title message:(NSString *_Nonnull)message delegate:(id _Nonnull )delegate cancelButtonTitle:(NSString *_Nonnull)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;
@end
