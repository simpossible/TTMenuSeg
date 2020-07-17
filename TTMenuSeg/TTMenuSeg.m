//
//  TTMenuSeg.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSeg.h"
#import "TTMenuSegView.h"

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

@end

@implementation TTMenuSeg


- (instancetype)initWithItems:(NSArray<TTMenuSegItem *> *)items {
    if (self = [super init]) {
        _shouldReciveScroll = YES;
        _indicatorColor = [UIColor whiteColor];
        _indicatorHeight = 4;
        _indicatorWidthMin = 12;
        _indicatorWidthMax = 24;
        _indeicatorCorner = 2;
        self.items = items;
    }
    return self;
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
    TTMenuSegItem *preItem = nil;
    for (int i = 0; i < self.items.count; i ++) {
        TTMenuSegItem *item =  [self.items objectAtIndex:i];
        item.seger = self;
        item.preItem = preItem;
        preItem.nextItem = item;
        
        TTMenuSegView *segView = [[TTMenuSegView alloc] init];
        segView.segItem = item;
        [self addSubview:segView];
        preItem = item;
    }
    TTMenuSegItem *item = [self.items firstObject];
    [item layOutWithX:16];
    [item initialExpectOff:0];    
}

- (void)initialIndicatorView {
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.indicatorWidthMin, self.indicatorHeight)];
    [self addSubview:self.indicatorView];
    self.indicatorView.backgroundColor = self.indicatorColor;
    self.indicatorView.layer.cornerRadius = self.indeicatorCorner;
    self.indicatorView.layer.masksToBounds = YES;
    
}


- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    _indicatorHeight = indicatorHeight;
    _indeicatorCorner = indicatorHeight / 2;
}

- (void)setOutOff:(CGFloat)off {
    if (off == _touchExpectOff) {
        _shouldReciveScroll = YES;
    }
//    if (_shouldReciveScroll) {
        _currentOff = off;
        TTMenuSegItem *item = [self.items firstObject];
        [item dealForOutOff:off];
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
    [self refreshSuperHeight];
}

- (void)ttMenuSegItemSelected:(TTMenuSegItem *)item {
    
    if (_currentOff == item.expectOutOff) {
        return;
    }
    _shouldReciveScroll = NO;
    self.touchExpectOff = item.expectOutOff;
    [self.delegate ttMenuSegItemSelected:item];
    
//    [self.items.firstObject reload];
}

+ (instancetype)ttDefaultSegWithStrings:(NSArray<NSString *> *)items {
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
    
    TTMenuSeg *seg = [[TTMenuSeg alloc] initWithItems:segItems];
    return seg;
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

@end
