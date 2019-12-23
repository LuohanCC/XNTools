//
//  CALayer+XNExtension.m
//  XNTools
//
//  Created by 罗函 on 2018/3/27.
//

#import "CALayer+XNExtension.h"

@implementation CALayer (XNExtension)

/**
 从父Layer中移除

 @param layer layer
 @return result
 */
+ (BOOL)removeLayerFromSuperLayer:(CALayer *)layer {
    if(layer && layer.superlayer) {
        [layer removeFromSuperlayer];
        return YES;
    }
    return NO;
}

@end
