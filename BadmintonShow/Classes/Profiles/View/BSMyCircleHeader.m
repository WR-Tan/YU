//
//  BSMyCircleHeader.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/6.
//  Copyright © 2016年 LZH. All rights reserved.
//

#import "BSMyCircleHeader.h"

@implementation BSMyCircleHeader

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSMyCircleHeader" owner:nil options:nil] lastObject];
    self.frame = CGRectMake(0, 0, kScreenWidth, 80);
    return self;
}

- (IBAction)jionCircleAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(circleHeader:didClickJionCircleAction:)]) {
        [self.delegate circleHeader:self didClickJionCircleAction:sender];
    }
}

- (IBAction)createCircle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(circleHeader:didClickCreateCricleAction:)]) {
        [self.delegate circleHeader:self didClickCreateCricleAction:sender];
    }
}


@end
