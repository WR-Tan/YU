//
//  XLView.m
//  TingShuo
//
//  Created by czh0766 on 12-8-21.
//
//

#import "WWView.h"

@implementation WWView

@synthesize delegate = _delegate;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if ([_delegate respondsToSelector:@selector(viewWillMove:toSuperview:)]) {
        [_delegate viewWillMove:self toSuperview:newSuperview];
    }
}

- (void)didMoveToSuperview {
    if ([_delegate respondsToSelector:@selector(viewDidMoveToSuperview:)]) {
        [_delegate viewDidMoveToSuperview:self];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if ([_delegate respondsToSelector:@selector(viewWillMove:toWindow:)]) {
        [_delegate viewWillMove:self toWindow:newWindow];
    }
}

- (void)didMoveToWindow {
    if ([_delegate respondsToSelector:@selector(viewDidMoveToWindow:)]) {
        [_delegate viewDidMoveToWindow:self];
    }
}

@end
