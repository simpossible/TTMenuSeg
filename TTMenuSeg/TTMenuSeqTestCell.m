//
//  TTMenuSeqTestCell.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/22.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSeqTestCell.h"

@interface TTMenuSeqTestCell()

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation TTMenuSeqTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 13, self.frame.size.width, 20))];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textColor  = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"" size:12];
    }
    return self;
}

- (void)setFuncType:(TTMenuSeqFunType)funcType {
    _funcType = funcType;
    if (funcType == TTMenuSeqFunTypeBase) {
        self.titleLabel.text = @"基础使用";
    }else if (funcType == TTMenuSeqFunTypeDecorater) {
        self.titleLabel.text = @"头部装饰";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
