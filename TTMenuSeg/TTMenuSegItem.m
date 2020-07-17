//
//  TTMenuSegItem.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegItem.h"

#import "TTMenuSegHeader.h"
#import "TTMenuSeg.h"

@interface TTMenuSegItem()

@property (nonatomic, assign) CGSize selectedSize;

@property (nonatomic, assign) CGSize defaultSize;

@property (nonatomic, assign) CGRect lastFrame;

@property (nonatomic, assign) BOOL isSizeCaclulated;

/**宽度比*/
@property (nonatomic, assign) CGFloat widthDegree;

/**高度比*/
@property (nonatomic, assign) CGFloat heightDegree;

/**选中的颜色*/
@property (nonatomic, assign) TTMenuSegColor sColor;

/**默认的颜色*/
@property (nonatomic, assign) TTMenuSegColor dColor;

/**两个颜色的差值*/
@property (nonatomic, assign) TTMenuSegColor offColor;


@property (nonatomic, assign) NSInteger index;

/**所有的装饰器*/
@property (nonatomic, strong) NSMutableArray * allDecorators;

@end

@implementation TTMenuSegItem



- (instancetype)init {
    if (self = [super init]) {
        self.allDecorators = [NSMutableArray array];
        self.degree = 0;
        self.inset = UIEdgeInsetsMake(0, 6, 0, 6);
        _sColor.r = 0.12;
        _sColor.g = 0.12;
        _sColor.b = 0.13;
        _sColor.a = 1;
        
        _dColor.r = 0.6;
        _dColor.g = 0.64;
        _dColor.b = 0.7;
        _dColor.a = 1;
        
        [self genOffColor];
    }
    return self;
}

- (void)setNextItem:(TTMenuSegItem *)nextItem {
    _nextItem = nextItem;
    nextItem.index = self.index + 1;
}

- (void)layOutWithX:(CGFloat)x {
    [self layOutWithX:x forceUpdate:NO];
}

/**是否强制刷新后面的*/
- (void)layOutWithX:(CGFloat)x forceUpdate:(BOOL)force{

    CGFloat startX = x;
    self.startX = x;
    
    /**这里计算真正的宽高*/
    CGFloat widthOff = _selectedSize.width - _defaultSize.width;
    CGFloat heightOff = _selectedSize.height - _defaultSize.height;
    CGFloat width = _defaultSize.width + _degree * widthOff;
    CGFloat height = _defaultSize.height + _degree * heightOff;
    
    CGFloat top = (_superHeight - height) / 2;
    top = top + _inset.top;
    CGRect frame = CGRectMake(_startX, top, width, height);
    
    startX = startX + frame.size.width;
    startX = startX + self.inset.left;
    startX = startX + self.inset.right;
    
    if (!CGRectEqualToRect(frame, self.lastFrame)) {
        [self.delegate setFrame:frame];
        [self.delegate setDegreeSize:(_widthDegree + (_degree * (1-_widthDegree))) height:(_heightDegree + (_degree * (1-_heightDegree)))];
        self.lastFrame = frame;
        [self caculateDecorators];
       
        [self.nextItem layOutWithX:startX forceUpdate:force];
         [_delegate setTitleColor:[self currentColor]];
    }else {
        if (force) {
            [self.nextItem layOutWithX:startX forceUpdate:force];
        }
    }
}

- (void)caculateDecorators {
    for (TTMenuSegDecrator *dec in self.allDecorators) {
        if (!dec.superview) {
            [self.seger addSubView:dec];
        }
        [dec caculateFrameWithOrg:_lastFrame degree:_degree];
        
    }
}

- (void)dealForOutOff:(CGFloat)off {
    if ([self isOffMyDeal:off]) {

        CGFloat offed = off - _expectOutOff;
        if (!_nextItem) {
            if (offed > 0) {
                return;
            }
        }
        _degree = offed / _outWidth;
        _nextItem.degree = _degree;
        self.degree = 1- _degree;
        [self layOutWithX:_startX];
        
        //指示器逻辑
        CGFloat orgDegree = 1 - _degree;
        
        CGFloat iMinWidth = [self.seger indicatorWidthMin];
        CGFloat iMaxWidth = [self.seger indicatorWidthMax];
        CGFloat iWidthOff = iMaxWidth - iMinWidth;
                
        CGFloat iWidthDegree = orgDegree > 0.5 ? _degree/0.5 : orgDegree / 0.5;
        CGFloat iWidth = iWidthOff * iWidthDegree + iMinWidth;//计算真正的指示器宽度
        UIView * i = [self.seger indicatorView];
        
        
        CGFloat centerX = _lastFrame.origin.x + _lastFrame.size.width / 2;
        CGFloat nCenterX = _nextItem.lastFrame.origin.x + _nextItem.lastFrame.size.width / 2;
        CGFloat centerOff = nCenterX - centerX;//中心的距离
        CGFloat iCenterX = centerX + centerOff * orgDegree;
        
        CGRect iFrame = i.frame;
        iFrame.origin.x = iCenterX - iWidth / 2;
        iFrame.size.width = iWidth;
        i.frame = iFrame;
        
        [_delegate setTitleColor:[self currentColor]];
        
        [_nextItem.nextItem reset:YES];//将无关的item重置保证点击的正确性
        
    }else {
        if (!_preItem) {
            if (off < self.expectOutOff) {
                return;
            }
        }
        [self reset:NO];
        [_nextItem dealForOutOff:off];
    }
}

- (UIColor *)currentColor {
    CGFloat r = _dColor.r + _offColor.r * _degree;
    CGFloat g = _dColor.g + _offColor.g * _degree;
    CGFloat b = _dColor.b + _offColor.b * _degree;
    CGFloat a = _dColor.a + _offColor.a * _degree;
    NSLog(@"the r g b a is %f,%f %f %f",r,g,b,a);
    return  [UIColor colorWithRed:r green:g blue:b alpha:a];
}

/**是否向下传递*/
- (void)reset:(BOOL)forward {
    self.degree = 0;
    /**这里计算真正的宽高*/
    
    CGFloat widthOff = _selectedSize.width - _defaultSize.width;
    CGFloat heightOff = _selectedSize.height - _defaultSize.height;
    CGFloat width = _defaultSize.width + _degree * widthOff;
    CGFloat height = _defaultSize.height + _degree * heightOff;
    
    CGFloat top = (_superHeight - height) / 2;
    top = top + _inset.top;
    CGRect frame = CGRectMake(_startX, top, width, height);
    
    CGFloat startX = _startX;
    startX = startX + frame.size.width;
    startX = startX + self.inset.left;
    startX = startX + self.inset.right;
    _nextItem.startX  = startX;
    if (!CGRectEqualToRect(frame, self.lastFrame)) {
        [self.delegate setFrame:frame];
        [self.delegate setDegreeSize:(_widthDegree + (_degree * (1-_widthDegree))) height:(_heightDegree + (_degree * (1-_heightDegree)))];
        self.lastFrame = frame;
        [self caculateDecorators];
        [_delegate setTitleColor:[self currentColor]];
    }
    if (forward) {
        [_nextItem reset:YES];
    }
}



- (void)initialSizes {
    if (self.isSizeCaclulated) {
        return;
    }
    self.isSizeCaclulated = YES;
    UIFont *font = [UIFont fontWithName:self.fontName size:self.selectFontSize];
    CGRect rect = [self.title boundingRectWithSize:CGSizeMake(1000,1000)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{ NSFontAttributeName:font }
                                           context:nil];
    
    self.selectedSize = rect.size;
    
    font = [UIFont fontWithName:self.fontName size:self.defaultFontSize];
    rect = [self.title boundingRectWithSize:CGSizeMake(1000,1000)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:@{ NSFontAttributeName:font }
                                    context:nil];
    self.defaultSize = rect.size;
    
    _widthDegree = _defaultSize.width / _selectedSize.width;
    _heightDegree = _defaultSize.height / _selectedSize.height;
        
}

- (BOOL)isOffMyDeal:(CGFloat)off {
    if (off >= _expectOutOff && off < (_expectOutOff + _outWidth)) {
        return YES;
    }
    return NO;
}


- (void)initialExpectOff:(CGFloat)off {
    self.expectOutOff = off;
    [_nextItem initialExpectOff:off + _outWidth];
}

- (void)setSuperHeight:(CGFloat)superHeight {
    if (_superHeight != superHeight) {
        _superHeight = superHeight;
        _nextItem.superHeight = superHeight;
        if (!_preItem) {
            [self layOutWithX:_startX];
        }
    }else {
        if (_nextItem.superHeight != superHeight) {
            _nextItem.superHeight = superHeight;
        }
    }
}

- (void)reload {
    [self layOutWithX:self.startX forceUpdate:YES];
}

- (void)setDegree:(CGFloat)degree {
    _degree = degree;
    [self.progresser ttMenuSegItemProgressChaneg:self];
}

- (void)setSelectedColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    _sColor.r = r;
    _sColor.g = g;
    _sColor.b = b;
    _sColor.b = a;
    [self genOffColor];
}

- (void)setDefaultColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    _dColor.r = r;
    _dColor.g = g;
    _dColor.b = b;
    _dColor.b = a;
    [self genOffColor];
}

- (void)genOffColor{
    _offColor.r = _sColor.r - _dColor.r;
    _offColor.g = _sColor.g - _dColor.g;
    _offColor.b = _sColor.b - _dColor.b;
    _offColor.a = _sColor.a - _dColor.a;
}

- (void)addDecrator:(TTMenuSegDecrator *)decrator {
    if (self.seger) {
        if ([self.seger respondsToSelector:@selector(addSubview:)]) {
            TTMenuSeg *se = self.seger;
            [se addSubview:decrator];
        }else {
            NSLog(@"what happen");
        }
    }
    [self.allDecorators addObject:decrator];
}
@end
