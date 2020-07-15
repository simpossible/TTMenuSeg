//
//  TTMenuSegLabel.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "TTMenuSegLabel.h"

@implementation TTMenuSegLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame {
    if (frame.size.width == 72) {
        NSLog(@"00");
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    if (bounds.size.width == 72) {
        NSLog(@"00");
    }
    [super setBounds:bounds];
}

@end
