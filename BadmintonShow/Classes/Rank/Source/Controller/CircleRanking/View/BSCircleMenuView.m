//
//  BSCircleMenuView.m
//  BadmintonShow
//
//  Created by lizhihua on 12/24/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleMenuView.h"

@interface BSCircleMenuView ()
@end

@implementation BSCircleMenuView

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSCircleMenuView" owner:nil options:nil] lastObject];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
    return self;
}

+ (BSCircleMenuView *)menuView {
    BSCircleMenuView *menuView = [[BSCircleMenuView alloc] init];
    CGFloat width = 100;
    CGFloat height = 80;
    CGFloat x = kScreenWidth - width - 5;
    CGFloat y = 5;
    menuView.frame = CGRectMake(x, y, width, height);
    return menuView;
}


- (IBAction)jionActino:(id)sender {
    if ([self.delegate respondsToSelector:@selector(menu:didClickIndex:)]) {
        [self.delegate menu:self didClickIndex:0];
    }
}

- (IBAction)createAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(menu:didClickIndex:)]) {
        [self.delegate menu:self didClickIndex:1];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
