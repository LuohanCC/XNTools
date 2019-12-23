//
//  LHMatrixView.m
//  XNTools
//
//  Created by 罗函 on 16/8/15.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "LHMatrixView.h"
#import "XNUtils.h"
#import "UIView+XNExtension.h"
#import "UIImage+XNExtension.h"
#import "UILabel+XNExtension.h"

#define CCOR_BLUE_HOME_CELLBG   [UIColor colorWithRed:24/255.0 green:36/255.0  blue:56/255.0  alpha:1]
#define BorderColor  [UIColor colorWithRed:1 green:1  blue:1  alpha:0.1]
#define ITEM_TAG 800
#define cellRow 3

@interface LHMatrixView()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation LHMatrixView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                 normalImages:(NSArray *)norImgs
                 selectImages:(NSArray *)selImgs {
    if(self = [super initWithFrame:frame]) {
        [self initViews:titles normalImages:norImgs selectImages:selImgs];
    }
    return self;
}

- (void)initViews:(NSArray *)titles
     normalImages:(NSArray *)norImgs
     selectImages:(NSArray *)selImgs {
    
    if(!titles || !norImgs || titles.count != norImgs.count)
        return;
    
    _items = [[NSMutableArray alloc] initWithCapacity:titles.count];
    int amount = (int)titles.count;
    int totalRow = amount / cellRow + (amount % cellRow != 0 ? 1 : 0);
    double line_W = 0.5;
    double item_w = (self.bounds.size.width - line_W * 3)/ cellRow;
    double item_H = (self.bounds.size.height - (totalRow + 1) * line_W) / totalRow;
    
    
    int index = 0;
    for (int i = 0; i<amount; i++, index++) {
        if(i % cellRow == 0) index = 0;
        int row = i / cellRow;
        CGRect rect = CGRectMake(index * (item_w+line_W), row*item_H + (row+1)*line_W, item_w, item_H);
        DiamondCell *cell = [[DiamondCell alloc] initWithFrame:rect font:[UIFont boldSystemFontOfSize:15.f]];
        [cell setData:titles[i] norImg:norImgs[i] selImg:selImgs[i]];
        [cell setBackgroundColor:CCOR_BLUE_HOME_CELLBG];
        [cell setTag:ITEM_TAG + i];
        [cell addTarget:self action:@selector(action_item:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cell];
        [_items addObject:cell];
    }
    
    //LINE
    for (int i=1; i<4; i++) {
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(i*item_w + (i-1)*line_W, line_W, line_W, self.bounds.size.height - line_W*2)];
        [vline setBackgroundColor:BorderColor];
        [self addSubview:vline];
    }
    for (int i=0; i<=totalRow; i++) {
        UIView *hline = [[UIView alloc] initWithFrame:CGRectMake(0, i*item_H + i*line_W, self.bounds.size.width, line_W)];
        [hline setBackgroundColor:BorderColor];
        [self addSubview:hline];
    }
    
    self.backgroundColor = CCOR_BLUE_HOME_CELLBG;
}

- (void)action_item:(UIButton *)button {
    NSInteger index = button.tag - ITEM_TAG;
    if(self.delegate && [self.delegate respondsToSelector:@selector(indexOfCell:)]) {
        [self.delegate indexOfCell:index];
    }
}

- (void)setUnreadCountAtIndex:(NSInteger)index unreadCount:(NSUInteger)unreadCount {
    if(index < _items.count) {
        DiamondCell *cell = _items[index];
        UILabel *unread = cell.unread;
        NSString *display = @"0";
        if (unreadCount > 999) {
            display = @"999+";
        } else {
            display = [NSString stringWithFormat:@"%d", (int)unreadCount];
        }
        unread.text = display;
        unread.hidden = unreadCount == 0;
        
        CGSize size = [unread getTextContentSizeWithBoundsSize:CGSizeMake(30, unread.height)];
        if (size.width < unread.height)
            size.width = unread.height;
        if (unreadCount > 10)
            size.width += 8;
        cell.unread.frame = CGRectMake(cell.bounds.size.width-size.width-5, 5+unread.height, size.width, unread.height);
    }
}

@end


/*  *  *  *  *  * DiamondCell  *  *  *  *  *  */
@interface DiamondCell()
@property(nonatomic, strong) UIFont *textFont;
@end

@implementation DiamondCell

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame font:[UIFont boldSystemFontOfSize:13.f]];
}

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font {
    if(self == [super initWithFrame:frame]) {
        /*
         double img_w = 40.0;
         double img_h = 40.0;
         _picture = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-img_w)/2,
         (self.bounds.size.height-img_h)/2,
         img_w, img_h)];
         [_picture setContentMode:(UIViewContentModeCenter)];
         [self addSubview:_picture];   */
        self.textFont = font;
        double title_w = self.bounds.size.width - 20;
        double title_h = _textFont.pointSize * 2.5;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height/2, title_w, title_h)];
        _title.textColor = [UIColor whiteColor];
        _title.font = _textFont;
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
        double unread_w = 18;
        double unread_margin = 5;
        _unread = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-unread_w-unread_margin, unread_w+unread_margin, unread_w, unread_w)];
        _unread.font = [UIFont systemFontOfSize:12.f];
        _unread.textColor = [UIColor whiteColor];
        _unread.textAlignment = NSTextAlignmentCenter;
        _unread.backgroundColor = [UIColor redColor];
        [_unread createBordersWithColor:_unread.backgroundColor withCornerRadius:_unread.frame.size.height/2 andWidth:0];
        _unread.hidden = YES;
        [self addSubview:_unread];
        [self setMultipleTouchEnabled:YES];
        [self setBackgroundImage:[UIImage createImageWithUIColor:[UIColor colorWithRed:0 green:0  blue:0  alpha:0.5]] forState:(UIControlStateHighlighted)];
    }
    return self;
}

- (void)setData:(NSString *)text image:(UIImage *)image {
    if(_title)  _title.text = text;
    if(_picture) _picture.image = image;
}

- (void)setData:(NSString *)text norImg:(UIImage *)norImg selImg:(UIImage *)selImg {
    if(_picture) {
        [_picture removeFromSuperview];
        _picture = nil;
    }
    if(text) _title.text = text;
    if(norImg) [self setImage:norImg forState:(UIControlStateNormal)];
    if(selImg) [self setImage:selImg forState:(UIControlStateHighlighted)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 10, 0)];
    
    [self bringSubviewToFront:_title];
}

@end

