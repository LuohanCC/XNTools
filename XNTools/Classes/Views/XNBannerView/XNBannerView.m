//
//  XNBannerView.m
//  XNTools
//
//  Created by LuohanCC on 15/12/19.
//  Copyright © 2015年 Luohan. All rights reserved.
//

#import "XNBannerView.h"
#import "NSData+XNDataCache.h"
#import "../../XNConf.h"

#define AUTO_SLIDE_INTERVAL 3.0f
#define AUTO_SLIDE_SPEEND   0.3f

@interface XNBannerView()<UIScrollViewDelegate>
@property (nonatomic, assign) BOOL isImageFromUrl;
@property (nonatomic, retain) UIScrollView  *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView   *leftImageView;
@property (nonatomic, retain) UIImageView   *centerImageView;
@property (nonatomic, retain) UIImageView   *rightImageView;
@property (nonatomic, assign) NSInteger     imageCount;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, assign) double        slideWidth;
@end

@implementation XNBannerView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    self = [super initWithFrame:frame];
    if(self){
        if(imageArray && imageArray.count > 0){
            _imageArray = [[NSMutableArray alloc] initWithArray:imageArray];
            _imageCount = _imageArray.count;
            [self initXNBannerView];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageURLGroup:(NSArray *)imageURLGroup {
    self = [super initWithFrame:frame];
    if(self){
        if(imageURLGroup && imageURLGroup.count > 0){
            _isImageFromUrl = YES;
            _imageURLGroup  = [[NSMutableArray alloc] initWithArray:imageURLGroup];
            _imageArray     = [[NSMutableArray alloc] initWithCapacity:_imageArray.count];
            _imageCount     = _imageURLGroup.count;
            [self initalizeImageArray];
            [self initXNBannerView];
            [self loadImageWithImageURLsGroup:_imageURLGroup];
        }
    }
    return self;
}

- (void)initXNBannerView {
    [self addScrollView];
    [self addTrisImageView];
    [self addPageControl];
    if(!_isImageFromUrl){
        [self setDefaultImage];
        [self setupAutoSlide:YES];
    }
}

- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
    [self addSubview:_scrollView];
    _slideWidth = _scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(_slideWidth, 0)];
}

- (void)addPageControl {
    _pageControl=[[UIPageControl alloc] init];
    CGSize size= [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-20);
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:0.5];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _pageControl.numberOfPages=_imageCount;
    [self addSubview:_pageControl];
}

- (void)addTrisImageView {
    double image_lrc_width  = _scrollView.bounds.size.width;
    double image_lrc_height = _scrollView.bounds.size.height;
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image_lrc_width, image_lrc_height)];
    _leftImageView.contentMode = UIViewContentModeScaleToFill;
    [_scrollView addSubview:_leftImageView];
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(image_lrc_width, 0, image_lrc_width, image_lrc_height)];
    _centerImageView.contentMode = UIViewContentModeScaleToFill;
    [_scrollView addSubview:_centerImageView];
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * image_lrc_width, 0, image_lrc_width, image_lrc_height)];
    _rightImageView.contentMode = UIViewContentModeScaleToFill;
    [_scrollView addSubview:_rightImageView];
    
    UITapGestureRecognizer *touchEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl)];
    [_centerImageView addGestureRecognizer:touchEvent];
    [_centerImageView setUserInteractionEnabled:YES];
}

- (void)setDefaultImage {
    if(_imageArray.count == _imageCount) {
        _leftImageView.image   = _imageArray[_imageCount-1];
        _centerImageView.image = _imageArray[0];
        _rightImageView.image  = _imageArray[1];
        _pageControl.currentPage = self.visibleIndex = 0;
    }
}

- (void)setupAutoSlide:(BOOL)on {
    WeakSelf
    void (^STOP_AUTOSLIDE)(void) = ^(){
        if(weakSelf.timer) {
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        }
    };
    if(on) {
        STOP_AUTOSLIDE();
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:AUTO_SLIDE_INTERVAL target:weakSelf selector:@selector(slideToNaxePage) userInfo:nil repeats:YES];
    }else{
        STOP_AUTOSLIDE();
    }
}

- (void)slideToNaxePage {
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width*2, 0) animated:YES];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self setupAutoSlide:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(_scrollView.contentOffset.x >= _slideWidth * 2 || scrollView.contentOffset.x <= 0) {
        BOOL istoTheright = _scrollView.contentOffset.x >= _slideWidth * 2;
        [self reloadImageViews:istoTheright];
        _scrollView.pagingEnabled = YES;
        _pageControl.currentPage = self.visibleIndex;
        [_scrollView setContentOffset:CGPointMake(_slideWidth, 0)];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setupAutoSlide:YES];
}

- (void)reloadImageViews:(BOOL)istoTheright {
    if(_imageArray.count == 0 || _imageArray.count < self.visibleIndex) return;
    self.visibleIndex = istoTheright ? (self.visibleIndex+1) % _imageCount : (self.visibleIndex+_imageCount-1) % _imageCount;
    if(_delegate && [_delegate respondsToSelector:@selector(xnBannerVisibleIndexDidChanged:)]) {
        [_delegate xnBannerVisibleIndexDidChanged:self.visibleIndex];
    }
    NSInteger leftIndex = (self.visibleIndex+_imageCount-1)%_imageCount;
    NSInteger rightIndex = (self.visibleIndex+1)%_imageCount;
    //    NSLog(@"+++ %ld", _currentIndex);
    _centerImageView.image = _imageArray[self.visibleIndex];
    _leftImageView.image = _imageArray[leftIndex];
    _rightImageView.image = _imageArray[rightIndex];
    
}

- (void)openUrl {
    if(_delegate && [_delegate respondsToSelector:@selector(xnBannerOpenUrlWithIndex:)]) {
        [_delegate xnBannerOpenUrlWithIndex:self.visibleIndex];
    }
}

#pragma mark - LoadingImages
- (void)initalizeImageArray {
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:_imageCount];
    for (int i = 0; i < _imageCount; i++) {
        UIImage *image = [[UIImage alloc] init];
        [images addObject:image];
    }
    self.imageArray = images;
}

- (void)loadImageWithImageURLsGroup:(NSArray *)imageURLsGroup{
    for (int i = 0; i < imageURLsGroup.count; i++) {
        [self loadImageAtIndex:i];
    }
}

- (void)loadImageAtIndex:(NSInteger)index{
    if(_imageURLGroup.count==0) return;
    WeakSelf
    void (^IS_SUCCESSFUL)(void) = ^(){
        if (index == weakSelf.imageCount - 1) {
            [self setDefaultImage];
            [self setupAutoSlide:YES];
        }
    };
    NSString *urlStr = _imageURLGroup[index];
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSData *data = [NSData getDataCacheWithIdentifier:urlStr];
//    if (data) {
//        [_imageArray setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
//        IS_SUCCESSFUL();
//        return;
//    }
    [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (!image) return; // 防止错误数据导致崩溃
                    [weakSelf.imageArray setObject:image atIndexedSubscript:index];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        IS_SUCCESSFUL();
                    });
        //            [data saveDataCacheWithIdentifier:url.absoluteString];
                } else { // 加载数据失败
                    static int repeat = 0;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (repeat > 10) return;
                        [self loadImageAtIndex:index];
                        repeat++;
                    });
                }
    }];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
//        if (!connectionError) {
//            UIImage *image = [UIImage imageWithData:data];
//            if (!image) return; // 防止错误数据导致崩溃
//            [weakSelf.imageArray setObject:image atIndexedSubscript:index];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                IS_SUCCESSFUL();
//            });
////            [data saveDataCacheWithIdentifier:url.absoluteString];
//        } else { // 加载数据失败
//            static int repeat = 0;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (repeat > 10) return;
//                [self loadImageAtIndex:index];
//                repeat++;
//            });
//        }
//    }];
}


@end

