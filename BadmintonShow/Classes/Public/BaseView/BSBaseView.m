//
//  BSBaseView.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseView.h"

@implementation BSBaseView


- (void)setObject:(id)object {
    _object = object;
    [self displayWithItem:object];
}

- (void)displayWithItem:(id)object {
    // 子类重写
}


@end
