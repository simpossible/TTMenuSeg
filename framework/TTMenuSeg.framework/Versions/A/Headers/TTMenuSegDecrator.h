//
//  TTMenuSegDecrator.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/17.
//  Copyright © 2020 simp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**用来作为额外的装饰 不计入本身的frame*/

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,TTMenuSegDecratorLayoutType) {
    TTMenuSegDecratorLayoutTypeRelative,
    TTMenuSegDecratorLayoutTypeAbsolute,
};

@interface TTMenuSegDecrator : UIView {
    @protected
    CGFloat _widthDegree;
    CGFloat _heightDegree;
    CGFloat _offWidth;
    CGFloat _offHeight;
    CGFloat _degree;
}


/**这里的postion 为 0-1  生成的degree rect{ x = heigt * top y = width*left} * degree */
@property (nonatomic, assign) CGPoint postion;

@property (nonatomic, assign) CGSize selectedSize;

@property (nonatomic, assign) CGSize defaultSize;

- (void)setDegree:(CGFloat)degree;

- (void)caculateFrameWithOrg:(CGRect)frame degree:(CGFloat)degree;

@end

NS_ASSUME_NONNULL_END
