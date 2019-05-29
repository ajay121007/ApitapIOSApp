//
//  LabelPadding.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 12/23/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "LabelPadding.h"

@implementation LabelPadding

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
