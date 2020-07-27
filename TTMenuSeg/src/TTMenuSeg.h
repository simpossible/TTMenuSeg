//
//  TTMenuSeg.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMenuSegItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TTMenuSegDelegate <NSObject>

- (void)ttMenuSegItemSelected:(TTMenuSegItem *)item;

@end

@interface TTMenuSeg : UIView

@property (nonatomic, weak) id<TTMenuSegDelegate> delegate;

- (instancetype)initWithItems:(NSArray<TTMenuSegItem *> *)items;

/**指示器最大长度*/
@property (nonatomic, assign) CGFloat indicatorWidthMax;

/**指示器最小长度*/
@property (nonatomic, assign) CGFloat indicatorWidthMin;

/**指示器高度*/
@property (nonatomic, assign) CGFloat indicatorHeight;

/**距离底部多少*/
@property (nonatomic, assign) CGFloat indicatorBottomPadd;

@property (nonatomic, strong) UIColor * indicatorColor;

/**指示器圆角*/
@property (nonatomic, assign) CGFloat indeicatorCorner;

/**外部的滚动off*/
- (void)setOutOff:(CGFloat)off;


+ (instancetype)ttDefaultSegWithStrings:(NSArray<NSString *> *)items;

- (TTMenuSegItem *)itemAtIndex:(NSInteger)i;

- (NSInteger)selectedIndex;

- (void)addDecorator:(TTMenuSegDecrator *)decorator;
@end

NS_ASSUME_NONNULL_END
