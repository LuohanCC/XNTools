//
//  AppDelegate.h
//  XNTools
//
//  Created by 罗函 on 12/08/2017.
//  Copyright (c) 2017 罗函. All rights reserved.
//

@import UIKit;

@class XNToolsLogo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) XNToolsLogo *vMask;
@property (nonatomic, assign) BOOL isLoading;

@end
