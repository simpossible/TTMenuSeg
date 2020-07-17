//
//  TTMenuSegLabelDecrator.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/17.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegLabelDecrator.h"
#import "TTMenuSegHeader.h"

@interface TTMenuSegLabelDecrator()

@property (nonatomic, strong) UILabel * label;

/**选中的颜色*/
@property (nonatomic, assign) TTMenuSegColor sColor;

/**默认的颜色*/
@property (nonatomic, assign) TTMenuSegColor dColor;

/**两个颜色的差值*/
@property (nonatomic, assign) TTMenuSegColor offColor;




@end

@implementation TTMenuSegLabelDecrator

- (instancetype)init {
    if (self = [super init]) {
        _sColor.r = 0.12;
        _sColor.g = 0.12;
        _sColor.b = 0.13;
        _sColor.a = 1;
        
        _dColor.r = 0.6;
        _dColor.g = 0.64;
        _dColor.b = 0.7;
        _dColor.a = 1;
        
        [self genOffColor];
        
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
    }
    return self;
}


- (void)initial {
    UIFont * selectFont = [UIFont fontWithName:self.fontName size:self.selectFontSize];
    UIFont * defaultFont = [UIFont fontWithName:self.fontName size:self.defaultFontSize];
    
   CGRect rect = [self.content boundingRectWithSize:(CGSizeMake(1000, 1000)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:selectFont} context:nil];
    self.selectedSize = rect.size;

    
    rect = [self.content boundingRectWithSize:(CGSizeMake(1000, 1000)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:defaultFont} context:nil];
    self.defaultSize = rect.size;
    
    self.label.font = selectFont;
    self.label.text = self.content;
    self.label.textColor = [self currentColor];
}

- (void)caculateFrameWithOrg:(CGRect)frame degree:(CGFloat)degree {
    [super caculateFrameWithOrg:frame degree:degree];    
    
    CGFloat widthDegree = _widthDegree + degree * (1-_widthDegree);
    CGFloat heightDegree = _heightDegree + degree * (1-_heightDegree);
    self.label.transform = CGAffineTransformMakeScale(widthDegree, heightDegree);
    //    self.label.transform = CGAffineTransformMake(widthDegree, 0, 0, heightDegree, 0, 0);
    self.label.frame = self.bounds;
    self.label.textColor = [self currentColor];
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


- (void)setContent:(NSString *)content {
    if (![_content isEqualToString:content]) {
        _content = content;
        [self initial];
    }
}

- (UIColor *)currentColor {
    CGFloat r = _dColor.r + _offColor.r * _degree;
    CGFloat g = _dColor.g + _offColor.g * _degree;
    CGFloat b = _dColor.b + _offColor.b * _degree;
    CGFloat a = _dColor.a + _offColor.a * _degree;
    return  [UIColor colorWithRed:r green:g blue:b alpha:a];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
