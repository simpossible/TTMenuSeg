//
//  TTMenuSeqTestCell.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/22.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSeqTestCell.h"

@implementation TTMenuSeqTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFuncType:(NSUInteger)funcType {
    _funcType = funcType;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
