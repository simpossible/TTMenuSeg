//
//  TTMenuSeg.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSeg.h"
#import "TTMenuSegView.h"
#import <UIKit/UIKit.h>

@interface TTMenuSeg()<TTMenuSegItemSeger>

/**所有的title*/
@property (nonatomic, strong) NSArray<TTMenuSegItem *> * items;

@property (nonatomic, strong) UIView * indicatorView;

/**记录上次点击的时候 期望到达的off*/
@property (nonatomic, assign) CGFloat touchExpectOff;

/**是否接受外部的滚动*/
@property (nonatomic, assign) BOOL shouldReciveScroll;

/**记录当前的偏移量*/
@property (nonatomic, assign) CGFloat currentOff;

/**所有的视图-用来作为重用逻辑*/
@property (nonatomic, strong) NSDictionary * allViews;


@property (nonatomic, strong) UIScrollView * scrollView;

/**当前的seg*/
@property (nonatomic, assign) TTMenuSegItem * currentItem;

@end

@implementation TTMenuSeg


- (instancetype)initWithItems:(NSArray<TTMenuSegItem *> *)items {
    if (self = [self init]) {
        _shouldReciveScroll = YES;
        _indicatorColor = [UIColor blackColor];
        _indicatorHeight = 4;
        _indicatorWidthMin = 12;
        _indicatorWidthMax = 24;
        _indeicatorCorner = 2;
        _needIndicator = YES;
        self.items = items;
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        _inset = UIEdgeInsetsMake(0, 16, 0, 0);
        [self addSubView:self.scrollView];
    }
    return self;
}


- (void)refreshItems:(NSArray *)items {
    if (!self.items) {
        self.items = items;
    }else {
        for (TTMenuSegItem *item in self.items) {
            [item clear];
        }
        self.items = items;
    }
    
    TTMenuSegItem *preItem = nil;
    for (int i = 0; i < self.items.count; i ++) {
        TTMenuSegItem *item =  [self.items objectAtIndex:i];
        item.seger = self;
        item.preItem = preItem;
        preItem.nextItem = item;
        
        TTMenuSegView *segView = [self viewForItem:item];
        segView.segItem = item;
        [self.scrollView addSubview:segView];
        preItem = item;
    }
    TTMenuSegItem *item = [self.items firstObject];
    [item layOutWithX:_inset.left];
    [item initialExpectOff:0];
    [self refreshSuperHeight];
}

- (TTMenuSegItem *)itemAtIndex:(NSInteger)i {
    if (self.items.count > i) {
        return [self.items objectAtIndex:i];
    }
    return nil;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self initialUI];
    [self refreshSuperHeight];
}

- (void)initialUI {
    [self initialIndicatorView];
    
    [self refreshItems:self.items];
}

- (TTMenuSegView *)viewForItem:(TTMenuSegItem *)item {
    Class cls = [item itemViewClass];
    return [[cls alloc] init];
}

- (void)initialIndicatorView {
    if (_needIndicator) {
        self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.indicatorWidthMin, self.indicatorHeight)];
        [self.scrollView addSubview:self.indicatorView];
        self.indicatorView.backgroundColor = self.indicatorColor;
        self.indicatorView.layer.cornerRadius = self.indeicatorCorner;
        self.indicatorView.layer.masksToBounds = YES;
    }
}


- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    _indicatorHeight = indicatorHeight;
    _indeicatorCorner = indicatorHeight / 2;
}

- (void)setOutOff:(CGFloat)off {
    if (off == _touchExpectOff) {
//        _shouldReciveScroll = YES;
    }
//    if (_shouldReciveScroll) {
        _currentOff = off;
    if (_currentItem) { //这里避免响应链调用太长
        if (_currentItem.preItem) {
            [_currentItem.preItem dealForOutOff:off];
        }else {
            [_currentItem dealForOutOff:off];
        }
    }else {
        TTMenuSegItem *item = [self.items firstObject];
        [item dealForOutOff:off];
    }
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
    [self refreshSuperHeight];
}

- (void)refreshSuperHeight {
    
    CGRect indicatorFrame = self.indicatorView.frame;
    indicatorFrame.origin.y = self.bounds.size.height - self.indicatorHeight - self.indicatorBottomPadd;
    self.indicatorView.frame = indicatorFrame;
    
    TTMenuSegItem *item = [self.items firstObject];
    item.superHeight = CGRectGetHeight(self.bounds);
    
    
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    CGRect indicatorFrame = self.indicatorView.frame;
    indicatorFrame.origin.y = self.bounds.size.height - self.indicatorHeight - self.indicatorBottomPadd;
    self.indicatorView.frame = indicatorFrame;
    self.scrollView.frame = self.bounds;
    [self refreshSuperHeight];
}

- (void)ttMenuSegItemSelected:(TTMenuSegItem *)item {
    
    if (_currentOff == item.expectOutOff) {
        return;
    }
    _shouldReciveScroll = NO;
    self.touchExpectOff = item.expectOutOff;
    
    if (item != _currentItem) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.currentItem reset:YES];
            [self setOutOff:item.expectOutOff];
        } completion:^(BOOL finished) {
            self.shouldReciveScroll = YES;
        }];
       
    }
    self.currentItem = item;
    [self.delegate ttMenuSegItemSelected:item];
    
    
//    [self.items.firstObject reload];
}

- (void)addSubView:(UIView *)view { 
    [super addSubview:view];
}

+ (instancetype)ttDefaultSegWithStrings:(NSArray<NSString *> *)items {
    
    NSArray *segItems = [self ttDefaultItemsWithStrings:items];
    TTMenuSeg *seg = [[TTMenuSeg alloc] initWithItems:segItems];
    return seg;
}

+ (NSArray *)ttDefaultItemsWithStrings:(NSArray<NSString *> *)items {
    NSMutableArray *segItems = [NSMutableArray array];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    for (NSString *str in items) {
        TTMenuSegItem *item = [[TTMenuSegItem alloc] init];
        item.fontName = @"PingFangSC-Semibold";
        item.selectFontSize = 24;
        item.defaultFontSize = 16;
        item.title = str;
        item.outWidth = width;
        [segItems addObject:item];
    }
    return segItems;;
}

- (NSInteger)selectedIndex {
    for (int i = 0; i <self.items.count; i ++) {
        TTMenuSegItem *item = [self.items objectAtIndex:i];
        if ([item isOffMyDeal:self.currentOff]) {
            return i;;
        }
    }
    return 0;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
}

/**滚动的锚点*/
- (CGFloat)segScrollAnchor {
    return [self bounds].size.width / 2;
}

- (CGFloat)currentScrollOff {
    return self.scrollView.contentOffset.x;
}

/** 内容滚动 */
- (void)scrollOffX:(CGFloat)xOff {
    
    CGFloat scrollWidth = _scrollView.contentSize.width;
    CGFloat segWidth = self.bounds.size.width;
    CGFloat maxX = scrollWidth - segWidth;
    if (xOff > maxX) {
        [self.scrollView setContentOffset:(CGPointMake(maxX, 0))];
        return;
    }
    if (xOff == 0) {
            [self.scrollView setContentOffset:(CGPointMake(0, 0)) animated:YES];
    }else {
        [self.scrollView setContentOffset:(CGPointMake(xOff, 0))];
    }
}

- (void)setContentWidth:(CGFloat)width {
    CGFloat scrollWidth = width + _inset.left + _inset.right;
    self.scrollView.contentSize = CGSizeMake(scrollWidth, self.bounds.size.height);
    self.scrollView.scrollEnabled = scrollWidth > self.bounds.size.width;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.scrollView.backgroundColor = backgroundColor;
}

- (void)addDecorator:(TTMenuSegDecrator *)decorator {
    [self.scrollView addSubview:decorator];
}
@end
