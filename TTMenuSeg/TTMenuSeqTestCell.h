//
//  TTMenuSeqTestCell.h
//  TTMenuSeg
//
//  Created by simp on 2020/7/22.
//  Copyright © 2020 simp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger,TTMenuSeqFunType) {
    TTMenuSeqFunTypeBase,
    TTMenuSeqFunTypeDecorater,
    TTMenuSeqFunTypeCount
};

@interface TTMenuSeqTestCell : UITableViewCell


@property (nonatomic, assign) TTMenuSeqFunType funcType;

@end

NS_ASSUME_NONNULL_END
