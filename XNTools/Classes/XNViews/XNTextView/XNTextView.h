//
//  XNTextView.h
//  XNTools
//
//  Created by LuohanCC on 15/12/25.
//  Copyright © 2015年 LuohanCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNTextView : UITextView

@property (nonatomic, retain) UILabel *hintLabel;

- (instancetype)initWithFrame:(CGRect)frame hintText:(NSString *)hintText;
@property (nonatomic, copy, readwrite) void (^InputDidEnd)(NSString *text);
@property (nonatomic, copy, readwrite) void (^InputDidChanged)(NSString *text);

@end

