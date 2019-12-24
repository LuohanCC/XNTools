//
//  AlertViewHandler.m
//  XNTools
//
//  Created by 罗函 on 2016/10/19.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "AlertViewHandler.h"




@interface AlertViewHandler() <UIAlertViewDelegate>

@end

@implementation AlertViewHandler

+ (AlertViewHandler *)Instance {
    static AlertViewHandler *handler = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        handler = [AlertViewHandler new];
    });
    return handler;
}


//- (void)show:(NSInteger)tag title:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:delegate ? delegate : self
//                                              cancelButtonTitle:cancelButtonTitle
//                                              otherButtonTitles:otherButtonTitles, nil];
//    alertView.tag = tag;
//    [alertView show];
//}
//
//
//- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
//    if (alertView.tag == permissions_loction && buttonIndex == 1){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}




@end
