//
//  UIView+XNEmptyDisplay.m
//  XNTools
//
//  Created by 罗函 on 14/7/5.
//  Copyright © 2014年 罗函. All rights reserved.
//

#import "UIView+XNEmptyDisplay.h"
#import <objc/runtime.h>
#import "UILabel+XNExtension.h"
#import "UIView+XNExtension.h"


@interface XNEmptyView()
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, weak) UIView *realEmptyView;
@end

@implementation XNEmptyView

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)labTitle {
    if(!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:0.4];
        _labTitle.font = [UIFont systemFontOfSize:14.f];
    }
    return _labTitle;
}

- (UILabel *)labMessage {
    if(!_labMessage) {
        _labMessage = [UILabel new];
        _labMessage.textAlignment = NSTextAlignmentCenter;
        _labMessage.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:0.2];
        _labMessage.font = [UIFont systemFontOfSize:12.f];
    }
    return _labMessage;
}

- (UITapGestureRecognizer *)tapGesture {
    if(!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    }
    return _tapGesture;
}

- (BOOL)showing {
    return self.superview != nil;
}

- (void)addEmptyViewAtTargetView {
    if(!_realEmptyView.superview) {
        [self.targetView addSubview:_realEmptyView];
        if (_realEmptyView == self) {
            [self addGestureRecognizer:self.tapGesture];
        }
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    if(_delegate && [_delegate respondsToSelector:@selector(emptyDisplayTouchDown)]) {
        [_delegate emptyDisplayTouchDown];
    }
}

- (void)initWithImage:(UIImage *)image title:(NSString *)title info:(NSString *)info {
    self.imageView.image = image;
    self.labTitle.text = title;
    self.labMessage.text = info;
}

- (void)display {
    if(!_targetView) return;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.clipsToBounds = NO;
    if (_customView) {
        _realEmptyView = _customView;
        [self addEmptyViewAtTargetView];
        return;
    }
    _realEmptyView = self;
    if (self.imageView.image) {
        if (CGRectEqualToRect(self.imageView.frame, CGRectZero)) {
            self.imageView.size = self.imageView.image.size;
        }
        [self addSubview:self.imageView];
    }
    if (self.labTitle.text && self.labTitle.text.length > 0) {
        if (CGRectEqualToRect(self.labTitle.frame, CGRectZero)) {
            self.labTitle.size = [self.labTitle getTextContentSizeWithBoundsSize:self.targetView.bounds.size];
        }
        [self addSubview:self.labTitle];
    }
    
    if (self.labMessage.text && self.labMessage.text.length > 0) {
        if (CGRectEqualToRect(self.labMessage.frame, CGRectZero)) {
            self.labMessage.size = [self.labMessage getTextContentSizeWithBoundsSize:self.targetView.bounds.size];
        }
        [self addSubview:self.labMessage];
    }
    // set frame
    CGFloat width = MAX(MAX(CGRectGetWidth(self.imageView.frame), CGRectGetWidth(self.labTitle.frame)), CGRectGetWidth(self.labMessage.frame));
    CGFloat height = self.imageView.height + self.labTitle.height + self.labMessage.height + 8 * 2;
    CGFloat margin = 8.0;
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        self.frame = CGRectMake((self.targetView.bounds.size.width-width)/2, (self.targetView.bounds.size.height-height)/2, width, height);
    }
    self.imageView.frame = CGRectMake((width-self.imageView.width)/2, 0,
                                      self.imageView.size.width, self.imageView.size.height);
    self.labTitle.frame = CGRectMake((width-self.labTitle.width)/2,
                                     self.imageView.bottom + margin, self.labTitle.width, self.labTitle.height);
    self.labMessage.frame = CGRectMake((width-self.labMessage.width)/2,
                                       self.labTitle.bottom + margin, self.labMessage.width, self.labMessage.height);
    [self addEmptyViewAtTargetView];
}

- (void)removeEmptyDisplay {
    if(_realEmptyView == self) {
        if(self.gestureRecognizers) {
            [self removeGestureRecognizer:self.tapGesture];
        }
    }
    [_realEmptyView removeFromSuperview];
    
}

@end


static char kCXNEmptyView;
@implementation UIView (XNEmptyDisplay)

- (void)setEmptyView:(UIView *)emptyView {
    objc_setAssociatedObject(self, &kCXNEmptyView, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XNEmptyView *)emptyView {
    XNEmptyView *view = objc_getAssociatedObject(self, &kCXNEmptyView);
    if(!view) {
        view = [XNEmptyView new];
        view.targetView = self;
        [self setEmptyView:view];
    }
    return view;
}

@end
