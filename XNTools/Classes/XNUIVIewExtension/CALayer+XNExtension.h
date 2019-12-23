//
//  CALayer+XNExtension.h
//  XNTools
//
//  Created by 罗函 on 2018/3/27.
//

#import <UIKit/UIKit.h>

@interface CALayer (XNExtension)

/**
 从父Layer中移除
 
 @param layer layer
 @return result
 */
+ (BOOL)removeLayerFromSuperLayer:(CALayer *)layer;

@end
