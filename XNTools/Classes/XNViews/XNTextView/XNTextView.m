//
//  XNTextView.m
//  XNTools
//
//  Created by LuohanCC on 15/12/25.
//  Copyright © 2015年 LuohanCC. All rights reserved.
//

#import "XNTextView.h"

@interface XNTextView()<UITextViewDelegate>


@end

@implementation XNTextView

- (instancetype)initWithFrame:(CGRect)frame hintText:(NSString *)hintText {
    self = [super initWithFrame:frame];
    if(self) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, self.frame.size.width-15, 20)];
        _hintLabel.textColor = [UIColor lightGrayColor];
        _hintLabel.font = [UIFont systemFontOfSize:15.f];
        _hintLabel.text = hintText;
        [self addSubview:_hintLabel];
        
        self.font = [UIFont systemFontOfSize:15.f];
        self.selectedRange = NSMakeRange(0, 0);
        self.delegate = self;
        
        [self addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _hintLabel.frame = CGRectMake(6, 6, self.bounds.size.width-15, 20);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([object isKindOfClass:[self class]]) {
        [self hintLabelHiddenWithText:self.text];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"text"];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self hintLabelHiddenWithText:textView.text];
    if(_InputDidChanged) _InputDidChanged(self.text);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(_InputDidEnd) _InputDidEnd(self.text);
}

- (void)hintLabelHiddenWithText:(NSString *)text {
    if(text.length > 0) {
        _hintLabel.hidden = YES;
    }else{
        _hintLabel.hidden = NO;
    }
}



@end

