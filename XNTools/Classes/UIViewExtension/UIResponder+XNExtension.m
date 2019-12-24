//
//  UIResponder+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/5/9.
//

#import "UIResponder+XNExtension.h"
#import <objc/runtime.h>
#import "UIDevice+XNExtension.h"

static char XN_UIResponder_Orientation;

@implementation UIResponder (XNExtension)


- (BOOL)allowRotateEnable {
    UIInterfaceOrientationMask orientation = [self orientation];
    return orientation != UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientationMask)orientation {
    NSNumber *value = objc_getAssociatedObject(self, &XN_UIResponder_Orientation);
    return value ? value.unsignedIntegerValue : UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientationMask)xn_application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [self orientation];
}

- (void)setSupportedInterfaceOrientationsForWindow:(UIInterfaceOrientationMask)orientation {
    objc_setAssociatedObject(self, &XN_UIResponder_Orientation, [NSNumber numberWithUnsignedInteger:orientation], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [UIDevice switchNewOrientation:interfaceOrientation];
}

@end
