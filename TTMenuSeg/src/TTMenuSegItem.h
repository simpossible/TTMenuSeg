//
//  TTMenuSegItem.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTMenuSegDecrator.h"


@class TTMenuSegItem;
@class TTMenuSegView;
@protocol TTMenuSegItemProtocol <NSObject>

- (void)setFrame:(CGRect)frame;

- (CGRect)frame;
/**title 需要被放大缩小的背书*/
- (void)setDegreeSize:(CGFloat)widthDegree height:(CGFloat)heightDegree;

- (void)setDegree:(CGFloat)degree;

- (void)setTitleColor:(UIColor *)color;

- (void)refreshItem;

- (void)removeFromSuperview;

@end

@protocol TTMenuSegItemSeger <NSObject>

/**指示器*/
- (UIView *)indicatorView;

- (CGFloat)indicatorHeight;

- (CGFloat)indicatorWidthMax;

- (CGFloat)indicatorWidthMin;

- (void)ttMenuSegItemSelected:(TTMenuSegItem *)item;

- (void)addSubView:(UIView *)view;

/**滚动的锚点*/
- (CGFloat)segScrollAnchor;

- (CGFloat)currentScrollOff;

/** 内容滚动 */
- (void)scrollOffX:(CGFloat)xOff;

- (void)setContentWidth:(CGFloat)width;

- (void)setCurrentItem:(TTMenuSegItem *)currentItem;

- (void)addDecorator:(TTMenuSegDecrator *)decorator;

@end

@protocol TTMenuSegItemProgress <NSObject>

- (void)ttMenuSegItemProgressChaneg:(TTMenuSegItem *)item;

@end


@interface TTMenuSegItem : NSObject

@property (nonatomic, weak) id<TTMenuSegItemProgress> progresser;

@property (nonatomic, weak) id<TTMenuSegItemSeger> seger;

@property (nonatomic, weak) id<TTMenuSegItemProtocol> delegate;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, weak) TTMenuSegItem * nextItem;

@property (nonatomic, weak) TTMenuSegItem * preItem;

@property (nonatomic, assign, readonly) NSInteger index;

@property (nonatomic, assign) CGFloat startX;

@property (nonatomic, assign, readonly) CGRect lastFrame;

/**允许用户传入上下文对象*/
@property (nonatomic, weak) id context;

//字体大小计算宽高
@property (nonatomic, copy) NSString * fontName;

/**默认的组件字体大小*/
@property (nonatomic, assign) CGFloat defaultFontSize;

/**选中的时候的组件大小*/
@property (nonatomic, assign) CGFloat selectFontSize;

/**最终的选中时的大小*/
@property (nonatomic, assign, readonly) CGSize selectedSize;

/**最终的未选中时的大小*/
@property (nonatomic, assign, readonly) CGSize defaultSize;

/**不包含padding*/
@property (nonatomic, assign, readonly) CGSize orgSelectedSize;

/**不包含padding*/
@property (nonatomic, assign, readonly) CGSize orgDefaultSize;

@property (nonatomic, assign) UIEdgeInsets padding;

- (void)setSelectedColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

- (void)setDefaultColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

/** 从 defaul 到 select 的进度 0 - 1 */
@property (nonatomic, assign) CGFloat degree;

@property (nonatomic, assign) CGFloat superHeight;

/// 边距
@property (nonatomic, assign) UIEdgeInsets inset;

/*------------------------------------------------------------*/
/**外部的宽度 这个item对应的外部宽度 pagewidth*/
@property (nonatomic, assign) CGFloat outWidth;

/**外部的起点*/
@property (nonatomic, assign) CGFloat expectOutOff;


- (void)addDecrator:(TTMenuSegDecrator *)decrator;

- (void)initialSizes;

- (void)layOutWithX:(CGFloat)x;


/**处理当前外部的off*/
- (void)dealForOutOff:(CGFloat)off;

/**是否是我处理的外部偏移量*/
- (BOOL)isOffMyDeal:(CGFloat)off;

- (void)initialExpectOff:(CGFloat)off;

- (void)setSuperHeight:(CGFloat)superHeight;

- (void)reload;

- (Class)itemViewClass;

- (void)reset:(BOOL)forward;

- (TTMenuSegView *)getSegView;

/**必须是 TTMenuSegView 的子类*/
- (void)registSegView:(Class)cls;

- (void)clear;
@end
