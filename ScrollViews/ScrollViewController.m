//
//  ScrollViewController.m
//  ScrollViews
//
//  Created by dmi on 19/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewController

@synthesize scrollView = _scrollView;

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return _scrollView;
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
