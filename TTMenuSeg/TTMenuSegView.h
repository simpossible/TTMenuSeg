//
//  TTMenuSegView.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMenuSegItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTMenuSegView : UIView<TTMenuSegItemProtocol>

@property (nonatomic, strong) TTMenuSegItem * segItem;

- (void)setDegree:(CGFloat)degree;


@end

NS_ASSUME_NONNULL_END
