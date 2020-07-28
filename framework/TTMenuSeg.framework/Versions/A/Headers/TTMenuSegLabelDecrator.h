//
//  TTMenuSegLabelDecrator.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/17.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegDecrator.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTMenuSegLabelDecrator : TTMenuSegDecrator

//字体大小计算宽高
@property (nonatomic, copy) NSString * fontName;

/**默认的组件字体大小*/
@property (nonatomic, assign) CGFloat defaultFontSize;

/**选中的时候的组件大小*/
@property (nonatomic, assign) CGFloat selectFontSize;

- (void)setSelectedColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

- (void)setDefaultColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

@property (nonatomic, copy) NSString * content;

@end

NS_ASSUME_NONNULL_END
