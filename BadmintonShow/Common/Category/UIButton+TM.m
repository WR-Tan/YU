//
//  UIButton+TM.m
//  WriteNote
//
//  Created by wihing on 14-4-20.
//  Copyright (c) 2014年 wihing. All rights reserved.
//

#import "UIButton+TM.h"
#import <objc/runtime.h>

@implementation UIButton (TM)

- (void)addTarget:(id)target forControlEvents:(UIControlEvents)controlEvents action:(sender_block)action
{
    objc_setAssociatedObject(self, @"action", action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(actionProxy:) forControlEvents:controlEvents];
}

- (void)actionProxy:(id)sender
{
    sender_block action = objc_getAssociatedObject(self, @"action");
    if (action) {
        action(self);
    } else {
        
    }
}

@end
