//
//  TTMenuSegView.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegView.h"
#import "TTMenuSegLabel.h"

@interface TTMenuSegView()

@property (nonatomic, strong) UIControl * containerView;

@property (nonatomic, strong) TTMenuSegLabel * label;

@end

@implementation TTMenuSegView

- (instancetype)init {
    if (self = [super init]) {
        [self initialUI];
    }
    return self;;
}

- (void)setSegItem:(TTMenuSegItem *)segItem {
    [segItem initialSizes];
    _segItem = segItem;
    _segItem.delegate = self;
    
    self.label.text = segItem.title;
    self.label.font = [UIFont fontWithName:segItem.fontName size:segItem.selectFontSize];
}


- (void)initialUI {
    self.containerView = [[UIControl alloc] init];
    [self addSubview:self.containerView];
    
    self.label = [[TTMenuSegLabel alloc] init];
    [self.containerView addSubview:self.label];
    
    [self.containerView addTarget:self action:@selector(containerClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.containerView.frame =self.bounds;
    
    self.label.frame = CGRectMake(0, 0, self.segItem.selectedSize.width, self.segItem.selectedSize.height);
}


- (void)setDegreeSize:(CGFloat)widthDegree height:(CGFloat)heightDegree {
    self.label.transform = CGAffineTransformMakeScale(widthDegree, heightDegree);
//    self.label.transform = CGAffineTransformMake(widthDegree, 0, 0, heightDegree, 0, 0);
    self.label.contentMode = UIViewContentModeScaleToFill;
    self.label.frame = self.containerView.bounds;
}

- (void)setDegree:(CGFloat)degree {
    
    self.containerView.transform = CGAffineTransformMakeScale(degree, degree);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)containerClicked:(id)sender {
    [self.segItem.seger ttMenuSegItemSelected:self.segItem];
}

@end
