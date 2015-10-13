//
//  UIButton+TM.h
//  WriteNote
//
//  Created by wihing on 14-4-20.
//  Copyright (c) 2014年 wihing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sender_block)(id sender);


@interface UIButton (TM)

- (void)addTarget:(id)target forControlEvents:(UIControlEvents)controlEvents action:(sender_block)action;

@end
