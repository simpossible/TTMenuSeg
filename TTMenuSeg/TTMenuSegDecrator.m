//
//  TTMenuSegDecrator.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/17.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegDecrator.h"

@interface TTMenuSegDecrator(){
  
}


/**宽度比*/
@property (nonatomic, assign) CGFloat widthDegree;

/**高度比*/
@property (nonatomic, assign) CGFloat heightDegree;

@end

@implementation TTMenuSegDecrator

- (instancetype)init {
    if (self = [super init]) {
        _degree = 1;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelectedSize:(CGSize)selectedSize {
    _selectedSize = selectedSize;
    
    _offWidth = _selectedSize.width - _defaultSize.width;
    _offHeight = _selectedSize.height - _defaultSize.height;
    _widthDegree = _defaultSize.width / _selectedSize.width;
    _heightDegree = _defaultSize.height / _selectedSize.height;
}

- (void)setDefaultSize:(CGSize)defaultSize {
    _defaultSize = defaultSize;
    _offWidth = _selectedSize.width - _defaultSize.width;
    _offHeight = _selectedSize.height - _defaultSize.height;
    _widthDegree = _defaultSize.width / _selectedSize.width;
    _heightDegree = _defaultSize.height / _selectedSize.height;
}

- (void)setDegree:(CGFloat)degree {
    
}

- (void)caculateFrameWithOrg:(CGRect)frame degree:(CGFloat)degree {
    _degree = degree;
    CGFloat myWidth = _defaultSize.width + _offWidth * degree;
    CGFloat myHeight = _defaultSize.height + _offHeight  * degree;
    CGFloat maxX = frame.origin.x + frame.size.width * _postion.x;
    CGFloat maxY = frame.origin.y + frame.size.height * _postion. y;
    
    CGRect myFrame = CGRectMake(maxX, maxY, myWidth, myHeight);
    self.frame = myFrame;    
}

@end
