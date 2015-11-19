//
//  BSChatMatchView.m
//  BadmintonShow
//
//  Created by LZH on 15/11/20.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSChatMatchView.h"

@interface BSChatMatchView()

@property (nonatomic, strong) UILabel *messageLabel;

@end


@implementation BSChatMatchView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addMyViews];
    }
    return self;
}

- (void)addMyViews
{
    _messageLabel = [[UILabel alloc]  init];
    _messageLabel.text = @"您有新的比赛结果等待确认";
    [self addSubview:_messageLabel];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];

    [_messageLabel sizeToFit];
    _messageLabel.font = [UIFont systemFontOfSize:15];
    CGSize labelSize = _messageLabel.frame.size;
    _messageLabel.frame = CGRectMake(5, 40, labelSize.width, labelSize.height);
}


@end
